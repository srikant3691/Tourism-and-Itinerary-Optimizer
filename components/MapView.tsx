"use client";
import { useEffect, useRef } from "react";

interface StopLocation {
  name: string;
  latitude: number;
  longitude: number;
  category: string;
}

interface Stop {
  location: StopLocation;
  order: number;
}

interface Day {
  dayNumber: number;
  stops: Stop[];
}

interface MapViewProps {
  days: Day[];
}

// Distinct palette for each day
const DAY_COLORS = [
  "#F5A623", "#00D4AA", "#FF6B6B", "#9B59B6",
  "#3498DB", "#2ECC71", "#E67E22", "#1ABC9C",
];

export function MapView({ days }: MapViewProps) {
  const mapRef = useRef<HTMLDivElement>(null);
  const mapInstanceRef = useRef<unknown>(null);

  useEffect(() => {
    if (typeof window === "undefined" || !mapRef.current || mapInstanceRef.current) return;

    import("leaflet").then((L) => {
      // Dynamically inject leaflet CSS
      const link = document.createElement("link");
      link.rel = "stylesheet";
      link.href = "https://unpkg.com/leaflet@1.9.4/dist/leaflet.css";
      link.integrity = "sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=";
      link.crossOrigin = "";
      document.head.appendChild(link);

      const map = L.map(mapRef.current!, {
        center: [20.2961, 85.8245],
        zoom: 7,
        zoomControl: true,
        attributionControl: true,
      });

      // Dark-themed tile layer
      L.tileLayer("https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png", {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> &copy; <a href="https://carto.com/">CARTO</a>',
        subdomains: "abcd",
        maxZoom: 19,
      }).addTo(map);

      const allCoords: [number, number][] = [];

      days.forEach((day, dayIdx) => {
        const color = DAY_COLORS[dayIdx % DAY_COLORS.length];
        const coords: [number, number][] = day.stops
          .filter((s) => s.location.latitude && s.location.longitude)
          .sort((a, b) => a.order - b.order)
          .map((s) => [s.location.latitude, s.location.longitude]);

        allCoords.push(...coords);

        // Animated polyline for day route
        if (coords.length > 1) {
          L.polyline(coords, {
            color,
            weight: 3,
            opacity: 0.85,
            dashArray: "10 6",
          }).addTo(map);
        }

        // Markers for each stop
        day.stops
          .filter((s) => s.location.latitude && s.location.longitude)
          .sort((a, b) => a.order - b.order)
          .forEach((stop, i) => {
            const iconHtml = `
              <div style="
                width:34px;height:34px;
                background:${color};
                border:2.5px solid rgba(255,255,255,0.9);
                border-radius:50%;
                display:flex;align-items:center;justify-content:center;
                font-weight:800;font-size:13px;color:white;
                box-shadow:0 3px 12px rgba(0,0,0,0.5),0 0 0 4px ${color}33;
                font-family:system-ui,sans-serif;
              ">${i + 1}</div>
            `;
            const icon = L.divIcon({
              className: "",
              html: iconHtml,
              iconSize: [34, 34],
              iconAnchor: [17, 17],
            });

            L.marker([stop.location.latitude, stop.location.longitude], { icon })
              .addTo(map)
              .bindPopup(
                `<div style="font-family:system-ui,sans-serif;padding:4px;">
                  <strong style="color:${color}">Day ${day.dayNumber} · Stop ${i + 1}</strong><br/>
                  <span style="font-size:14px;">${stop.location.name}</span><br/>
                  <span style="font-size:11px;color:#888;text-transform:capitalize;">${stop.location.category}</span>
                </div>`,
                { maxWidth: 200 }
              );
          });
      });

      // Fit bounds to show all markers
      if (allCoords.length > 0) {
        map.fitBounds(L.latLngBounds(allCoords), { padding: [48, 48] });
      }

      mapInstanceRef.current = map;
    });

    return () => {
      if (mapInstanceRef.current) {
        (mapInstanceRef.current as { remove: () => void }).remove();
        mapInstanceRef.current = null;
      }
    };
  }, [days]);

  return (
    <div
      style={{
        position: "relative",
        borderRadius: "16px",
        overflow: "hidden",
        border: "1px solid rgba(255,255,255,0.1)",
        boxShadow: "0 8px 32px rgba(0,0,0,0.4)",
      }}
    >
      <div ref={mapRef} style={{ height: "450px", width: "100%" }} />

      {/* Day legend overlay */}
      <div
        style={{
          position: "absolute",
          bottom: "16px",
          left: "16px",
          background: "rgba(10,15,30,0.85)",
          backdropFilter: "blur(12px)",
          WebkitBackdropFilter: "blur(12px)",
          border: "1px solid rgba(255,255,255,0.1)",
          borderRadius: "12px",
          padding: "12px 16px",
          display: "flex",
          gap: "12px",
          flexWrap: "wrap",
          maxWidth: "calc(100% - 32px)",
          zIndex: 1000,
        }}
      >
        {days.map((day, i) => (
          <div key={day.dayNumber} style={{ display: "flex", alignItems: "center", gap: "6px" }}>
            <div
              style={{
                width: "12px",
                height: "12px",
                borderRadius: "50%",
                background: DAY_COLORS[i % DAY_COLORS.length],
                flexShrink: 0,
              }}
            />
            <span style={{ fontSize: "12px", color: "rgba(255,255,255,0.8)", fontWeight: 600 }}>
              Day {day.dayNumber}
            </span>
          </div>
        ))}
      </div>
    </div>
  );
}

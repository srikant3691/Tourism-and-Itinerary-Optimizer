"use client";
import React, { useState } from "react";
import { 
  Landmark, 
  Shield, 
  Palmtree, 
  Waves, 
  Droplets, 
  Leaf, 
  Mountain, 
  MapPin, 
  Clock, 
  Car, 
  ChevronDown 
} from "lucide-react";

// ─── Types ────────────────────────────────────────────────────────────────────
interface Location {
  id: string;
  name: string;
  category: string;
  latitude: number;
  longitude: number;
  avgTimeSpent: number;
  costScore: number;
  description?: string;
}

interface Stop {
  order: number;
  location: Location;
  arrivalTime: string;
  departureTime: string;
  travelTimeFromPrev: number;
  distanceFromPrev: number;
}

interface DayData {
  dayNumber: number;
  totalTravelMins: number;
  totalDistanceKm: number;
  stops: Stop[];
}

interface ItineraryCardProps {
  day: DayData;
  defaultExpanded?: boolean;
}

// ─── Category Metadata ────────────────────────────────────────────────────────
// Using orange-800 for culture, cyan-800 for sea/adventure, green-700 for nature
const CATEGORY_META: Record<string, { color: string; bg: string; border: string; label: string; icon: React.ReactNode }> = {
  temple:       { color: "text-orange-800", bg: "bg-orange-50", border: "border-orange-200", label: "Temple",       icon: <Landmark className="w-4 h-4" /> },
  heritage:     { color: "text-orange-800", bg: "bg-orange-50", border: "border-orange-200", label: "Heritage",     icon: <Landmark className="w-4 h-4" /> },
  fort:         { color: "text-orange-800", bg: "bg-orange-50", border: "border-orange-200", label: "Fort",         icon: <Shield className="w-4 h-4" /> },
  
  beach:        { color: "text-cyan-800",   bg: "bg-cyan-50",   border: "border-cyan-200",   label: "Beach",        icon: <Palmtree className="w-4 h-4" /> },
  lake:         { color: "text-cyan-800",   bg: "bg-cyan-50",   border: "border-cyan-200",   label: "Lake",         icon: <Waves className="w-4 h-4" /> },
  waterfall:    { color: "text-cyan-800",   bg: "bg-cyan-50",   border: "border-cyan-200",   label: "Waterfall",    icon: <Droplets className="w-4 h-4" /> },
  
  wildlife:     { color: "text-green-700",  bg: "bg-green-50",  border: "border-green-200",  label: "Wildlife",     icon: <Leaf className="w-4 h-4" /> },
  hill_station: { color: "text-green-700",  bg: "bg-green-50",  border: "border-green-200",  label: "Hill Station", icon: <Mountain className="w-4 h-4" /> },
};

const DEFAULT_META = { 
  color: "text-slate-600", 
  bg: "bg-slate-50", 
  border: "border-slate-200", 
  label: "Attraction", 
  icon: <MapPin className="w-4 h-4" /> 
};

function getCategoryMeta(category: string) {
  return CATEGORY_META[category?.toLowerCase()] ?? DEFAULT_META;
}

// ─── Format helpers ───────────────────────────────────────────────────────────
function formatMins(mins: number): string {
  if (!mins || mins === 0) return "—";
  const h = Math.floor(mins / 60);
  const m = mins % 60;
  if (h > 0) return `${h}h ${m > 0 ? m + "m" : ""}`.trim();
  return `${m}m`;
}

// ─── Travel Connector ─────────────────────────────────────────────────────────
function TravelConnector({ mins, km }: { mins: number; km: number }) {
  if (!mins && !km) return null;
  return (
    <div className="flex items-center gap-3 py-2 ml-[15px] border-l-2 border-dashed border-slate-200 pl-4">
      <div className="flex items-center gap-1.5 bg-slate-50 border border-slate-200 rounded-full px-3 py-1 text-xs font-medium text-slate-500">
        <Car className="w-3.5 h-3.5 text-slate-400" />
        {mins > 0 && <span>{formatMins(mins)}</span>}
        {km > 0 && <span className="opacity-50">·</span>}
        {km > 0 && <span>{Math.round(km)} km</span>}
      </div>
    </div>
  );
}

// ─── Cost Badges ──────────────────────────────────────────────────────────────
function CostBadge({ score }: { score: number }) {
  return (
    <span
      className="inline-flex items-center gap-0.5 bg-slate-50 border border-slate-200 rounded-full px-2.5 py-0.5 text-xs font-bold"
      title={`Cost level: ${score}/5`}
    >
      <span className="text-slate-700">
        {"₹".repeat(score)}
      </span>
      <span className="text-slate-300">
        {"₹".repeat(5 - score)}
      </span>
    </span>
  );
}

// ─── Main Component ───────────────────────────────────────────────────────────
export function ItineraryCard({ day, defaultExpanded = true }: ItineraryCardProps) {
  const [expanded, setExpanded] = useState(defaultExpanded);
  const stops = [...day.stops].sort((a, b) => a.order - b.order);

  return (
    <div className="bg-white border border-slate-200 rounded-xl shadow-sm mb-6 overflow-hidden">
      {/* ── Header ── */}
      <button
        onClick={() => setExpanded(!expanded)}
        className={`w-full px-6 py-5 flex justify-between items-center text-left transition-colors hover:bg-slate-50 ${
          expanded ? "border-b border-slate-200" : ""
        }`}
      >
        <div className="flex items-center gap-4">
          <div className="bg-slate-900 text-white px-3 py-1.5 rounded-lg font-bold text-sm tracking-wide">
            DAY {day.dayNumber}
          </div>
          <div className="flex gap-4 text-sm text-slate-500 font-medium">
            <span className="flex items-center gap-1.5">
              <MapPin className="w-4 h-4 text-slate-400" />
              {stops.length} Stops
            </span>
            <span className="flex items-center gap-1.5">
              <Clock className="w-4 h-4 text-slate-400" />
              {formatMins(day.totalTravelMins)} Travel
            </span>
            <span className="flex items-center gap-1.5">
              <Car className="w-4 h-4 text-slate-400" />
              {Math.round(day.totalDistanceKm)} km
            </span>
          </div>
        </div>

        <div
          className={`text-slate-400 transition-transform duration-300 ${
            expanded ? "rotate-180" : "rotate-0"
          }`}
        >
          <ChevronDown className="w-5 h-5" />
        </div>
      </button>

      {/* ── Body ── */}
      {expanded && (
        <div className="p-6">
          {stops.map((stop, i) => {
            const isLast = i === stops.length - 1;
            const meta = getCategoryMeta(stop.location.category);

            return (
              <div key={stop.location.id}>
                <div className="flex gap-4">
                  {/* Timeline Column */}
                  <div className="flex flex-col items-center w-20 shrink-0">
                    <div className="text-sm font-bold text-slate-900 mb-1">
                      {stop.arrivalTime}
                    </div>
                    <div className="text-xs text-slate-500 mb-2">
                      {formatMins(stop.location.avgTimeSpent)}
                    </div>
                    
                    {/* Node Icon */}
                    <div
                      className={`w-8 h-8 rounded-full flex items-center justify-center z-10 border ${meta.bg} ${meta.border} ${meta.color}`}
                    >
                      {meta.icon}
                    </div>

                    {!isLast && (
                      <div className="w-[2px] flex-1 bg-slate-200 my-2" />
                    )}
                  </div>

                  {/* Content Column */}
                  <div className="flex-1 pb-6">
                    <div className="bg-white border border-slate-200 hover:border-slate-300 transition-colors rounded-xl p-5 shadow-sm">
                      <div className="flex justify-between items-start mb-3">
                        <h3 className="text-lg font-bold text-slate-900 font-serif">
                          {stop.location.name}
                        </h3>
                        <div className="flex gap-2">
                          <CostBadge score={stop.location.costScore} />
                          <span
                            className={`inline-flex items-center gap-1 border rounded-full px-2.5 py-0.5 text-xs font-semibold ${meta.bg} ${meta.border} ${meta.color}`}
                          >
                            {meta.label}
                          </span>
                        </div>
                      </div>

                      {stop.location.description && (
                        <p className="text-sm text-slate-500 leading-relaxed mb-4">
                          {stop.location.description}
                        </p>
                      )}

                      <div className="flex items-center gap-1.5 text-xs text-slate-500 font-medium">
                        <Clock className="w-3.5 h-3.5" />
                        Depart: {stop.departureTime}
                      </div>
                    </div>
                  </div>
                </div>

                {!isLast && (
                  <TravelConnector
                    mins={stops[i + 1].travelTimeFromPrev}
                    km={stops[i + 1].distanceFromPrev}
                  />
                )}
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}

"use client";
import React from "react";
import { Calendar, Map, Clock, Wallet } from "lucide-react";

interface MetricsSummaryProps {
  totalDays: number;
  totalDistanceKm: number;
  totalTravelTimeMins: number;
  totalCostScore: number;
}

function formatDuration(mins: number): string {
  if (!mins || mins === 0) return "0m";
  const h = Math.floor(mins / 60);
  const m = mins % 60;
  if (h > 0 && m > 0) return `${h}h ${m}m`;
  if (h > 0) return `${h}h`;
  return `${m}m`;
}

function CostBadge({ score }: { score: number }) {
  const filled = Math.min(Math.max(Math.round(score), 1), 5);
  return (
    <div className="flex gap-1 justify-center">
      {[1, 2, 3, 4, 5].map((i) => (
        <span
          key={i}
          className={`text-xl font-bold ${i <= filled ? "text-slate-900" : "text-slate-200"}`}
        >
          ₹
        </span>
      ))}
    </div>
  );
}

interface MetricCardProps {
  label: string;
  value: React.ReactNode;
  sub?: string;
  icon: React.ReactNode;
}

function MetricCard({ label, value, sub, icon }: MetricCardProps) {
  return (
    <div className="bg-white border border-slate-200 rounded-xl p-6 text-center shadow-sm hover:shadow-md transition-shadow">
      <div className="w-12 h-12 bg-slate-50 border border-slate-100 rounded-xl flex items-center justify-center text-slate-500 mx-auto mb-4">
        {icon}
      </div>
      
      <div className="text-3xl font-bold text-slate-900 mb-1">
        {value}
      </div>

      <p className="text-xs font-bold text-slate-500 tracking-wider uppercase mb-1">
        {label}
      </p>

      {sub && (
        <p className="text-xs text-slate-400">{sub}</p>
      )}
    </div>
  );
}

export function MetricsSummary({
  totalDays,
  totalDistanceKm,
  totalTravelTimeMins,
  totalCostScore,
}: MetricsSummaryProps) {
  const metrics = [
    {
      label: "Total Days",
      value: totalDays,
      sub: totalDays === 1 ? "day" : "days of exploration",
      icon: <Calendar className="w-6 h-6" />,
    },
    {
      label: "Total Distance",
      value: `${totalDistanceKm.toFixed(0)} km`,
      sub: "across Odisha",
      icon: <Map className="w-6 h-6" />,
    },
    {
      label: "Travel Time",
      value: formatDuration(totalTravelTimeMins),
      sub: "total transit",
      icon: <Clock className="w-6 h-6" />,
    },
    {
      label: "Budget Level",
      value: <CostBadge score={totalCostScore} />,
      sub: "estimated spend",
      icon: <Wallet className="w-6 h-6" />,
    },
  ];

  return (
    <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
      {metrics.map((m) => (
        <MetricCard key={m.label} {...m} />
      ))}
    </div>
  );
}

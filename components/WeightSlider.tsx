"use client";
import React from "react";

interface WeightSliderProps {
  label: string;
  value: number;
  onChange: (val: number) => void;
  description: string;
}

export function WeightSlider({ label, value, onChange, description }: WeightSliderProps) {
  return (
    <div className="mb-8">
      <div className="flex justify-between items-baseline mb-2">
        <label className="font-semibold text-slate-900">{label}</label>
        <span className="text-sm font-bold text-orange-700 bg-orange-50 px-2 py-0.5 rounded border border-orange-100">
          {value}/10
        </span>
      </div>
      
      <p className="text-xs text-slate-500 mb-4">{description}</p>
      
      <div className="relative h-2 rounded-full bg-slate-100">
        <div
          className="absolute left-0 top-0 h-full bg-orange-700 rounded-full transition-all duration-150"
          style={{ width: `${(value / 10) * 100}%` }}
        />
        <input
          type="range"
          min={0}
          max={10}
          step={1}
          value={value}
          onChange={(e) => onChange(Number(e.target.value))}
          className="absolute inset-0 w-full h-full opacity-0 cursor-pointer z-10"
        />
      </div>
    </div>
  );
}

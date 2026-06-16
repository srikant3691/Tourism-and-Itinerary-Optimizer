"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { WeightSlider } from "@/components/WeightSlider";
import { Compass } from "lucide-react";

export default function Home() {
  const router = useRouter();
  const [durationDays, setDurationDays] = useState(3);
  const [pace, setPace] = useState("MODERATE");
  const [budgetLevel, setBudgetLevel] = useState(3);
  
  const [culture, setCulture] = useState(5);
  const [nature, setNature] = useState(5);
  const [relax, setRelax] = useState(5);
  const [adventure, setAdventure] = useState(5);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const query = new URLSearchParams({
      durationDays: durationDays.toString(),
      pace,
      budgetLevel: budgetLevel.toString(),
      cultureWeight: (culture / 10).toString(),
      natureWeight: (nature / 10).toString(),
      relaxWeight: (relax / 10).toString(),
      adventureWeight: (adventure / 10).toString(),
    });
    router.push(`/itinerary?${query.toString()}`);
  };

  return (
    <main className="min-h-screen p-8 md:p-24 max-w-3xl mx-auto">
      <div className="bg-white p-8 rounded-2xl shadow-sm border border-slate-200">
        <div className="flex items-center gap-3 mb-8">
          <div className="bg-orange-800 p-2.5 rounded-lg">
            <Compass className="w-6 h-6 text-white" />
          </div>
          <h1 className="text-3xl font-serif font-bold text-slate-900">Plan Your Odisha Trip</h1>
        </div>
        
        <form onSubmit={handleSubmit} className="space-y-8">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div>
              <label className="block text-sm font-semibold mb-2">Duration (Days)</label>
              <input type="number" min={1} max={14} value={durationDays} onChange={(e) => setDurationDays(Number(e.target.value))} className="w-full border rounded-lg p-2.5" />
            </div>
            <div>
              <label className="block text-sm font-semibold mb-2">Pace</label>
              <select value={pace} onChange={(e) => setPace(e.target.value)} className="w-full border rounded-lg p-2.5">
                <option value="RELAXED">Relaxed</option>
                <option value="MODERATE">Moderate</option>
                <option value="HECTIC">Hectic</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-semibold mb-2">Budget Level</label>
              <select value={budgetLevel} onChange={(e) => setBudgetLevel(Number(e.target.value))} className="w-full border rounded-lg p-2.5">
                <option value={1}>1 - Backpacker</option>
                <option value={2}>2 - Budget</option>
                <option value={3}>3 - Standard</option>
                <option value={4}>4 - Comfort</option>
                <option value={5}>5 - Luxury</option>
              </select>
            </div>
          </div>

          <div className="border-t border-slate-100 pt-8">
            <h2 className="text-xl font-bold mb-6">Preferences</h2>
            <WeightSlider label="Culture & Heritage" value={culture} onChange={setCulture} description="Temples, monuments, history" />
            <WeightSlider label="Nature & Wildlife" value={nature} onChange={setNature} description="Parks, sanctuaries, hills" />
            <WeightSlider label="Relaxation" value={relax} onChange={setRelax} description="Beaches, lakes, easy pace" />
            <WeightSlider label="Adventure" value={adventure} onChange={setAdventure} description="Trekking, water sports" />
          </div>

          <button type="submit" className="w-full bg-orange-800 hover:bg-orange-900 text-white font-bold py-4 rounded-xl transition-colors">
            Generate Optimized Itinerary
          </button>
        </form>
      </div>
    </main>
  );
}

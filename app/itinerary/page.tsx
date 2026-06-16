import { ItineraryCard } from "@/components/ItineraryCard";
import { MetricsSummary } from "@/components/MetricsSummary";
import { MapView } from "@/components/MapView";
import { redirect } from "next/navigation";
import { runOptimizerPipeline } from "@/lib/optimizer/scheduler";

export default async function ItineraryPage({
  searchParams,
}: {
  searchParams: Promise<{ [key: string]: string | undefined }>;
}) {
  const sp = await searchParams;
  if (!sp.durationDays) redirect("/");

  const prefs = {
    durationDays: Number(sp.durationDays),
    pace: sp.pace as "RELAXED" | "MODERATE" | "HECTIC",
    budgetLevel: Number(sp.budgetLevel),
    cultureWeight: Number(sp.cultureWeight),
    natureWeight: Number(sp.natureWeight),
    relaxWeight: Number(sp.relaxWeight),
    adventureWeight: Number(sp.adventureWeight),
  };

  const itineraryRaw = await runOptimizerPipeline(prefs);

  const itinerary = {
    ...itineraryRaw,
    days: itineraryRaw.days.map(day => ({
      ...day,
      stops: day.stops.map(stop => ({
        ...stop,
        location: {
          ...stop.location,
          avgTimeSpent: stop.location.avg_time_spent,
          costScore: stop.location.cost_score,
        }
      }))
    }))
  };

  return (
    <main className="min-h-screen bg-slate-50 pb-12">
      {/* Header */}
      <div className="bg-orange-800 text-white pt-12 pb-24 px-6">
        <div className="max-w-6xl mx-auto">
          <h1 className="text-4xl font-serif font-bold mb-2">Your Odisha Itinerary</h1>
          <p className="text-orange-100 opacity-80 mb-8 font-medium tracking-wide">AI-Optimized Route & Schedule</p>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-6xl mx-auto px-6 -mt-16 grid grid-cols-1 lg:grid-cols-3 gap-8">
        <div className="lg:col-span-2 space-y-6">
          <div className="bg-white rounded-xl p-4 shadow-sm border border-slate-200">
            <MetricsSummary 
              totalDays={itinerary.totalDays} 
              totalDistanceKm={itinerary.totalDistanceKm} 
              totalTravelTimeMins={itinerary.totalTravelTimeMins} 
              totalCostScore={itinerary.totalCostScore} 
            />
          </div>
          
          {itinerary.days.map(day => (
            <ItineraryCard key={day.dayNumber} day={day} defaultExpanded={day.dayNumber === 1} />
          ))}
        </div>
        <div className="lg:col-span-1 h-[600px] sticky top-8 rounded-xl overflow-hidden shadow-sm border border-slate-200">
          <MapView days={itinerary.days} />
        </div>
      </div>
    </main>
  );
}

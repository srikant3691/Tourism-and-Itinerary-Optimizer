import { runOptimizerPipeline } from '@/lib/optimizer/scheduler';
import { query } from '@/lib/db';
import { UserPreferences } from '@/lib/optimizer/types';

export const resolvers = {
  Query: {
    optimizeItinerary: async (
      _: unknown,
      {
        input,
      }: {
        input: {
          durationDays: number;
          pace: 'RELAXED' | 'MODERATE' | 'HECTIC';
          budgetLevel: number;
          cultureWeight: number;
          natureWeight: number;
          relaxWeight: number;
          adventureWeight: number;
        };
      }
    ) => {
      const prefs: UserPreferences = { ...input };
      const result = await runOptimizerPipeline(prefs);
      return result;
    },

    locations: async () => {
      const result = await query('SELECT * FROM locations ORDER BY name');
      return result.rows.map((row) => ({
        id: row.id,
        name: row.name,
        latitude: row.latitude,
        longitude: row.longitude,
        category: row.category,
        avgTimeSpent: row.avg_time_spent,
        costScore: row.cost_score,
        description: row.description,
      }));
    },
  },
  LocationGQL: {
    avgTimeSpent: (parent: any) => parent.avg_time_spent ?? parent.avgTimeSpent,
    costScore: (parent: any) => parent.cost_score ?? parent.costScore,
  },
};

import { gql } from 'graphql-tag';

export const typeDefs = gql`
  scalar DateTime

  enum Pace {
    RELAXED
    MODERATE
    HECTIC
  }

  enum LocationCategory {
    temple
    beach
    wildlife
    hill_station
    heritage
    lake
    waterfall
    fort
  }

  input ItineraryInput {
    durationDays: Int!
    pace: Pace!
    budgetLevel: Int!      # 1-5
    cultureWeight: Float!  # 0.0 - 1.0
    natureWeight: Float!
    relaxWeight: Float!
    adventureWeight: Float!
  }

  type LocationGQL {
    id: ID!
    name: String!
    latitude: Float!
    longitude: Float!
    category: LocationCategory!
    avgTimeSpent: Int!
    costScore: Int!
    description: String
  }

  type ScheduledStop {
    order: Int!
    location: LocationGQL!
    arrivalTime: String!         # 'HH:MM'
    departureTime: String!       # 'HH:MM'
    travelTimeFromPrev: Int!     # minutes
    distanceFromPrev: Float!     # km
  }

  type ItineraryDay {
    dayNumber: Int!
    totalTravelMins: Int!
    totalDistanceKm: Float!
    stops: [ScheduledStop!]!
  }

  type OptimizedItinerary {
    totalDays: Int!
    totalDistanceKm: Float!
    totalTravelTimeMins: Int!
    totalCostScore: Int!
    days: [ItineraryDay!]!
  }

  type Query {
    optimizeItinerary(input: ItineraryInput!): OptimizedItinerary!
    locations: [LocationGQL!]!
  }
`;

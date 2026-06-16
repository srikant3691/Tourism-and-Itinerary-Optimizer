import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Required for Apollo Server 4 / graphql packages that use CJS modules
  serverExternalPackages: ["pg", "pg-pool"],

  // Enable source maps for easier debugging
  productionBrowserSourceMaps: false,

  // Headers for CORS on GraphQL endpoint (dev only)
  async headers() {
    return [
      {
        source: "/api/graphql",
        headers: [
          { key: "Access-Control-Allow-Origin", value: "*" },
          { key: "Access-Control-Allow-Methods", value: "GET, POST, OPTIONS" },
          { key: "Access-Control-Allow-Headers", value: "Content-Type" },
        ],
      },
    ];
  },
};

export default nextConfig;

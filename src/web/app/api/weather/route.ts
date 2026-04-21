import { NextRequest, NextResponse } from "next/server";

function jsonError(message: string, status: number) {
  return NextResponse.json({ error: message }, { status });
}

export async function GET(request: NextRequest) {
  const city = request.nextUrl.searchParams.get("city")?.trim();
  if (!city) {
    return jsonError("Missing city parameter.", 400);
  }

  const apiBaseUrl = process.env.WEATHER_API_BASE_URL?.trim().replace(/\/$/, "");
  if (!apiBaseUrl) {
    return jsonError("Server is missing WEATHER_API_BASE_URL configuration.", 500);
  }

  const functionKey = process.env.WEATHER_API_FUNCTION_KEY?.trim();
  const upstreamUrl = new URL(`${apiBaseUrl}/api/getWeather`);
  upstreamUrl.searchParams.set("city", city);
  if (functionKey) {
    upstreamUrl.searchParams.set("code", functionKey);
  }

  try {
    const response = await fetch(upstreamUrl, {
      method: "GET",
      headers: { Accept: "application/json" },
      cache: "no-store",
    });

    const data = await response.json().catch(() => ({ error: "Invalid API response" }));
    if (!response.ok) {
      return NextResponse.json(
        { error: data?.error ?? "Failed to fetch weather data." },
        { status: response.status },
      );
    }

    return NextResponse.json(data, { status: 200 });
  } catch {
    return jsonError("Weather service is currently unavailable.", 503);
  }
}

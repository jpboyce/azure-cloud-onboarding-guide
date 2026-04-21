 "use client";

import { FormEvent, useState } from "react";

type Weather = {
  city: string;
  country: string;
  temperature_c: number;
  temperature_f: number;
  condition: string;
  humidity: number;
  wind_kph: number;
  wind_mph: number;
  last_updated: string;
};

const CITIES = [
  "Sydney",
  "Melbourne",
  "Brisbane",
  "Perth",
  "Adelaide",
  "Hobart",
  "Darwin",
  "Canberra",
];

export default function Home() {
  const [city, setCity] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [weather, setWeather] = useState<Weather | null>(null);

  async function onSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    if (!city) {
      setError("Please select a city first.");
      return;
    }

    setLoading(true);
    setError("");
    setWeather(null);

    try {
      const response = await fetch(`/api/weather?city=${encodeURIComponent(city)}`);
      const payload = await response.json();

      if (!response.ok) {
        throw new Error(payload?.error ?? `API returned status ${response.status}`);
      }

      setWeather(payload as Weather);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Unknown error");
    } finally {
      setLoading(false);
    }
  }

  return (
    <main className="page">
      <header className="header">
        <p className="eyebrow">Live Conditions</p>
        <h1>
          Australian <span>Weather</span>
        </h1>
      </header>

      <form className="controls" onSubmit={onSubmit}>
        <select
          value={city}
          onChange={(event) => setCity(event.target.value)}
          aria-label="Select a city"
        >
          <option value="">Select a city…</option>
          {CITIES.map((name) => (
            <option key={name} value={name}>
              {name}
            </option>
          ))}
        </select>
        <button type="submit" disabled={loading}>
          {loading ? "Loading..." : "Get Weather"}
        </button>
      </form>

      {error ? <p className="status error">Error: {error}</p> : null}
      {loading ? <div className="spinner" aria-label="Loading" /> : null}

      {weather ? (
        <section className="weather-card">
          <div className="card-header">
            <div className="card-location">
              <h2>{weather.city}</h2>
              <p className="country">{weather.country}</p>
            </div>
            <div className="card-condition">
              <p className="condition-label">{weather.condition}</p>
              <p className="condition-updated">Updated {weather.last_updated}</p>
            </div>
          </div>

          <div className="temp-row">
            <p className="temp-primary">{weather.temperature_c}°C</p>
            <p className="temp-secondary">{weather.temperature_f}°F</p>
          </div>

          <div className="stats-grid">
            <div className="stat">
              <p className="stat-label">Humidity</p>
              <p className="stat-value">{weather.humidity}%</p>
            </div>
            <div className="stat">
              <p className="stat-label">Wind</p>
              <p className="stat-value">{weather.wind_kph} km/h</p>
            </div>
            <div className="stat">
              <p className="stat-label">Wind (mph)</p>
              <p className="stat-value">{weather.wind_mph} mph</p>
            </div>
          </div>
        </section>
      ) : null}
    </main>
  );
}

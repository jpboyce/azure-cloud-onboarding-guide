This is a Next.js web UI for the weather demo.

The browser calls the local Next.js API route (`/api/weather`), and that route calls the Azure Function server-side. This keeps the Function URL/key out of client-side code and supports private networking scenarios.

## Configuration

Set these environment variables for the web app:

- `WEATHER_API_BASE_URL` (required): Azure Function base URL (for example, `https://<function-app>.azurewebsites.net`)
- `WEATHER_API_FUNCTION_KEY` (optional): Function key if your Function endpoint requires it

## Local development

Install dependencies and start:

```bash
npm install
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

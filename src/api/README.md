# Weather API Azure Function

This Azure Function provides weather information for any city using the weatherapi.com service.

## Setup

### 1. Get a Weather API Key
1. Sign up at [weatherapi.com](https://www.weatherapi.com/)
2. Get your free API key from the dashboard

### 2. Configure the Environment Variable
In your Azure Function App settings, add the following application setting:
- **Name**: `WEATHER_API_KEY`
- **Value**: Your weatherapi.com API key

Alternatively, for local development, add this to your `local.settings.json` file:
```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "",
    "FUNCTIONS_WORKER_RUNTIME": "python",
    "WEATHER_API_KEY": "your_api_key_here"
  }
}
```

## Usage

### Endpoint
- **URL**: `https://your-function-app.azurewebsites.net/api/getWeather`
- **Method**: GET or POST
- **Authentication**: Function key required

### Parameters
Pass the city name in one of these ways:

1. **Query Parameter** (GET request):
   ```
   GET /api/getWeather?city=London
   ```

2. **JSON Body** (POST request):
   ```json
   {
     "city": "New York"
   }
   ```

### Response Format
```json
{
  "city": "London",
  "country": "United Kingdom",
  "temperature_c": 15.0,
  "temperature_f": 59.0,
  "condition": "Partly cloudy",
  "humidity": 72,
  "wind_kph": 9.7,
  "wind_mph": 6.0,
  "last_updated": "2024-01-15 14:30"
}
```

### Error Responses
- **400 Bad Request**: Missing city parameter
- **404 Not Found**: City not found
- **500 Internal Server Error**: API configuration issues
- **503 Service Unavailable**: Weather service temporarily unavailable

## Examples

### Using curl (GET)
```bash
curl "https://your-function-app.azurewebsites.net/api/getWeather?code=YOUR_FUNCTION_KEY&city=Paris"
```

### Using curl (POST)
```bash
curl -X POST "https://your-function-app.azurewebsites.net/api/getWeather?code=YOUR_FUNCTION_KEY" \
     -H "Content-Type: application/json" \
     -d '{"city": "Tokyo"}'
```

### Using JavaScript/Fetch
```javascript
async function getWeather(city) {
  const response = await fetch(`https://your-function-app.azurewebsites.net/api/getWeather?code=YOUR_FUNCTION_KEY&city=${city}`);
  const data = await response.json();
  return data;
}

// Usage
getWeather('Sydney').then(weather => {
  console.log(`Temperature in ${weather.city}: ${weather.temperature_c}°C`);
});
```

## Development

### Local Development
1. Install dependencies: `pip install -r requirements.txt`
2. Set up `local.settings.json` with your API key
3. Run locally: `func start`

### Deployment
Deploy to Azure Functions using your preferred method (VS Code extension, Azure CLI, or CI/CD pipeline).
import azure.functions as func
import datetime
import json
import logging
import requests
import os

app = func.FunctionApp()

@app.route(route="getWeather", auth_level=func.AuthLevel.FUNCTION)
def getWeather(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    # Get city from query parameters or request body
    city = req.params.get('city')
    if not city:
        try:
            req_body = req.get_json()
        except ValueError:
            req_body = None

        if req_body:
            city = req_body.get('city')

    if not city:
        return func.HttpResponse(
            json.dumps({
                "error": "Missing city parameter. Please provide a city name in the query string (?city=CityName) or in the request body."
            }),
            status_code=400,
            mimetype="application/json"
        )

    # Get API key from environment variables
    api_key = os.environ.get('WEATHER_API_KEY')
    if not api_key:
        logging.error('WEATHER_API_KEY environment variable not set')
        return func.HttpResponse(
            json.dumps({"error": "Weather API is not configured properly"}),
            status_code=500,
            mimetype="application/json"
        )

    try:
        # Call weatherapi.com API
        url = f"http://api.weatherapi.com/v1/current.json?key={api_key}&q={city}&aqi=no"

        logging.info(f'Making weather API request for city: {city}')
        response = requests.get(url, timeout=10)

        if response.status_code == 200:
            weather_data = response.json()

            # Extract relevant weather information
            result = {
                "city": weather_data['location']['name'],
                "country": weather_data['location']['country'],
                "temperature_c": weather_data['current']['temp_c'],
                "temperature_f": weather_data['current']['temp_f'],
                "condition": weather_data['current']['condition']['text'],
                "humidity": weather_data['current']['humidity'],
                "wind_kph": weather_data['current']['wind_kph'],
                "wind_mph": weather_data['current']['wind_mph'],
                "last_updated": weather_data['current']['last_updated']
            }

            logging.info(f'Successfully retrieved weather for {city}')
            return func.HttpResponse(
                json.dumps(result),
                status_code=200,
                mimetype="application/json"
            )

        elif response.status_code == 400:
            return func.HttpResponse(
                json.dumps({"error": f"City '{city}' not found. Please check the city name and try again."}),
                status_code=404,
                mimetype="application/json"
            )
        else:
            logging.error(f'Weather API returned status code: {response.status_code}')
            return func.HttpResponse(
                json.dumps({"error": "Failed to fetch weather data"}),
                status_code=500,
                mimetype="application/json"
            )

    except requests.exceptions.Timeout:
        logging.error('Weather API request timed out')
        return func.HttpResponse(
            json.dumps({"error": "Weather service is currently unavailable (timeout)"}),
            status_code=503,
            mimetype="application/json"
        )
    except requests.exceptions.RequestException as e:
        logging.error(f'Weather API request failed: {str(e)}')
        return func.HttpResponse(
            json.dumps({"error": "Weather service is currently unavailable"}),
            status_code=503,
            mimetype="application/json"
        )
    except Exception as e:
        logging.error(f'Unexpected error: {str(e)}')
        return func.HttpResponse(
            json.dumps({"error": "An unexpected error occurred"}),
            status_code=500,
            mimetype="application/json"
        )
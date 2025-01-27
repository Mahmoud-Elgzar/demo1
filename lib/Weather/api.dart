/*import 'dart:convert';


import 'package:weather/constants.dart';
import 'package:weather/weathermodel.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<ApiResponse> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load weather");
      }
    } catch (e) {
      throw Exception("Failed to load weather");
    }
  }
}*/


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:demo1/Weather/constants.dart'; // Assuming apiKey is here
import 'package:demo1/weather/weathermodel.dart'; // Your model classes

class WeatherApi {
  // Updated the base URL to use the forecast endpoint
  final String baseUrl = "http://api.weatherapi.com/v1/forecast.json";  

  // New method to get a 5-day forecast
  Future<ApiResponse> getForecastWeather(String location, {int days = 5}) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location&days=$days"; // Fetch 5-day forecast
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(response.body));  // Parse the response
      } else {
        throw Exception("Failed to load forecast data");
      }
    } catch (e) {
      throw Exception("Failed to load forecast data");
    }
  }
}


import 'dart:convert';

import 'package:weather_ios_app/common/constants/network_const.dart';
import 'package:weather_ios_app/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepo {

 Future<WeatherModel?> fetchCityByName(String cityName) async {
    final url = "${NetworkConst.baseUrl}?q=$cityName&days=7&key=${NetworkConst.key}";

    try {
      final response = await http.get(Uri.parse(url)); // HTTP so'rov
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // JSON ma'lumotlarni pars qilish
        return WeatherModel.fromJson(data); // WeatherModel obyektiga aylantirish
      } else {
        throw Exception("Failed to load weather data"); // Xatolik qaytarish
      }
    } catch (e) {
      print("Error fetching data: $e");
      return null;
    }
  }
}

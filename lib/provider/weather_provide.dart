import 'package:flutter/material.dart';
import 'package:weather_ios_app/data/models/weather_model.dart';
import 'package:weather_ios_app/data/repositories/weather_repo.dart';

class WeatherProvide extends ChangeNotifier {
  final WeatherRepo weatherRepo;

  WeatherProvide({required this.weatherRepo});

  bool isLoading = false;
  WeatherModel weatherdata = WeatherModel();
  String? cityName;

  Future<void> getAlldata() async {
    isLoading = true;
    notifyListeners();

    // query = name;
    // if (query.isEmpty) {

    final result = await weatherRepo.fetchCityByName(cityName ?? "toshkent");
    // }
    if (result != null) {
      weatherdata = result;
    }
    isLoading = false;
    notifyListeners();
  }
}

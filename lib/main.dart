
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_ios_app/data/repositories/weather_repo.dart';
import 'package:weather_ios_app/presentation/screens/home_screen.dart';
import 'package:weather_ios_app/provider/weather_provide.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return WeatherProvide(weatherRepo: WeatherRepo())..getAlldata();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

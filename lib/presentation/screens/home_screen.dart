import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_ios_app/data/models/weather_model.dart';
import 'package:weather_ios_app/presentation/screens/forcast_screen.dart';
import 'package:weather_ios_app/presentation/widgets/custom_appbar.dart';
import 'package:weather_ios_app/presentation/widgets/custom_con.dart';
import 'package:weather_ios_app/presentation/widgets/custom_item.dart';
import 'package:weather_ios_app/presentation/widgets/custom_row.dart';
import 'package:weather_ios_app/presentation/widgets/cutom_tabBar.dart';
import 'package:weather_ios_app/provider/weather_provide.dart';
import 'dart:ui'; // For BackdropFilter

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _refreshData() async {
    final weatherProvide = Provider.of<WeatherProvide>(context, listen: false);

    await weatherProvide.getAlldata(); // Ma'lumotlarni qayta yuklash
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvide>(
      builder: (context, weatherProvide, child) {
        final data = weatherProvide.weatherdata;

        // Null safety qiymatlar
        weatherProvide.cityName = data?.location?.name ?? "Unknown City";
        final currentImage = data?.current?.condition?.icon ?? "";
        final text = data?.current?.condition?.text ?? "Unknown Condition";
        final tempC = data?.current?.tempC?.round().toString() ?? "0";
        final windMph = data?.current?.windMph?.round() ?? 0;
        final cloud = data?.current?.cloud?.round() ?? 0;
        final humidity = data?.current?.humidity?.round() ?? 0;
        final date = data?.location?.localtime != null
            ? DateTime.parse("${data?.location?.localtime}")
            : DateTime.now();
        final formattedDate = DateFormat("EEE, MMM d").format(date);
        final lastHour = DateFormat("H").format(date);
        final filterHours = data?.forecast?.forecastday?.first.hour?.where(
          (item) {
            final timeHour = item.time?.split(" ").last.split(":").first;
            return int.tryParse(lastHour) != int.tryParse(timeHour ?? "0");
          },
        ).toList();

        log("Meni datam kelyapti ${data?.current?.cloud}");

        return Scaffold(
          backgroundColor: const Color(0xFFF39876),
          appBar: CustomAppBar(),
          body: Stack(
            children: [
              RefreshIndicator(
                onRefresh: _refreshData,
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.27, -0.49),
                          end: Alignment(-0.87, 0.49),
                          colors: [Color(0xFFFEE3BC), Color(0xFFF39876)],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 160,
                            child: Text(
                              weatherProvide.cityName.toString(),
                              style: TextStyle(
                                color: Color(0xFF313341),
                                fontSize: 35,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              color: Color(0xFF9A938C),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          CustomRow(
                              imagePath: "https:$currentImage",
                              title: text,
                              tempC: "$tempC"),
                          CustomContainer(
                            iconPath: "assets/rain.svg",
                            title: "RainFall",
                            value: "$cloud cm",
                          ),
                          const SizedBox(height: 10),
                          CustomContainer(
                            iconPath: "assets/wind.svg",
                            title: "Wind",
                            value: "$windMph km/h",
                          ),
                          SizedBox(height: 10),
                          CustomContainer(
                            iconPath: "assets/humid.svg",
                            title: "Humidity",
                            value: "$humidity %",
                          ),
                          const SizedBox(height: 20),
                          CustomTapBar(
                            onTabChanged: (index) {
                              if (index == 2) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForcastScreen(),
                                    ));
                              }
                            },
                          ),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filterHours?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final item = filterHours?[index];
                                final hourTime =
                                    item?.time?.split(" ").last ?? "--:--";
                                final temp = item?.tempC?.toString() ?? "0";
                                final iconPath =
                                    "https:${item?.condition?.icon ?? ""}";

                                return CustomItem(
                                    imagePath: iconPath,
                                    now: hourTime,
                                    gradus: temp);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (weatherProvide.isLoading)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

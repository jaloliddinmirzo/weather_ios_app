import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_ios_app/presentation/widgets/custom_appbar.dart';
import 'package:weather_ios_app/presentation/widgets/custom_top.dart';
import 'package:weather_ios_app/presentation/widgets/forcast_con.dart';
import 'package:weather_ios_app/provider/weather_provide.dart';

class ForcastScreen extends StatefulWidget {
  const ForcastScreen({super.key});

  @override
  State<ForcastScreen> createState() => _ForcastScreenState();
}

class _ForcastScreenState extends State<ForcastScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvide>(builder: (context, watherProvide, child) {
      final data = watherProvide.weatherdata;
      final windMph = data.current?.windMph?.round();
      final cloud = data.current?.cloud?.round();
      final humidity = data.current?.humidity?.round();

     
      // final tommorow = data.forecast?.forecastday?.where((item) => item.hour.is,)
      return Scaffold(
        backgroundColor: const Color(0xffFDE4C9),
        appBar: GradientAppBar(
          title: "Next 7 day",
          onBackPressed: () {
            Navigator.pop(context);
          },
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                  decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.6000000238418579),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.50,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Colors.white.withOpacity(0.800000011920929),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    spacing: 25,
                    children: [
                      const ForcastCon(
                        iconPath:
                            "https://cdn.weatherapi.com/weather/64x64/day/122.png",
                        title: "RainFall",
                        value: "3cm",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomIconWithTitle(
                              assetPath: "assets/rain.svg", title: "$cloud-sm"),
                          CustomIconWithTitle(
                              assetPath: "assets/wind.svg",
                              title: "$windMph-k/m"),
                          CustomIconWithTitle(
                              assetPath: "assets/humid.svg",
                              title: "$humidity-%"),
                        ],
                      ),
                    ],
                  ),
                ), //
                const SizedBox(height: 20),
                Expanded(
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: watherProvide.weatherdata.forecast?.forecastday?.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final day =
                        watherProvide.weatherdata.forecast?.forecastday?[index];
                    final date = DateTime.parse("${day?.date}");
                    final wekkName = DateFormat("EEEE").format(date);
                    final maxTemp = "${day?.day?.maxtempC?.round()}";

                    final iconUrl = "https:${day?.day?.condition?.icon}";
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ForcastCon(
                        iconPath: iconUrl,
                        title: wekkName,
                        value: "$maxTemp °",
                      ),
                    );
                  },
                ))
              ],
            ),
          ),
        ),
      );
    });
  }
}

// ? data

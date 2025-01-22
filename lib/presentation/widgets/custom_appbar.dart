import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_ios_app/provider/weather_provide.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias, // Gradientni to'g'ri kesish
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.87, 0.49),
          end: Alignment(0.87, -0.49),
          colors: [Color(0xFFFEE3BC), Color(0xFFFEE3BC)],
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent, // Asl fonni o'chirish
        leadingWidth: 60,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
          icon: SvgPicture.asset(
            width: 100,
            "assets/search.svg",
          ),
        ),
        title: SvgPicture.asset("assets/pages.svg"),
        actions: [
          SvgPicture.asset(width: 40, "assets/menu.svg"),
          const SizedBox(width: 20),
        ],
        elevation: 0, // Soya yo'q qilish
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomSearchDelegate extends SearchDelegate {
  // Ma'lumotlar qidiruv uchun misol
  final List<String> items = [
    "London",
    "New York",
    "Tashkent",
    "Tokyo",
    "Paris",
    "Moscow",
    "Beijing",
    "Delhi",
    "Sydney",
    "Berlin",
    "Rome",
    "Madrid",
    "Toronto",
    "Dubai",
    "Singapore",
    "Seoul",
    "Istanbul",
    "Kuala Lumpur",
    "Bangkok",
    "Los Angeles"
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ""; // Qidiruvni tozalash
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Qidiruvni yopish
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Qidiruv natijalarini ko'rsatish
    final results = items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]); // Tanlangan natijani qaytarish
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Foydalanuvchi yozayotgan vaqtda taklif qilish
    final suggestions = items
        .where((item) => item.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () async {
            query = suggestions[index]; // Qidiruvni yangilash
            context.read<WeatherProvide>().cityName = query;
            await context.read<WeatherProvide>().getAlldata();
            showResults(context); // Natijalarni ko'rsatish
          },
        );
      },
    );
  }
}

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;

  const GradientAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.87, 0.49),
          end: Alignment(0.87, -0.49),
          colors: [Color(0xFFFEE3BC), Color(0xFFFEE3BC)],
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent, // Gradient ko'rinishi uchun
        elevation: 0, // Soya yo'q qilish
        leading: IconButton(
          onPressed: onBackPressed,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

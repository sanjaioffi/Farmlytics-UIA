import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uia_hackathon_app/pages/crops_page.dart';
import 'package:uia_hackathon_app/pages/home_page.dart';
import 'package:uia_hackathon_app/pages/profile_page.dart';
import 'package:uia_hackathon_app/pages/timeline_page.dart';
import 'package:uia_hackathon_app/pages/weather_forecast_page.dart';

import '../constants/text_styles.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static String routeName = 'main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [HomePage(), Crops(), ProfilePage()];
  int current_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        gap: 8,
        selectedIndex: current_index,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.timeline,
            text: 'Crops',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          )
        ],
        onTabChange: (value) {
          setState(() {
            current_index = value;
          });
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              color: Colors.black87,
              iconSize: 25,
              onPressed: () {},
              icon: const Icon(Icons.add_alert, color: Colors.black87)),
          IconButton(
              iconSize: 25,
              onPressed: () {},
              icon: const Icon(
                Icons.chat_rounded,
                color: Colors.black,
              ))
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/logo.png',
          width: 50,
          height: 50,
        ),
      ),
      body: pages[current_index],
    );
  }
}

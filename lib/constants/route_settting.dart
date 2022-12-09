import 'package:flutter/widgets.dart';
import 'package:uia_hackathon_app/pages/home_page.dart';
import 'package:uia_hackathon_app/pages/main_page.dart';

final Map<String, WidgetBuilder> routeSetting = {
  HomePage.routeName: (context) => const HomePage(),
  MainPage.routeName: (context) => const MainPage(),
};

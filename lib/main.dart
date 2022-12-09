import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uia_hackathon_app/constants/route_settting.dart';
import 'package:uia_hackathon_app/pages/intro_screen.dart';
import 'package:uia_hackathon_app/pages/no_internet_page.dart';
import 'package:uia_hackathon_app/providers/location_provider.dart';
import 'package:uia_hackathon_app/providers/weather_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var connectivityResult = await (Connectivity().checkConnectivity());
  runApp(MultiProvider(
      providers: [
        // provider 1
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        // provider 2
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        // provider 3
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
        ),
        debugShowCheckedModeBanner: false,
        home: connectivityResult != ConnectivityResult.none
            ? const LocatingScreen()
            : const NoInternetPage(),
        routes: routeSetting,
      )));
}

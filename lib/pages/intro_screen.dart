import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uia_hackathon_app/functionalities/location.dart';

class LocatingScreen extends StatefulWidget {
  const LocatingScreen({super.key});

  @override
  State<LocatingScreen> createState() => _LocatingScreenState();
}

class _LocatingScreenState extends State<LocatingScreen> {
  LocationManager location = LocationManager();

  @override
  void initState() {
    location.address(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/locating.json'),
      ),
    );
  }
}

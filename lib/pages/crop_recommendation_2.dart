import 'package:flutter/material.dart';
import 'package:uia_hackathon_app/pages/main_page.dart';

import '../constants/color_constants.dart';
import '../constants/text_styles.dart';
import '../custom_widgets/custom_input_field.dart';
import 'home_page.dart';

class CropRecommendationPage2 extends StatefulWidget {
  const CropRecommendationPage2({super.key});

  @override
  State<CropRecommendationPage2> createState() =>
      _CropRecommendationPage2State();
}

class _CropRecommendationPage2State extends State<CropRecommendationPage2> {
  TextEditingController rainfall = TextEditingController();
  TextEditingController temperature = TextEditingController();
  TextEditingController humidity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Area Weather Condition?',
                style: kHeaderStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'This informations will help us to recommend a best crop with respect to rainfall and weather condition',
                  textAlign: TextAlign.center,
                  style: kSubtitleStyle,
                )),
            const Divider(),
            const SizedBox(height: 30),
            custonInputField(
              controller: humidity,
              title: 'humidity - relative humidity in %',
              label: 'humidity in %',
              hint: 'Enter the average humidity in your location',
            ),
            custonInputField(
              controller: temperature,
              title: 'temperature - temperature in degree Celsius',
              label: 'temperature in Celsius',
              hint: 'Enter the average temperature in your location',
            ),
            custonInputField(
              controller: rainfall,
              title: 'rainfall - rainfall in mm',
              label: 'rainfall in mm',
              hint: 'Enter the average rainfall in your location',
            ),
          ],
        )),
      )),
      bottomNavigationBar: InkWell(
          child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kprimaryGreenColor,
              ),
              child: Center(child: Text('FIND A CROP', style: kButtonStyle))),
          onTap: () {
            Navigator.popAndPushNamed(context, MainPage.routeName);
          }),
    );
  }
}

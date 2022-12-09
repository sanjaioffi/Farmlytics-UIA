import 'package:flutter/material.dart';
import 'package:uia_hackathon_app/constants/color_constants.dart';
import 'package:uia_hackathon_app/constants/text_styles.dart';
import 'package:uia_hackathon_app/pages/crop_output_page.dart';
import 'package:uia_hackathon_app/pages/crop_recommendation_2.dart';
import 'package:uia_hackathon_app/pages/home_page.dart';

import '../custom_widgets/custom_input_field.dart';

class CropRecommendationPage1 extends StatefulWidget {
  const CropRecommendationPage1({super.key});

  @override
  State<CropRecommendationPage1> createState() =>
      _CropRecommendationPage1State();
}

class _CropRecommendationPage1State extends State<CropRecommendationPage1> {
  TextEditingController N = TextEditingController();
  TextEditingController P = TextEditingController();
  TextEditingController K = TextEditingController();
  TextEditingController ph = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Your Soil N-P-K Ratio?',
                    style: kHeaderStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'This informations will help us to know the soil type and condition',
                    textAlign: TextAlign.center,
                    style: kSubtitleStyle,
                  ),
                ),
                const Divider(),
                const SizedBox(height: 30),
                custonInputField(
                  controller: N,
                  title: 'N - ratio of Nitrogen content in soil',
                  label: 'N - Nitrogen',
                  hint: 'Enter your Nitrogen value of your land',
                ),
                custonInputField(
                  controller: P,
                  label: 'P - Phosphorous',
                  hint: 'Enter your Phosphorous value of your land',
                  title: 'P - ratio of Phosphorous content in soil',
                ),
                custonInputField(
                  label: 'K - Potassium',
                  hint: 'Enter your Potassium value of your land',
                  controller: K,
                  title: 'K - ratio of Potassium content in soil',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
          child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kprimaryGreenColor,
              ),
              child: Center(child: Text('NEXT', style: kButtonStyle))),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) {
              return CropOutput(
                N: int.parse(N.text),
                P: int.parse(P.text),
                K: int.parse(K.text),
              );
            })));
          }),
    );
  }
}

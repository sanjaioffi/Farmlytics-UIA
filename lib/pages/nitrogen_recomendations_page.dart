import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uia_hackathon_app/custom_widgets/custom_input_field.dart';
import 'package:uia_hackathon_app/pages/home_page.dart';

import '../constants/color_constants.dart';
import '../constants/text_styles.dart';

class NitrogenRecommendationPage extends StatefulWidget {
  const NitrogenRecommendationPage({super.key});

  @override
  State<NitrogenRecommendationPage> createState() =>
      _NitrogenRecommendationPageState();
}

class _NitrogenRecommendationPageState
    extends State<NitrogenRecommendationPage> {
  TextEditingController yield = TextEditingController();
  int N = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'What is your expected yield?',
                style: kHeaderStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'This informations will help us to recommend the optimal nitrogen value must be present in your land',
                textAlign: TextAlign.center,
                style: kSubtitleStyle,
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: custonInputField(
                  controller: yield,
                  title: 'Enter your expected yield',
                  hint: 'your expected yield',
                  label: 'Yield in ton'),
            ),
            Divider(
              thickness: 4,
              height: 80,
            ),
            N != 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Optimal Nitrogen dose for your yield is ',
                          style: kNameStyle,
                        ),
                        Text(
                          '${N.toString()} kg/ha',
                          style: kTempStyle,
                        ),
                      ],
                    ),
                  )
                : Text('')
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
          child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kprimaryGreenColor,
              ),
              child: Center(
                  child: Text('Find Nitrogen content', style: kButtonStyle))),
          onTap: () {
            setState(() {
              N = (optimalNDose(int.parse(yield.text)));
              yield.clear();
            });
          }),
    );
  }

  int optimalNDose(int yield) {
    if (0 < yield && yield <= 40) {
      return Random().nextInt(5) + 5;
    } else if (40 < yield && yield <= 50) {
      return Random().nextInt(10) + 10;
    } else {
      return Random().nextInt(60) + 20;
    }
  }
}

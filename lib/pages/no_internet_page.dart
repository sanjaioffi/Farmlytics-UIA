import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/lottie.dart';
import 'package:uia_hackathon_app/constants/text_styles.dart';
import 'package:uia_hackathon_app/custom_widgets/custom_button.dart';
import 'package:uia_hackathon_app/main.dart';
import 'package:uia_hackathon_app/pages/intro_screen.dart';
import 'package:uia_hackathon_app/pages/main_page.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({super.key});

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Lottie.asset('assets/no-internet.json'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Please Make sure you have stable network connection / turn-on Your internet",
                    style: kTileHeaderStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Do you wish to continue without internet? some feature may not be available.",
                    style: kSubtitleStyle,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () async {
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      var snackBar =
                          SnackBar(content: Text('Turn on Your Internet'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return LocatingScreen();
                      })));
                    }
                  },
                  child: CustomButton(
                      icon: Icon(Icons.travel_explore_rounded),
                      title: "No, Try Again with stabel internet"),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: ((context) {
                      return MainPage();
                    })));
                  },
                  child: CustomButton(
                      icon: Icon(Icons.recommend_rounded),
                      title: 'Yes, Continue without internet'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

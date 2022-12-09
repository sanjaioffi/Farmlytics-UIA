import 'package:flutter/material.dart';
import 'package:uia_hackathon_app/pages/crop_recommendations_page_1.dart';
import 'package:uia_hackathon_app/pages/disease_classification_page.dart';
import 'package:uia_hackathon_app/pages/fertilizer_recommendations_page.dart';
import 'package:uia_hackathon_app/pages/intro_screen.dart';
import 'package:uia_hackathon_app/pages/nitrogen_recomendations_page.dart';
import 'package:uia_hackathon_app/providers/weather_provider.dart';
import 'package:weather/weather.dart';
import 'package:weather_icons/weather_icons.dart';
import '../constants/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String routeName = 'home';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var weather = null;
    if (context.watch<WeatherProvider>().currentWeather != null) {
      setState(() {
        weather = context.watch<WeatherProvider>().currentWeather!;
      });
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                child: weather == null
                    ? const Center(child: Text('No Internet Connection'))
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              weather.areaName!,
                              style: kNameStyle,
                            ),
                            Text(
                              DateFormat("EEEE, MMMM d").format(DateTime.now()),
                              style: kSubtitleStyle,
                            ),
                            const Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        weather.weatherDescription!,
                                        style: kTileValueStyle,
                                      ),
                                      Text(
                                        '${weather.temperature!.celsius!.toInt().toString()} \u00B0 C',
                                        style: kTempStyle,
                                      ),
                                      Text(
                                        'min: ${weather.tempMin!.celsius!.toInt().toString()}\u00B0 C / max: ${weather.tempMax!.celsius!.toInt().toString()}\u00B0 C',
                                        style: kTimeStyle,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image.network(
                                        'http://openweathermap.org/img/wn/${weather.weatherIcon!}.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                      Row(
                                        children: [
                                          WindIcon(degree: weather.windDegree!),
                                          Text(
                                              'wind ${weather.windSpeed.toString()}m/s',
                                              style: kTimeStyle),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
              ),
            ),
            // Row(
            //   children: [

            //     CustomCard(
            //       image: Image.asset(
            //         'assets/icons/irrigation.jpg',
            //         width: 130,
            //         height: 130,
            //       ),
            //       title: 'Irrigation Recommendation',
            //       nextPage: const LocatingScreen(),
            //     ),
            //   ],
            // ),
            Row(
              children: [
                CustomCard(
                  image: Image.asset(
                    'assets/icons/fertilizer.webp',
                    width: 130,
                    height: 130,
                  ),
                  title: 'Fertilizer Recommendation',
                  nextPage: const FertilizerRecommendationPage(),
                ),
                CustomCard(
                  image: Image.asset(
                    'assets/icons/pesticide.webp',
                    width: 130,
                    height: 130,
                  ),
                  title: 'Pesticide Recommendation',
                  nextPage: const DiseaseClassification(),
                ),
              ],
            ),
            Row(
              children: [
                CustomCard(
                  image: Image.asset(
                    'assets/icons/crop recommendation.webp',
                    width: 130,
                    height: 130,
                  ),
                  title: 'Optimal Nitrogen recommendation',
                  nextPage: const NitrogenRecommendationPage(),
                ),
                CustomCard(
                  image: Image.asset(
                    'assets/icons/irrigation.jpg',
                    width: 130,
                    height: 130,
                  ),
                  title: 'Crop Recommendation',
                  nextPage: const CropRecommendationPage1(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.image,
    required this.title,
    required this.nextPage,
  }) : super(key: key);

  final Image image;
  final String title;
  final Widget nextPage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            return nextPage;
          }))),
          child: Card(
            elevation: 2,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    image,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: kTileValueStyle,
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

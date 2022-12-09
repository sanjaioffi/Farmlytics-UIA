import 'package:flutter/material.dart';
import 'package:uia_hackathon_app/constants/text_styles.dart';
import 'package:uia_hackathon_app/pages/home_page.dart';
import 'package:uia_hackathon_app/pages/main_page.dart';

import '../constants/color_constants.dart';

class FertilizerOutputPage extends StatefulWidget {
  FertilizerOutputPage(
      {super.key, required this.N, required this.P, required this.K});
  final int N;
  final int P;
  final int K;

  @override
  State<FertilizerOutputPage> createState() => _FertilizerOutputPageState();
}

class _FertilizerOutputPageState extends State<FertilizerOutputPage> {
  String lags = '';
  Map fertilizers = {
    'N': ['urea', 'anhydrous ammonia', 'urea ammonium nitrate', 'cow manure'],
    'P': ['Diammonium phosphate', 'monoammonium phosphate', 'epsom salt'],
    'K': [
      'sulfate of potash magnesia',
      'kelp',
      'wood ash',
      'green sand',
      'alfalfa'
    ]
  };

  List selected_fertilizers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selected_fertilizers = fertilizers[getFertilizer()];
      lags = getFertilizer();
    });
  }

  @override
  Widget build(BuildContext context) {
    List chosenList = fertilizers['N'];
    return SafeArea(
      child: Scaffold(
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Recommended Fertilizer',
                style: kHeaderStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'By analysing the your land and your current crop.We suggest you some fertilizers for high yield',
                  textAlign: TextAlign.center,
                  style: kSubtitleStyle,
                )),
            const Divider(),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your land lags $lags ratio,These are some fertilizer to improve the $lags value',
                style: kTileHeaderStyle,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 300,
              child: ListView.builder(
                  itemCount: selected_fertilizers.length,
                  itemBuilder: ((context, index) {
                    return Center(
                      child: Text(
                        selected_fertilizers[index],
                        style: kNameStyle,
                      ),
                    );
                  })),
            )
          ],
        ),
        bottomNavigationBar: InkWell(
            child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: kprimaryGreenColor,
                ),
                child:
                    Center(child: Text('Back To Home', style: kButtonStyle))),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return MainPage();
              }));
            }),
      ),
    );
  }

  String getFertilizer() {
    print('${widget.N},  ${widget.P}, ${widget.K},');

    if (widget.P > widget.N && widget.N < widget.K) {
      return 'N';
    } else if (widget.N > widget.P && widget.P < widget.K) {
      return 'P';
    } else {
      return 'K';
    }
  }
}

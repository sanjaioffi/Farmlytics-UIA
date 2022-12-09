import 'package:flutter/material.dart';
import 'package:uia_hackathon_app/pages/main_page.dart';

import '../constants/color_constants.dart';
import '../constants/text_styles.dart';

class CropOutput extends StatefulWidget {
  const CropOutput(
      {super.key, required this.N, required this.P, required this.K});
  final int N;
  final int P;
  final int K;

  @override
  State<CropOutput> createState() => _CropOutputState();
}

class _CropOutputState extends State<CropOutput> {
  Map crops = {
    'N': ['comfrey', 'lupine', 'sweetclovers', 'vetches'],
    'P': ['peanuts', 'soybeans', 'purple-hulled beans', 'lentils'],
    'K': ['Grain sorghum', 'Wheat', 'Barley', 'Bluegrass']
  };
  List selected_crops = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      print(getlag());
      selected_crops = crops[getlag()];
    });
  }

  @override
  Widget build(BuildContext context) {
    List chosenList = crops['N'];
    return SafeArea(
      child: Scaffold(
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Recommended Crops',
                style: kHeaderStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'By analysing the your land.We suggest you some crops for high yield',
                  textAlign: TextAlign.center,
                  style: kSubtitleStyle,
                )),
            const Divider(),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 300,
              child: ListView.builder(
                  itemCount: selected_crops.length,
                  itemBuilder: ((context, index) {
                    return Center(
                      child: Text(
                        selected_crops[index],
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

  String getlag() {
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

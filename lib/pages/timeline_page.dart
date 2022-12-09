import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:uia_hackathon_app/constants/color_constants.dart';
import 'package:uia_hackathon_app/pages/crop_recommendations_page_1.dart';
import 'package:uia_hackathon_app/pages/main_page.dart';
import 'package:uia_hackathon_app/globals/crop_data.dart' as data;

import '../constants/text_styles.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({
    super.key,
  });

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  DateTime selectedDate = DateTime.now();
  int currentDay = 0;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          TextButton(
              onPressed: () => selectDate(context),
              child: const Text('choose the date')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'DAY : ${currentDay.toString()}',
              style: kValueStyle,
            ),
          ),
          Expanded(
            child: Timeline.tileBuilder(
              theme: TimelineThemeData(color: kprimaryGreenColor),
              builder: TimelineTileBuilder.connectedFromStyle(
                // connectorStyle: ConnectorStyle.dashedLine,
                // indicatorStyle: IndicatorStyle.outlined,
                connectionDirection: ConnectionDirection.after,
                connectorStyleBuilder: (context, index) {
                  return (index == currentIndex)
                      ? ConnectorStyle.dashedLine
                      : ConnectorStyle.solidLine;
                },
                indicatorStyleBuilder: (context, index) {
                  if (index == currentIndex) {
                    return IndicatorStyle.dot;
                  } else {
                    return IndicatorStyle.outlined;
                  }
                },
                contentsAlign: ContentsAlign.alternating,
                contentsBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                      width: double.infinity,
                      // height: 60,
                      decoration: BoxDecoration(
                        color: index == currentIndex
                            ? kprimaryGreenColor
                            : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  data.crop_data[index]['days'],
                                  style: kTileValueStyle,
                                ),
                              ],
                            ),
                            Text(
                              data.crop_data[index]['description'],
                              style: kSubtitleStyle,
                            ),
                            TextButton(
                                onPressed: (() {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: ((context) {
                                    return data.crop_data[index]['nextpage'];
                                  })));
                                }),
                                child: const Text(
                                  'see more',
                                ))
                          ],
                        ),
                      )),
                ),
                itemCount: data.crop_data.length,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        currentDay = daysBetween(selectedDate, DateTime.now());
        currentIndex = currentStep(data.crop_data, currentDay);
      });
    }
  }
}

int currentStep(List crop_data, int currentDay) {
  for (var i = 0; i < crop_data.length; i++) {
    if (crop_data[i]['from'] <= currentDay &&
        currentDay <= crop_data[i]['end']) {
      return i;
    }
  }
  return 0;
}

daysBetween(from, to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

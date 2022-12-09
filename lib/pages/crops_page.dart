import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:uia_hackathon_app/pages/timeline_page.dart';

import '../constants/text_styles.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_input_field.dart';

class Crops extends StatefulWidget {
  const Crops({super.key});

  @override
  State<Crops> createState() => _CropsState();
}

class _CropsState extends State<Crops> {
  List crops = ['potato', 'wheat'];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Crops",
                style: kHeaderStyle,
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  },
                  icon: Icon(Icons.add))
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: crops.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => TimeLinePage()))),
                    child: Container(
                        width: double.infinity,
                        height: 60,
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
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                crops[index],
                                style: kTileValueStyle,
                              ),
                            ],
                          ),
                        )),
                  ),
                );
              })),
        ),
      ],
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      print(selectedDate);
    }
  }

  TextEditingController name = TextEditingController();
  return new AlertDialog(
    title: const Text('Add Crop Details'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        custonInputField(
          controller: name,
          title: 'Enter the crop name',
          label: 'crop name',
          hint: 'Enter the crop name',
        ),
        Text(
          'Enter your cultivation date',
          style: kTileValueStyle,
        ),
        TextButton(
            onPressed: () {
              _selectDate(context);
            },
            child: Text('Select Date'))
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
      TextButton(
        onPressed: () {},
        child: const Text('Done'),
      ),
    ],
  );
}

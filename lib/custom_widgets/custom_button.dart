import 'package:flutter/material.dart';

import '../constants/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);

  final Icon icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
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
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon,
              const SizedBox(
                width: 40,
              ),
              Text(
                title,
                style: kTileValueStyle,
              ),
            ],
          ),
        ));
  }
}

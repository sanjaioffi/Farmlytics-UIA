import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/text_styles.dart';

class custonInputField extends StatelessWidget {
  custonInputField({
    Key? key,
    required this.controller,
    required this.title,
    required this.hint,
    required this.label,
    this.type = TextInputType.number,
    this.action = TextInputAction.next,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String label;
  final String hint;
  TextInputAction action;
  TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kTileHeaderStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
            style: kNameStyle,
            keyboardType: type,
            textInputAction: action,
            cursorColor: kprimaryGreenColor,
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: kTimeStyle,
              hintText: hint,
              hintStyle: kHintStyle,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: kprimaryGreenColor, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1.5),
              ),
            )),
        const SizedBox(
          height: 60,
        ),
      ],
    );
  }
}

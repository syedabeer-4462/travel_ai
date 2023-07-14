import 'package:flutter/material.dart';

import 'constants.dart';

class BottomButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;

  BottomButton({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      child: Container(
        height: 80.0,
        width: double.infinity,
        color: kBottomContainerColour,
        child: Center(
          child: Text(
            this.buttonText,
            style: kButtonTextStyle,
          ),
        ),
      ),
    );
  }
}

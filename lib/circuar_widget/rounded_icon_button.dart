import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;

  RoundedIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(
        height: 56.0,
        width: 56.0,
      ),
      elevation: 0.0,
      onPressed: this.onPressed,
      child: Icon(this.icon, color: Colors.deepPurple[900]),
      fillColor: Colors.white,
      shape: CircleBorder(),
    );
  }
}

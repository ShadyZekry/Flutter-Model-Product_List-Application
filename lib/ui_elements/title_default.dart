import 'package:flutter/material.dart';

class TitleDefault extends StatelessWidget {
  final String _title;

  TitleDefault(this._title);

  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Oswald",
      ),
    );
  }
}

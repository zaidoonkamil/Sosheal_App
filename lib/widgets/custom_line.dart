import 'package:flutter/material.dart';

class CustomLine extends StatelessWidget {
  const CustomLine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:20 ,top:20 ,),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.white24,
      ),
    );
  }
}

import 'package:flutter/material.dart';
class Barriers extends StatelessWidget {

  final size;

  Barriers({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 10,color: Colors.greenAccent),
        borderRadius: BorderRadius.circular(28),

      ),
    );

  }
}

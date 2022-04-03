import 'package:flutter/material.dart';

class Fish extends StatelessWidget {
  const Fish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80 ,
      width: 80,
      child: Image.asset('lib/assets/gold_fish.png'),


    );
  }
}

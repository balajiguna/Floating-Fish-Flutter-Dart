import 'dart:async';
import 'package:floating_fish/fish.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'barriers.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


 static double fishY = 0;
  double time = 0;
  double height = 0;
  late int score = 0;
  late int bestScore = 0;
  double initialHeight = fishY;
 bool isgamestarted = false;
 static double barrierX1 =1;
 double barrierX2 = barrierX1 + 1.5;

  void float()
  {
    setState(() {
        time = 0;
        score +=1;
        initialHeight = fishY;

    });
    if(score >= bestScore){
      bestScore = score;
    }
  }

  bool FishIsDead(){
    if(fishY> 1 || fishY < -1)
      {
        return true;
      }
    return false;
  }

  void startGame()
  {
    isgamestarted = true;
    score = 0;

    Timer.periodic(const Duration(milliseconds: 50), (timer)
    {

      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        fishY = initialHeight - height;
       setState(() {
         if(barrierX1 < -1.1 ){

           barrierX1 +=2.2;
         }else
         {
           barrierX1 -=0.05;
         }
       });

       if(FishIsDead()){
         timer.cancel();
         _showDialog();
       }

       setState(() {

         if(barrierX2 < -1.1 ){
           barrierX2 +=2.2;
         }else{
           barrierX2 -=0.05;
         }

       });

      });
      if (fishY> 1){
        timer.cancel();
        isgamestarted = false;
      }
    });
  }

  void resetGame(){
    Navigator.pop(context);
    setState(() {
      fishY =0;
      isgamestarted = false;
      time = 0;
      initialHeight = fishY;
    });
  }


 void _showDialog()
 {
    showDialog(
        context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
        {
          return AlertDialog(
            backgroundColor: Colors.amberAccent,
                title: Center(
              child: Image.asset('lib/assets/gameover1.png',width: 140,),
          ),
          actions : [
               GestureDetector(
                 onTap: resetGame,
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(5),
                   child: Container(
                   padding :EdgeInsets.all(10),
                   color:Colors.white,
                   child:const Text('Start Again',style: TextStyle(color: Colors.amberAccent,fontSize: 14,
                       fontWeight: FontWeight.bold),),
                 ),
               ),
               )
          ],
          );
          }
          );
        }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()
      {
        if(isgamestarted)
        {
          float();
        }
        else{
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0,fishY),
                      duration: const Duration(milliseconds: 0),
                      color: Colors.lightBlueAccent,
                      child:  const Fish(),
                    ),
                    Container(

                      alignment: const Alignment(0,-0.32),
                      child: isgamestarted?
                          const Text("")
                          : Image.asset('lib/assets/start.png',width: 150,height: 100,),
                    ),
                    AnimatedContainer(
                        alignment: Alignment(barrierX1,1.1),
                        duration: const Duration(milliseconds: 0),
                    child: Barriers(
                      size: 200.0,


                    ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierX1,-1.3),
                      duration: const Duration(milliseconds: 0),
                      child: Barriers(
                        size: 200.0,


                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierX2,1.2),
                      duration: const Duration(milliseconds: 0),
                      child: Barriers(
                        size: 180.0,


                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierX2,-1.2),
                      duration: const Duration(milliseconds: 0),
                      child: Barriers(
                        size: 350.0,


                      ),
                    )




                  ],

                )
            ),
             Container(
               height: 7,
               color: Colors.blueAccent,
             ),
            Expanded(child: Container(
              color: Colors.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: [
                    const SizedBox(height: 4,),
                    Image.asset('lib/assets/score.png',width: 75,),
                    const SizedBox(height: 20,),
              Text(score.toString(),
                style: const TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              ],
              ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: [
                    const SizedBox(height: 4,),
                  Image.asset('lib/assets/quality.png',width: 75,),
                    const SizedBox(height: 20,),
                    Text(bestScore.toString(),
                      style: const TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

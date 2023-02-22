import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keycloack_proj/models/Story.dart';
// import 'package:pausable_timer/pausable_timer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ActualityPage extends StatefulWidget {
  const ActualityPage({Key? key}) : super(key: key);

  @override
  State<ActualityPage> createState() => _ActualityPageState();
}

class _ActualityPageState extends State<ActualityPage> {
  int currentStoryIndex = 0;
  List<Story> stories = [
    Story(name: "story 1",
        image:
        "assets/bg1.jpg"),

    Story(
        name: "story 2",
        image:"assets/bg2.jpg"),
    Story(
        name: "story 3",
        image:"assets/bg3.jpg"),
  ];
  double percentWatched = 0;

  // liste contenant les pourcentages vus de chaque story
  List<double> percentWatchedList =[];

  bool isPaused = false;
  startWatching(){
    //final timer = PausableTimer(Duration(seconds: 1), () => print('Fired!'));
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if(isPaused){
          timer.cancel();
        }
        // le percent doit etre entre 0 et 1 s'il est compris alors le time s'écoule et s'ajoute 0.05 au percent jusqu'à atteindre 1
        if(percentWatchedList[currentStoryIndex]+ 0.05 <=1){
          percentWatchedList[currentStoryIndex] +=0.05;
        }
        else {
          // si on arrive à 1 on met le percent à 1 et on passe au next story
          percentWatchedList[currentStoryIndex]=1;
          timer.cancel();
          // go to next story et attention si j'ai parcouru toute la liste des stories
          if(currentStoryIndex+1 <stories.length){
            currentStoryIndex ++; //on doit réappeler startWatching pour initialiser le Timer
            startWatching();
          }
          else{  //si on a terminé tous les stories
            currentStoryIndex =0;
            percentWatchedList =[];
            for(int i =0;i<stories.length;i++){
              percentWatchedList.add(0);
            }
            startWatching();
          }
        }
      });
    });
  }
  @override
  void initState() {
    //initialement les pourcentages watched de chaque story est 0
    for(int i =0;i<stories.length;i++){
      percentWatchedList.add(0);
    }
    startWatching();
    super.initState();
  }


  tapOnStory(TapDownDetails details){
    double toutchTap = details.globalPosition.dx; //position de tap par rapport la gauche sur la story

    //user tap on left (1/4) of the screen sauf la première
    if(toutchTap < Get.width/4 ){
      if(currentStoryIndex != 0){
        setState(() {
          //set percent watched de la story actuel et la story d'avant ou je veux se déplacer à 0
          percentWatchedList[currentStoryIndex] = 0;
          percentWatchedList[currentStoryIndex - 1 ] = 0;
          // allez à la story précédente
          currentStoryIndex -=1;
        });
      }

    }
    //user taped on right (3/4 of screen) sauf la dernière
    else if(toutchTap > 3/4 * Get.width){
      if(currentStoryIndex != stories.length -1){
        percentWatchedList[currentStoryIndex] = 1;
        percentWatchedList[currentStoryIndex + 1 ] = 0;
      }
    }
  }

  _pauseTimer(){
    setState(() {
      isPaused =true;
    });

  }
  _resumeTimer(){
    setState(() {
      isPaused =false;
      startWatching();
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        print("on long press");
        _pauseTimer();
      },
      onLongPressEnd: (_) {
        print("resume");
        _resumeTimer();
      },
      onTapDown:(details)=> tapOnStory(details),
      child: Stack(
        children: [
          Container(
            height: Get.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(stories[currentStoryIndex].image!)
              )
            ),
          ),
          Container(
            padding:  EdgeInsets.only(top: Get.height *0.01),
            child: Row(
              children: [
                ///Nous avons deux choix pour faire l'indicateur de progress : soit LinearProgressIndicator ou LinearPercentIndicator
                ///
                //exemple avec LinearProgressIndicator
                /*Expanded(
                  child: LinearProgressIndicator(
                    value: percentWatchedList[0],
                  ),
                ),*/
                Expanded(
                  child: LinearPercentIndicator(
                    lineHeight: 10.0,
                    percent: percentWatchedList[0],
                    progressColor: Colors.grey[500],
                    backgroundColor: Colors.grey[100],
                    barRadius: Radius.circular(Get.height *.05),
                  ),
                ),
                Expanded(
                  child: LinearPercentIndicator(

                    lineHeight: 10.0,
                    percent: percentWatchedList[1],
                    progressColor: Colors.grey[500],
                    backgroundColor: Colors.grey[100],
                    barRadius: Radius.circular(Get.height *.05),
                  ),
                ),
                Expanded(
                  child: LinearPercentIndicator(
                    lineHeight: 10.0,
                    percent: percentWatchedList[2],
                    progressColor: Colors.grey[500],
                    backgroundColor: Colors.grey[100],
                    barRadius: Radius.circular(Get.height *.05),
                  ),
                ),

            ]
            ),
          ),
        ],
      ),
    );
  }
}

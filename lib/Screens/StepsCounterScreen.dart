import 'package:fitness_app/providers/currentState.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'dart:async';

import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}



class Steps extends StatefulWidget {
  @override
  _StepsState createState() => _StepsState();
}

class _StepsState extends State<Steps> {


  @override
  void initState() {
    super.initState();
    // CurrentState _instance = Provider.of(context,listen:false);
    // _instance.initPlatformState();
  }



  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of(context,listen:false);

    return
       Scaffold(
        appBar: AppBar(
          title: const Text('Steps Counter'),
        ),
        body: Center(
          child: Consumer<CurrentState>(
            builder: (context,_,__) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Consumer<CurrentState>(
                    builder: (context,_,__) {
                      return Card(
                        color: Colors.black87.withOpacity(0.7),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                            bottom: 30,
                            right: 20,
                            left: 20,
                          ),
                          child: Column(
                            children: <Widget>[
                              gradientShaderMask(
                                child: Text(
                                  _instance.steps?.toString() ?? '0',
                                  style: GoogleFonts.darkerGrotesque(
                                    fontSize: 80,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              Text(
                                "Steps Today",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Calories : ${_instance.currentUser.steps[0].calories.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  //  child: ,
                  ),

                  TextButton(onPressed: () {
////                    Navigator
                  }, child: Text("History")),

                  Container(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _instance.currentUser.steps.length,
                      itemBuilder: (BuildContext context,index) {
                        return Card(
                          color: Colors.black87.withOpacity(0.7),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                              bottom: 30,
                              right: 20,
                              left: 20,
                            ),
                            child: Column(
                              children: <Widget>[

                                Text(
                                  "Date : ${_instance.currentUser.steps[index].date.day}-${_instance.currentUser.steps[index].date.month}-${_instance.currentUser.steps[index].date.year}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                gradientShaderMask(
                                  child: Text(
                                    _instance.currentUser.steps[index].steps?.toString() ?? '0',
                                    style: GoogleFonts.darkerGrotesque(
                                      fontSize: 80,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Steps Today",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "Calories : ${_instance.currentUser.steps[index].calories.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Divider(
                  //   height: 100,
                  //   thickness: 0,
                  //   color: Colors.white,
                  // ),
                  // Text(
                  //   'Pedestrian status:',
                  //   style: TextStyle(fontSize: 30),
                  // ),
                  // Icon(
                  //   _instance.status == 'walking'
                  //       ? Icons.directions_walk
                  //       : _instance.status == 'stopped'
                  //       ? Icons.accessibility_new
                  //       : Icons.error,
                  //   size: 100,
                  // ),
                  // Center(
                  //   child: Text(
                  //     _instance.status,
                  //     style: _instance.status == 'walking' || _instance.status == 'stopped'
                  //         ? TextStyle(fontSize: 30)
                  //         : TextStyle(fontSize: 20, color: Colors.red),
                  //   ),
                  // )

                ],
              );
            },
            //child: ,
          ),
        ),
      );

  }


  Widget gradientShaderMask({@required Widget child}) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Colors.orange,
          Colors.deepOrange.shade900,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: child,
    );
  }
}
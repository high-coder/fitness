import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fitness_app/pages/workout.dart';
import 'package:fitness_app/providers/currentState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Trainer extends StatefulWidget {
  final data;

  const Trainer({Key key, this.data}) : super(key: key);

  @override
  _TrainerState createState() => _TrainerState();
}

class _TrainerState extends State<Trainer> {


  @override
  void initState() {
    super.initState();
    CurrentState _instance = Provider.of<CurrentState>(context, listen:false);
    bool uidMatches = false;
    // widget.data["workouts"].forEach((element) {
    //   _instance.currentUser.purchasedCourses.forEach((ins ) {
    //     if(widget.data["uid"] == ins["trainerUID"]) {
    //       uidMatches=true;
    //     }
    //   });
    //
    //   if(uidMatches == false) {
    //     element["purchased"] = false;
    //   }
    //
    //
    // });

  }


  bool userOwns = false;
  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen:false);
    Size size = MediaQuery.of(context).size;
    //print(widget.data);
    print("All the purchased courses of the user will be displayed here");
    print(_instance.currentUser.purchasedCourses);
    //_instance.currentUser.purchasedCourses = [];
    List workouts = widget.data['workouts'];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black45,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.4,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))),
                child: Image.asset(
                  'assets/workout.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.data['fullName'],
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Text(
                      '2 min Exercises',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 0,
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<CurrentState>(
                builder: (context, _,__) {
                  return Container(
                      padding: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0, -2))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: workouts.length,
                        itemBuilder: (BuildContext context, int index) {
                          //userOwns = false;
                          bool local = false;
                          _instance.currentUser.purchasedCourses.forEach((element) {
                            if(element["trainerUID"] == widget.data["uid"]) {
                              element["workoutUID"].forEach((ele) {
                                if(ele == workouts[index]['uid']) {
                                  userOwns = true;
                                  local = true;
                                }
                              });
                            }
                          });
                          if(local == false) {
                            userOwns = false;
                          }
                          return Container(
                            margin: EdgeInsets.only(top: 10, right: 25, bottom: 10, left: 25),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                // image: DecorationImage(
                                //     // image: AssetImage('assets/rainbow.png'),
                                //     fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10)),
                            height: size.height * 0.25+ 40,
                            width: size.width * 0.8,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex:2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        workouts[index]['name'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      AutoSizeText(
                                        workouts[index]['desc'],
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                                text: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Container(
                                                          padding: EdgeInsets.symmetric(horizontal: 5),
                                                          child: Icon(
                                                            Icons.whatshot,
                                                            color: Colors.amber,
                                                          ))),
                                                  TextSpan(text: workouts[index]['equipment']),
                                                ])),
                                            RichText(
                                                text: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Container(
                                                          padding: EdgeInsets.symmetric(horizontal: 5),
                                                          child: Icon(
                                                            Icons.whatshot,
                                                            color: Colors.amber,
                                                          ))),
                                                  TextSpan(text: workouts[index]['level']),
                                                ])),
                                            RichText(
                                                text: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Container(
                                                          padding: EdgeInsets.symmetric(horizontal: 5),
                                                          child: Icon(
                                                            Icons.whatshot,
                                                            color: Colors.amber,
                                                          ))),
                                                  TextSpan(
                                                    text: workouts[index]['exercises'] == null
                                                        ? '0 Workouts'
                                                        : '${workouts[index]['exercises'].length} Exercises',
                                                  ),
                                                ])),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () {
                                      bool local = false;
                                      _instance.currentUser.purchasedCourses.forEach((element) {
                                        if(element["trainerUID"] == widget.data["uid"]) {
                                          element["workoutUID"].forEach((ele) {
                                            if(ele == workouts[index]['uid']) {
                                              userOwns = true;
                                              local = true;
                                            }
                                          });
                                        }
                                      });
                                      if(local == false) {
                                        userOwns = false;
                                      }
                                      print(userOwns);
                                      local ? print("The user owns this thing ") : print("the user does not own this");
                                      if(local) {
                                        print(workouts[index]);
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => WorkoutPage(data: workouts[index])));
                                      } else{
                                        _instance.trainerUID = widget.data["uid"];
                                        _instance.workoutUID = workouts[index]["uid"].toString();
                                        // send the user to the purchase screen
                                        Map<String,dynamic> options  = {
                                          'key': 'rzp_test_f9x193VDeXEfQ7',
                                          'amount': int.parse(workouts[index]['price']) * 100, //in the smallest currency sub-unit.
                                          'name': 'Health and Fitness',
                                          'description': 'Paid trainer plan',
                                          //'timeout': 600, // in seconds
                                          'prefill': {
                                            'contact': '',
                                            'email': ''
                                          },
                                          'external': {
                                            'wallets':["paytm"]
                                          }
                                        };
                                        _instance.openCheckout(options);
                                      }

                                    },
                                    child: Text(
                                      userOwns ? "View" : "Buy",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20),
                                    ),
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all<double>(1.5),
                                        minimumSize: MaterialStateProperty.all<Size>(
                                            Size(size.width * 0.25, 20)),
                                        shape:
                                        MaterialStateProperty.all<StadiumBorder>(StadiumBorder()),
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(Colors.blueAccent)),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ));
                },
              //  child: ,
              )
            ],
          ),
        ),
      ),
    );
  }
}

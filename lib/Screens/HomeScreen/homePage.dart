import 'package:fitness_app/constants/MyTextStyle.dart';
import 'package:fitness_app/constants/constants.dart';
import 'package:fitness_app/pages/nutrition.dart';
import 'package:fitness_app/pages/trainersScreen.dart';
import 'package:fitness_app/providers/currentState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../StepsCounterScreen.dart';
import 'homeDefault.dart';

class OurHome extends StatefulWidget {
  const OurHome({Key key}) : super(key: key);

  @override
  _OurHomeState createState() => _OurHomeState();
}

class _OurHomeState extends State<OurHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    askPermission();
    // _timer = Timer.periodic(const Duration(milliseconds: 100),(_timer)
    // {
    //   setState(() {
    //     _progressValue++;
    //   });
    // });
  }


  //ask for the users permission for using the physical activity of the device
  askPermission() async{
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);

    final status = await Permission.activityRecognition.request();
    if(status.isGranted) {
      // do nothing
      _instance.initPlatformState();

    } else{
      // ask again man
    }
  }


  Widget getBody(int i){
    switch(i){
      case 0:
        return MyHomeDefault();
        break;
      case 1:
        return TrainerPage();
        break;
      case 2:
        return NutritionScreen();
        break;
      // case 3:
      //   return SoldGoodScreen();
      //   break;
      // case 4:
      //   return MyId(image: "image", description: description, companyName: "xxxxx",
      //     email: "liga.ozola@gmail.com",
      //     phone: "1234567",
      //     registrationNumber: "34242525",
      //   );

    }
  }

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    print(_instance.currentUser.steps.length);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        color:Color(0xffFF8A00),
        padding: EdgeInsets.all(10),
        child: Consumer<CurrentState>(
          builder:(context, _,__) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Builder(
                  builder: (BuildContext context) {
                    if(_instance.selected == 0) {
                      return Card(
                        color: Colors.redAccent,
                        elevation: 10,
                        child: Container(

                          width: 35,
                          height: 35,
                          child: SvgPicture.asset(
                              "assets/icons/house.svg",
                              color: Colors.black,
                              semanticsLabel: 'A red up arrow'
                          ),
                        ),
                      );
                    } else{
                      return GestureDetector(
                        onTap: () {
                          _instance.updateBottomNavigation(0);
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          child: SvgPicture.asset(
                              "assets/icons/house.svg",
                              color: Colors.black,
                              semanticsLabel: 'A red up arrow'
                          ),
                        ),
                      );
                    }
                  },
                ),

                Builder(
                  builder: (BuildContext context) {
                    if(_instance.selected == 1) {
                      return Card(
                        color: Colors.redAccent,
                        elevation: 10,
                        child: Container(
                          width: 35,
                          height: 35,
                          child: SvgPicture.asset(
                              "assets/icons/dumbbellSVG.svg",
                              color: Colors.black,
                              semanticsLabel: 'A red up arrow'
                          ),
                        ),
                      );
                    } else{
                      return GestureDetector(
                        onTap: () {
                          _instance.updateBottomNavigation(1);
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          child: SvgPicture.asset(
                              "assets/icons/dumbbellSVG.svg",
                              color: Colors.black,
                              semanticsLabel: 'A red up arrow'
                          ),
                        ),
                      );
                    }
                  },
                ),
                Builder(
                  builder: (BuildContext context) {
                    if(_instance.selected == 2) {
                      return Card(
                        color: Colors.redAccent,
                        elevation: 10,
                        child: Container(
                          width: 35,
                          height: 35,
                          child: SvgPicture.asset(
                              "assets/icons/food.svg",
                              color: Colors.black,
                              semanticsLabel: 'A red up arrow'
                          ),
                        ),
                      );
                    } else{
                      return GestureDetector(
                        onTap: () {
                          _instance.updateBottomNavigation(2);
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          child: SvgPicture.asset(
                              "assets/icons/food.svg",
                              color: Colors.black,
                              semanticsLabel: 'A red up arrow'
                          ),
                        ),
                      );
                    }
                  },
                ),
                Builder(
                  builder: (BuildContext context) {
                    if(_instance.selected == 3) {
                      return Card(
                        color: Colors.redAccent,
                        elevation: 10,
                        child: Container(
                          width: 35,
                          height: 35,
                          child: SvgPicture.asset(
                              "assets/icons/userSVG.svg",
                              color: Colors.black,
                              semanticsLabel: 'A red up arrow'
                          ),
                        ),
                      );
                    } else{
                      return    GestureDetector(
                        onTap: () {
                          _instance.updateBottomNavigation(3);
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          child: SvgPicture.asset(
                              "assets/icons/userSVG.svg",
                              color: Colors.black,
                              semanticsLabel: 'A red up arrow'
                          ),
                        ),
                      );
                    }
                  },
                )

              ],
            );
          }
          //child:
        ),
      ),
      backgroundColor: Color(0xffE2E4E8),
      body: getBody(_instance.selected),
    );
  }
}

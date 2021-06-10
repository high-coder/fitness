import 'package:fitness_app/constants/MyTextStyle.dart';
import 'package:fitness_app/constants/constants.dart';
import 'package:fitness_app/providers/currentState.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../StepsCounterScreen.dart';

class MyHomeDefault extends StatefulWidget {
  const MyHomeDefault({Key key}) : super(key: key);

  @override
  _MyHomeDefaultState createState() => _MyHomeDefaultState();
}

class _MyHomeDefaultState extends State<MyHomeDefault> {
  double totalcal = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    _instance.currentUser.caloriesList.length == 2
        ? 0
        : _instance.currentUser.caloriesList[1].caloriesData.forEach((element) {
            totalcal += element['cal'];
          });
  }

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfffff2e2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 30, right: 25, top: 30, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${_instance.currentUser.name}',
                      style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Health',
                          style: TextStyle(
                              letterSpacing: 2,
                              fontSize: 50,
                              fontWeight: FontWeight.w800,
                              color: Colors.black)),
                      TextSpan(
                          text: ' and \nWellness',
                          style: TextStyle(
                              color: Color(0xfffec775),
                              fontSize: 40,
                              letterSpacing: 3,
                              fontWeight: FontWeight.w800,
                              height: 0.6))
                    ]))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: FlatButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Steps()));
                    },
                    child: Text(
                      " Today's Steps",
                      style: MyTextStyle.heading3,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Consumer<CurrentState>(
                          builder: (context, _, __) {
                            return Container(
                              height: 250,
                              width: 250,
                              child: SfRadialGauge(axes: <RadialAxis>[
                                RadialAxis(
                                  minimum: 0,
                                  maximum: 100,
                                  showLabels: false,
                                  showTicks: false,
                                  axisLineStyle: AxisLineStyle(
                                    thickness: 0.08,
                                    cornerStyle: CornerStyle.bothCurve,
                                    color: Color.fromARGB(30, 0, 169, 181),
                                    thicknessUnit: GaugeSizeUnit.factor,
                                  ),
                                  pointers: <GaugePointer>[
                                    // RangePointer(
                                    //     value: 10,
                                    //     width: 0.04,
                                    //     sizeUnit: GaugeSizeUnit.factor,
                                    //     color: const Color.fromARGB(120, 0, 169, 181),
                                    //     cornerStyle: CornerStyle.bothCurve),
                                    RangePointer(
                                        gradient: SweepGradient(
                                          endAngle: 50,
                                          startAngle: 50,

                                          //center: AlignmentG,
                                          //begin: Alignment.bottomLeft,
                                          //end: Alignment.topCenter,
                                          colors: colors,
                                          //stops: stops
                                        ),
                                        value: _instance.currentUser.steps.isNotEmpty
                                            ? (_instance.currentUser.steps[0].steps / 10000 * 100)
                                                .toDouble()
                                            : 1.00,
                                        width: 0.08,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        enableAnimation: true,
                                        animationDuration: 100,
                                        animationType: AnimationType.linear),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        widget: Container(
                                            child: Text(
                                          '${_instance.steps}',
                                          style: GoogleFonts.darkerGrotesque(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )),
                                        angle: 90,
                                        positionFactor: 0.0),
                                    GaugeAnnotation(
                                        widget: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "Goal",
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontWeight: FontWeight.w800,
                                                        fontSize: 30),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "10000",
                                                    style: MyTextStyle.buttontext2,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      _instance.currentUser.steps.isNotEmpty
                                                          ? _instance.currentUser.steps[0].calories
                                                              .toStringAsFixed(2)
                                                          : " ",
                                                      style: MyTextStyle.buttontext2,
                                                    ),
                                                    Image.asset(
                                                      "assets/calories.png",
                                                      width: 20,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        angle: 90,
                                        positionFactor: 0.8),
                                  ],
                                )
                              ]),
                            );
                          },
                          //child: ,
                        ),
                      ],
                    ),
                    Positioned(
                      top: 20,
                      left: 4,
                      right: 4,
                      child: Container(
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => Steps()));
                            },
                            icon: Icon(
                              Icons.event,
                              color: Colors.grey.withOpacity(0.4),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20, bottom: 0),
                child: Text(
                  'Previous Info',
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 30, left: 20, right: 10),
                      height: size.height * 0.22,
                      width: size.width / 2,
                      decoration: BoxDecoration(
                          color: Color(0xff222222),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20), topRight: Radius.circular(40))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 16),
                            child: Text(
                              'Yesterday \nSteps',
                              style: TextStyle(
                                  color: Color(0xfffff2e2),
                                  fontSize: 23,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: LinearProgressIndicator(
                              backgroundColor: Color(0xfffff2e2),
                              value: 0.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 16),
                            child: Text(
                              'Total Steps ${_instance.currentUser.steps.length == 0 ? '0' : _instance.currentUser.steps[1].steps}',
                              style: TextStyle(
                                  color: Color(0xfffff2e2),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 2),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 30, left: 20, right: 10),
                      height: size.height * 0.22,
                      width: size.width / 2,
                      decoration: BoxDecoration(
                          color: Color(0xfffec775),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20), topRight: Radius.circular(40))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 16),
                            child: Text(
                              'Yesterday Calories',
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.w800, letterSpacing: 2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.black45,
                              value: 0.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 16),
                            child: Text(
                              'Total Calories ${totalcal.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 2),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

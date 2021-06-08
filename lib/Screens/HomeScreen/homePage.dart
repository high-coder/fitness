import 'package:fitness_app/constants/MyTextStyle.dart';
import 'package:fitness_app/constants/constants.dart';
import 'package:fitness_app/providers/currentState.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../StepsCounterScreen.dart';

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
    // _timer = Timer.periodic(const Duration(milliseconds: 100),(_timer)
    // {
    //   setState(() {
    //     _progressValue++;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffE2E4E8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width,
            ),
            // Container(
            //   child: Text("WELOCME TO HOME"),
            // ),

            FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Steps()));
                },
                child: Text("Steps", style: MyTextStyle.heading3,)),

            //    Container(
            //     child: SfRadialGauge(
            //       axes: [
            //         RadialAxis(
            //           showLabels: false,
            //           showTicks: false,
            //           startAngle: 180,
            //           endAngle: 0,
            //           radiusFactor: 0.7,
            //           axisLineStyle: AxisLineStyle(
            //             thickness: 0.1,
            //             color: const Color.fromARGB(30, 0, 169, 181),
            //             thicknessUnit: GaugeSizeUnit.factor,
            //             cornerStyle: CornerStyle.startCurve,
            //           ),
            //           canScaleToFit: true,
            //           pointers: <GaugePointer>[
            //             RangePointer(
            //                 value: 10,
            //                 width: 0.04,
            //                 sizeUnit: GaugeSizeUnit.factor,
            //                 color: const Color.fromARGB(120, 0, 169, 181),
            //                 cornerStyle: CornerStyle.bothCurve),
            //
            //
            //             RangePointer(
            //                 gradient: SweepGradient(
            //                     colors: [Colors.red,Colors.redAccent]
            //                 ),
            //
            //                 value: 100,
            //                 enableAnimation: true,
            //                 width: 0.1,
            //                 sizeUnit: GaugeSizeUnit.factor,
            //                 cornerStyle: CornerStyle.bothFlat
            //             ),
            //
            //             RangePointer(
            //               gradient: SweepGradient(
            //                 endAngle: 100,
            //                 startAngle: 10,
            //                 //begin: Alignment.bottomLeft,
            //                 //end: Alignment.topCenter,
            //                 colors: colors,
            //                 //stops: stops
            //               ),
            //                 value: 80,
            //                 width: 0.08,
            //                 sizeUnit: GaugeSizeUnit.factor,
            //                 enableAnimation: true,
            //                 animationDuration: 100,
            //                 animationType: AnimationType.linear),
            //             RangePointer(
            //                 gradient: SweepGradient(
            //                     colors: [Colors.red,Colors.greenAccent]
            //                 ),
            //                 value: 100,
            //                 width: 0.01,
            //                 sizeUnit: GaugeSizeUnit.factor,
            //                 cornerStyle: CornerStyle.bothCurve),
            //
            //           ],
            //         annotations: <GaugeAnnotation>[
            //           GaugeAnnotation(
            //               widget: Container(
            //                   child: Text(_instance.steps,
            //                       style: TextStyle(
            //                           fontSize: 25, fontWeight: FontWeight.bold))),
            //               angle: 90,
            //               positionFactor: 0.0),
            //           GaugeAnnotation(
            //               widget: Container(
            //                   child: Text(_instance.steps,
            //                       style: TextStyle(
            //                           fontSize: 25, fontWeight: FontWeight.bold))),
            //               angle: 90,
            //               positionFactor: 0.3),
            //         ],
            //         )
            //       ],
            //         // axes: <RadialAxis>[
            //         //   RadialAxis(
            //         //     showLastLabel: false,
            //         //     canRotateLabels: false,
            //         //     showFirstLabel: false,
            //         //     canScaleToFit: false,
            //         //
            //         //     //showLastLabel: false,
            //         //     minimum: 0, maximum: 10,
            //         //       ranges: <GaugeRange>[
            //         //         // GaugeRange(startValue: 0, endValue: 50, color:Colors.green),
            //         //         // GaugeRange(startValue: 50,endValue: 100,color: Colors.orange),
            //         //         // GaugeRange(startValue: 100,endValue: 150,color: Colors.red)],
            //         //       // pointers: <GaugePointer>[
            //         //       //   NeedlePointer(value: 90)],
            //         //       //  annotations: <GaugeAnnotation>[
            //         //       //   GaugeAnnotation(widget: Container(child:
            //         //       //   Text('90.0',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
            //         //       //       angle: 90, positionFactor: 0.5
            //         //       //   )]
            //         //     ]
            //         //   )]
            //     )
            // ),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    //color: Color(0xffE2E2F3),
                    borderRadius: BorderRadius.circular(300),
                  //  gradient: LinearGradient(colors: [Color(0xffE2E2F3)]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white24,
                        spreadRadius: 10,
                        blurRadius: 10,
                        offset: Offset(0, 7), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 250,
                  width: 250,
                ),
                Consumer<CurrentState>(
                  builder: (context,_,__) {
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
                            thickness: 0.03,
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
                                value: _instance.currentUser.steps.isNotEmpty ? _instance.currentUser.steps[0].steps/ 10000 * 100 : 1,
                                width: 0.03,
                                sizeUnit: GaugeSizeUnit.factor,
                                enableAnimation: true,
                                animationDuration: 100,
                                animationType: AnimationType.linear),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Container(
                                    child: Text(
                                      _instance.steps,
                                      style: GoogleFonts.darkerGrotesque(
                                        fontSize: 80,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w100,
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
                                          child: Text("goal"),
                                        ),
                                        Container(
                                          child: Text("10000"),
                                        ),
                                        Row(
                                          children: [
                                            Text(_instance.currentUser.steps[0].calories.toString()),
                                            Image.asset("assets/calories.png", width: 20,),
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
                Positioned(
                  top: 20,
                  left:4,
                  right: 4,
                  child: Container(
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          print("tioehr erohe eofrhe ");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Steps()));

                        },
                        icon: Icon(Icons.event, color: Colors.grey.withOpacity(0.4), size: 30,),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

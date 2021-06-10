import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fitness_app/Screens/StepsCounterScreen.dart';
import 'package:fitness_app/constants/MyTextStyle.dart';
import 'package:fitness_app/constants/constants.dart';
import 'package:fitness_app/providers/currentState.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({Key key}) : super(key: key);

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  Dio dio = new Dio();
  TextEditingController _controller = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();
  List nutrition = [];
  double totalNutrition = 0;

  double totalCals = 0;
  Future getNut(String nut) async {
    var cal;
    await dio.get(
      'https://nutritionix-api.p.rapidapi.com/v1_1/search/${Uri.encodeComponent(nut)}',
      options: Options(headers: {
        'x-rapidapi-key': '19d15ec7fcmshc65f9f710ed08c6p1eb495jsna131144d59a4',
        'x-rapidapi-host': 'nutritionix-api.p.rapidapi.com'
      }),
      queryParameters: {'fields': 'item_name,item_id,brand_name,nf_calories,nf_total_fat'},
    ).then((value) => cal = value.data['hits'][0]['fields']['nf_calories']);
    print(cal.toDouble());
    return {'nutrition': nut, 'cal': cal.toDouble()};
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    if(_instance.currentUser.caloriesList.isNotEmpty) {
      nutrition = _instance.currentUser.caloriesList[0].caloriesData;
      totalCals = 0;
      _instance.currentUser.caloriesList[0].caloriesData.forEach((element) {
        totalCals += element["cal"];
      });
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    print(_instance.currentUser.steps.length);
    Size size = MediaQuery.of(context).size;

    print(nutrition);
    // getNut('pau bhaji').then((value) => print(value));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [


                Stack(
                  children: [
                    Center(
                      child: Container(
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
                    ),

                    Center(
                      child: Column(
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
                                          value: (totalCals / 2000 * 100).toDouble(),
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
                                                totalCals.toStringAsFixed(1),
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
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "goal",
                                                      style:
                                                      MyTextStyle.referEarnText,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "2000",
                                                      style: MyTextStyle.buttontext2,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        totalCals.toString(),
                                                        style:
                                                        MyTextStyle.buttontext2,
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
                    ),
                    Positioned(
                      top: 20,
                      left: 4,
                      right: 4,
                      child: Container(
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              print("tioehr erohe eofrhe ");
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Steps()));
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



                SizedBox(
                  height: 10,
                ),
                // SfRadialGauge(axes: <RadialAxis>[
                //   RadialAxis(
                //     pointers: <GaugePointer>[
                //       RangePointer(
                //         value: totalNutrition,
                //         cornerStyle: CornerStyle.bothCurve,
                //         width: 0.2,
                //         sizeUnit: GaugeSizeUnit.factor,
                //       )
                //     ],
                //     annotations: <GaugeAnnotation>[
                //       GaugeAnnotation(
                //           positionFactor: 0.1,
                //           angle: 90,
                //           widget: Text(
                //             totalNutrition.toStringAsFixed(0) + ' / 100',
                //             style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                //           ))
                //     ],
                //     minimum: 0,
                //     maximum: 100,
                //     showLabels: false,
                //     showTicks: false,
                //     axisLineStyle: AxisLineStyle(
                //       thickness: 0.2,
                //       cornerStyle: CornerStyle.bothCurve,
                //       color: Color.fromARGB(30, 0, 169, 181),
                //       thicknessUnit: GaugeSizeUnit.factor,
                //     ),
                //   )
                // ]),
                // Text(
                //   'Get Calories',
                //   style:
                //       TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.w800),
                // ),
                // Text(
                //   'Total nut taken ${totalCals}',
                //   style:
                //       TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.w800),
                // ),
                //


                CustomTextField(controller: _controller, name: 'Enter Food'),
                SizedBox(
                  height: 6,
                ),
                TextButton(
                  onPressed: () => {
                    totalCals = 0,
                    print(_controller.value.text),
                    getNut(_controller.value.text).then((value) => setState(() {
                          totalNutrition += value['cal'];
                          print(value);

                          print(value);
                          nutrition.add(value);
                          _instance.saveCaloriesLocally(nutrition);
                          _instance.currentUser.caloriesList[0].caloriesData.forEach((element) {
                            totalCals += element["cal"];
                          });
                        })),
                    _controller.clear()
                  },
                  child: Text(
                    'Add',
                    style:
                        TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(size.width * 0.7, 35)),
                      shape: MaterialStateProperty.all<StadiumBorder>(StadiumBorder()),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent)),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: nutrition.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 25, right: 20, bottom: 10, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                    child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Icon(
                                    Icons.circle,
                                    color:
                                        Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                  ),
                                )),
                                TextSpan(
                                    text: nutrition[index]['nutrition'],
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800)),
                              ]),
                            ),
                            Text(
                              "${nutrition[index]['cal']} cal's",
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 20, fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}

Container CustomTextField({TextEditingController controller, String name}) {
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.only(left: 10, right: 30, top: 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12, style: BorderStyle.solid)),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: (value) {},
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.play_for_work_sharp),
                hintText: name,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade400)),
          ),
        ),
      ],
    ),
  );
}

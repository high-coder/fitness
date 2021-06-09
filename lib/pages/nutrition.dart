import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
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
                SizedBox(
                  height: 10,
                ),
                SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: totalNutrition,
                        cornerStyle: CornerStyle.bothCurve,
                        width: 0.2,
                        sizeUnit: GaugeSizeUnit.factor,
                      )
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          positionFactor: 0.1,
                          angle: 90,
                          widget: Text(
                            totalNutrition.toStringAsFixed(0) + ' / 100',
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                          ))
                    ],
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.2,
                      cornerStyle: CornerStyle.bothCurve,
                      color: Color.fromARGB(30, 0, 169, 181),
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                  )
                ]),
                Text(
                  'Get Calories',
                  style:
                      TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.w800),
                ),
                Text(
                  'Total nut taken ${totalNutrition}',
                  style:
                      TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.w800),
                ),
                CustomTextField(controller: _controller, name: 'Enter Food'),
                TextButton(
                  onPressed: () => {
                    print(_controller.value.text),
                    getNut(_controller.value.text).then((value) => setState(() {
                          totalNutrition += value['cal'];
                          print(value);
                          nutrition.add(value);
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

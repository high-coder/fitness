import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
      queryParameters: {
        'fields': 'item_name,item_id,brand_name,nf_calories,nf_total_fat'
      },
    ).then((value) => cal = value.data['hits'][0]['fields']['nf_calories']);
    print(cal.toDouble());
    return cal.toDouble();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getNut('pau bhaji').then((value) => print(value));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                Text('Get CAlories'),
                Text('Total nut taken ${totalNutrition}'),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: 'enter nutrients'),
                ),
                TextButton(
                    onPressed: () => {
                          getNut(_controller.value.text)
                              .then((value) => setState(() {
                                    totalNutrition += value;
                                    nutrition.add({
                                      'nutrition': _controller.value.text,
                                      'cal': value
                                    });
                                  })),
                          _controller.clear()
                        },
                    child: Text('Add'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

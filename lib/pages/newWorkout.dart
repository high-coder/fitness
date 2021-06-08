import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewWorkOut extends StatefulWidget {
  const NewWorkOut({Key key}) : super(key: key);

  @override
  _NewWorkOutState createState() => _NewWorkOutState();
}

class _NewWorkOutState extends State<NewWorkOut> {
  Map muscles = {
    1: 'Biceps',
    2: 'Shoulder',
    3: 'Upper Body',
    4: 'Chest',
    5: 'triceps',
    6: 'leg',
    7: 'leg',
    8: 'leg',
    9: 'lunges'
  };
  Dio dio = new Dio();

  getExercises() async {
    await dio
        .get('https://wger.de/api/v2/exercise/',
            queryParameters: {'language': 2, 'muscles': 11},
            options: Options(headers: {
              'Authorization': 'Token 6fbc6ff0545fda8832cffb2afd4c26efdc6599d8',
            }))
        .then((value) => print(value));
  }

  TextEditingController _workoutName = new TextEditingController();
  TextEditingController _rounds = new TextEditingController();
  TextEditingController _sets = new TextEditingController();
  TextEditingController _exercise = new TextEditingController();
  TextEditingController _time = new TextEditingController();
  GlobalKey _key = new GlobalKey();
  List exercises = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getExercises();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: _workoutName,
                  style: TextStyle(),
                  decoration: InputDecoration(hintText: 'Workout Name'),
                ),
                Text('Exercise'),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: exercises.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Text('Exercise Name'),
                            Text('Exercise Type'),
                            Text('Exercise rep'),
                            Text('Exercise set'),
                            Text('Exercise Desc'),
                          ],
                        ),
                      );
                    }),
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: DropdownButton(
                          items: <String>[
                            'Android',
                            'IOS',
                            'Flutter',
                            'Node',
                            'Java',
                            'Python',
                            'PHP',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      Container(
                        child: DropdownButton(
                          items: <String>[
                            'Android',
                            'IOS',
                            'Flutter',
                            'Node',
                            'Java',
                            'Python',
                            'PHP',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width / 2,
                            child: TextField(
                              controller: _rounds,
                              style: TextStyle(),
                              decoration: InputDecoration(hintText: 'Rounds'),
                            ),
                          ),
                          Container(
                            width: size.width / 2,
                            child: TextField(
                              controller: _sets,
                              style: TextStyle(),
                              decoration: InputDecoration(hintText: 'Sets'),
                            ),
                          ),
                        ],
                      ),
                      TextButton(onPressed: null, child: Text('Add'))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

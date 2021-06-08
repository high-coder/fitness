import 'package:dio/dio.dart';
import 'package:fitness_app/models/trainer.dart';
import 'package:fitness_app/services/database.dart';
import 'package:flutter/material.dart';

class NewWorkOut extends StatefulWidget {
  const NewWorkOut({Key key}) : super(key: key);

  @override
  _NewWorkOutState createState() => _NewWorkOutState();
}

class _NewWorkOutState extends State<NewWorkOut> {
  OurDatabase ourDatabase = new OurDatabase();
  List ExcerciseData = [];
  Map muscles = {
    'Biceps': 1,
    'Shoulder': 2,
    'Upper Body': 3,
    'Chest': 4,
    'triceps': 5,
    'leg': 6,
    'hightleg': 7,
    'lowleg': 8,
    'lunges': 9
  };
  Dio dio = new Dio();

  getExercises(muscle) async {
    muscle = muscles[muscle];
    exercisesName.clear();
    ExcerciseData.clear();
    await dio
        .get('https://wger.de/api/v2/exercise/',
            queryParameters: {'language': 2, 'muscles': muscle},
            options: Options(headers: {
              'Authorization': 'Token 6fbc6ff0545fda8832cffb2afd4c26efdc6599d8',
            }))
        .then((value) => {
              setState(() {
                value.data['results'].forEach((value) => {
                      if (value['name'] != null)
                        {
                          exercisesName.add(value['name']),
                          ExcerciseData.add(
                              {'name': value['name'], 'id': value['id']})
                        }
                    });
              }),
            });
  }

  Future getImage(var id) async {
    String url = '';
    await dio
        .get('https://wger.de/api/v2/exerciseimage/${id}/thumbnails/',
            options: Options(headers: {
              'Authorization': 'Token 6fbc6ff0545fda8832cffb2afd4c26efdc6599d8'
            }))
        .then((value) => {
              if (value.data.length != 0) {url = value.data['medium']['url']}
            });
    return url;
  }

  TextEditingController _workoutName = new TextEditingController();
  TextEditingController _workoutDesc = new TextEditingController();
  TextEditingController _rounds = new TextEditingController();
  TextEditingController _sets = new TextEditingController();
  TextEditingController _exerciseDesc = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();
  List exercises = [];
  List<String> exercisesName = [];
  String _excerciseType = "Chest";
  String _excerciseName;

  @override
  void initState() {
    // getExercises(2);
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String image;
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
                TextField(
                  controller: _workoutDesc,
                  style: TextStyle(),
                  decoration: InputDecoration(hintText: 'Workout Desc'),
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
                            Text(exercises[index]['exerciseName']),
                            Text(exercises[index]['exerciseType']),
                            Text(exercises[index]['sets']),
                            Text(exercises[index]['rounds']),
                          ],
                        ),
                      );
                    }),
                Container(
                  color: Colors.amber,
                  child: Column(
                    children: [
                      Container(
                        child: DropdownButton(
                          value: _excerciseType,
                          items: <String>[
                            'Biceps',
                            'Shoulder',
                            'Upper Body',
                            'Chest',
                            'triceps',
                            'leg',
                            'lowleg',
                            'hightleg',
                            'lunges'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _excerciseType = value;
                              getExercises(value);
                            });
                          },
                        ),
                      ),
                      Container(
                        child: DropdownButton(
                          value: _excerciseName,
                          items: exercisesName.length == 0
                              ? []
                              : exercisesName.map<DropdownMenuItem<String>>(
                                  (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _excerciseName = value;
                            });
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
                      TextField(
                        controller: _exerciseDesc,
                        style: TextStyle(),
                        decoration: InputDecoration(hintText: 'Exercise Desc'),
                      ),
                      TextButton(
                          onPressed: () => {
                                ExcerciseData.forEach((element) {
                                  if (element['name'] == _excerciseName) {
                                    print(_excerciseName);
                                    print(element['id']);
                                    getImage(element['id'])
                                        .then((value) => image = value);
                                  }
                                }),
                                setState(() {
                                  exercises.add(ExerciseModel(
                                          image: image,
                                          exerciseDesc:
                                              _exerciseDesc.value.text,
                                          exerciseName: _excerciseName,
                                          exerciseType: _excerciseType,
                                          rounds: _rounds.value.text,
                                          sets: _sets.value.text)
                                      .toMap());
                                  exercisesName.clear();
                                  _exerciseDesc.clear();
                                  _sets.clear();
                                  _rounds.clear();
                                  _excerciseName = null;
                                  _excerciseType = 'Chest';
                                })
                              },
                          child: Text('Add'))
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () => {
                          ourDatabase.AddWorkout({
                            'name': _workoutName.value.text,
                            'desc': _workoutDesc.value.text,
                            'exercises': exercises
                          }),
                          setState(() {
                            _workoutName.clear();
                            _workoutDesc.clear();
                            exercises.clear();
                          })
                        },
                    child: Text('Submit'))
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
    _rounds.dispose();
    _sets.dispose();
    _workoutName.dispose();
    _exerciseDesc.dispose();
    _workoutDesc.dispose();
  }
}

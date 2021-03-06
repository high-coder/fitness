import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fitness_app/models/trainer.dart';
import 'package:fitness_app/providers/currentState.dart';
import 'package:fitness_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewWorkOut extends StatefulWidget {
  const NewWorkOut({Key key}) : super(key: key);

  @override
  _NewWorkOutState createState() => _NewWorkOutState();
}

class _NewWorkOutState extends State<NewWorkOut> {
  OurDatabase ourDatabase = new OurDatabase();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
  TextEditingController _equipment = new TextEditingController();
  TextEditingController _level = new TextEditingController();
  TextEditingController _price = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();
  List exercises = [];
  List<String> exercisesName = [];
  String _excerciseType = "Chest";
  String _excerciseName;

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    String image;
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    'Add Workout',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                ),
                CustomTextField(controller: _workoutName, name: 'WorkOut Name'),
                CustomTextField(
                    controller: _workoutDesc, name: 'WorkOut Description'),
                CustomTextField(controller: _equipment, name: 'Equipment'),
                Visibility(
                  visible:
                      _instance.currentUser.type == "trainer" ? true : false,
                  child: Row(
                    children: [
                      Expanded(
                          child: CustomTextField(
                        controller: _price,
                        name: 'Price',
                        keyboardType: TextInputType.phone,
                      )),
                      Expanded(
                          child: CustomTextField(
                              controller: _level, name: 'Level')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 20, bottom: 20),
                  child: Text(
                    'Exercises',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.only(
                            top: 2, bottom: 2, right: 20, left: 20),
                        decoration: BoxDecoration(
                          // color: Colors.teal,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.black12, style: BorderStyle.solid),
                        ),
                        width: size.width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
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
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.only(
                            top: 2, bottom: 2, right: 20, left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.black12, style: BorderStyle.solid),
                        ),
                        width: size.width,
                        child: DropdownButtonHideUnderline(
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
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                            controller: _rounds,
                            name: 'repetition',
                            keyboardType: TextInputType.phone,
                          )),
                          Expanded(
                              child: CustomTextField(
                            controller: _sets,
                            name: 'Sets',
                            keyboardType: TextInputType.phone,
                          )),
                        ],
                      ),
                      CustomTextField(
                          controller: _exerciseDesc,
                          name: 'Exercise Description'),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () => {
                          if (_excerciseName != '' &&
                              _exerciseDesc.value.text != '' &&
                              _sets.value.text != '')
                            {
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
                                        exerciseDesc: _exerciseDesc.value.text,
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
                            }
                          else
                            {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text('Some field are missing'),
                                duration: const Duration(seconds: 1),
                                action: SnackBarAction(
                                  label: '',
                                  onPressed: () {},
                                ),
                              ))
                            },
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(size.width * 0.7, 35)),
                            shape: MaterialStateProperty.all<StadiumBorder>(
                                StadiumBorder()),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blueAccent)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: exercises.length,
                    itemBuilder: (BuildContext context, index) {
                      print(exercises[index]);
                      return Container(
                        margin: EdgeInsets.all(25),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            borderRadius: BorderRadius.circular(10)),
                        height: size.height * 0.2,
                        width: size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  exercises[index]['name'],
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  exercises[index]['type'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  exercises[index]['desc'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'repetition ${exercises[index]['repetition']} | Sets ${exercises[index]['set']}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            if (exercises[index]['image'] == null)
                              Expanded(
                                  child: Image.asset('assets/equipment.png'))
                            else
                              Expanded(
                                  child:
                                      Image.network(exercises[index]['image'])),
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    if (_workoutName.value.text != '' &&
                        _equipment.value.text != '' &&
                        _workoutDesc.value.text != '' &&
                        exercises.isNotEmpty) {
                      if (_instance.currentUser.type == "trainer") {
                        print(_price.value.text);
                        List newEx = List.from(exercises);
                        ourDatabase
                            .getWorkoutList(_instance.currentUser.uid)
                            .then(
                          (value) {
                            String name = _workoutName.text;
                            String desc = _workoutDesc.text;
                            String level = _level.text;
                            String equ = _equipment.text;
                            String price = _price.text;
                            ourDatabase.AddWorkout(
                                uid: _instance.currentUser.uid,
                                workout: {
                                  'name': name,
                                  'desc': desc,
                                  'exercises': newEx,
                                  'level': level,
                                  'equipment': equ,
                                  'uid': value + 1,
                                  'price': price
                                });

                            return value;
                          },
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('workout saved successfully'),
                          duration: const Duration(seconds: 1),
                          backgroundColor: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));
                        _instance.saveWorkoutsLocally({
                          'name': _workoutName.value.text,
                          'desc': _workoutDesc.value.text,
                          'level': _level.value.text,
                          'equipment': _equipment.value.text,
                          'uid': "45",
                          'price': _price.value.text
                        }, exercises);
                        Navigator.of(context).pop();
                      } else {
                        _instance.saveWorkoutsLocally({
                          'name': _workoutName.value.text,
                          'desc': _workoutDesc.value.text,
                          'level': _level.value.text,
                          'equipment': _equipment.value.text,
                          'uid': "45",
                          'price': _price.value.text
                        }, exercises);
                        setState(() {
                          exercises.clear();
                          _level.clear();
                          _equipment.clear();
                          _workoutName.clear();
                          _workoutDesc.clear();
                          _price.clear();
                          exercises.clear();
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('workout saved successfully'),
                          duration: const Duration(seconds: 1),
                          backgroundColor: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));
                      }
                    } else {
                      print(exercises.length);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Some fields are missing'),
                        duration: const Duration(seconds: 1),
                        backgroundColor: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      ));
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(size.width * 0.7, 35)),
                      shape: MaterialStateProperty.all<StadiumBorder>(
                          StadiumBorder()),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueAccent)),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container CustomTextField({
    TextEditingController controller,
    String name,
    keyboardType: TextInputType.name,
  }) {
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
              keyboardType: keyboardType,
              controller: controller,
              onChanged: (value) {},
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.play_for_work_sharp),
                  hintText: name,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintStyle:
                      TextStyle(fontSize: 16, color: Colors.grey.shade400)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _rounds.dispose();
    _sets.dispose();
    _equipment.dispose();
    _level.dispose();
    _workoutName.dispose();
    _price.dispose();
    _exerciseDesc.dispose();
    _workoutDesc.dispose();
  }
}

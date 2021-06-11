import 'package:fitness_app/Screens/myWorkouts/showLocalworkoutsPage.dart';
import 'package:fitness_app/constants/MyTextStyle.dart';
import 'package:fitness_app/pages/newWorkout.dart';
import 'package:fitness_app/providers/currentState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyLocalWorkouts extends StatefulWidget {
  const MyLocalWorkouts({Key key}) : super(key: key);

  @override
  _MyLocalWorkoutsState createState() => _MyLocalWorkoutsState();
}

class _MyLocalWorkoutsState extends State<MyLocalWorkouts> {
  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context,listen:false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(width: double.infinity,),
                _instance.currentUser.localCourses.isNotEmpty ?
                ShowLocalWorkout()
            : Column(
                      children: [
                        Container(child: Text("You don't have any workout plans", style: MyTextStyle.usageAgeHeading,),),
                      ],
                    ),



                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewWorkOut()));
                }, child: Text("Add a workout"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

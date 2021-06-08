import 'package:fitness_app/pages/workout.dart';
import 'package:flutter/material.dart';

class Trainer extends StatefulWidget {
  final data;

  const Trainer({Key key, this.data}) : super(key: key);

  @override
  _TrainerState createState() => _TrainerState();
}

class _TrainerState extends State<Trainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List workouts = widget.data['workouts'];
    print(workouts[0]['exercises']);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Image.asset('assets/trainer.png'),
                  Text(widget.data['name']),
                  SizedBox(
                    height: 20,
                  ),
                  Text('30 min'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(widget.data['desc']),
                ],
              ),
            ),
            Container(
                child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: workouts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    print(workouts[index]);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            WorkoutPage(data: workouts[index])));
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Icon(Icons.play_arrow_sharp),
                        ),
                        Text(
                          'Plan ${index + 1}',
                        )
                      ],
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}

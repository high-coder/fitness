import 'package:flutter/material.dart';

class TrainerPage extends StatefulWidget {
  const TrainerPage({Key key}) : super(key: key);

  @override
  _TrainerPageState createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  List trainerList = [
    {'trainerName': '', 'trainerDesc': 'hey people', 'trainerImage': '',}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: trainerList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(trainerList[index].trainerName),
                      Text(trainerList[index].trainerDesc)
                    ],
                  ),
                  Icon(trainerList[index].trainerImage)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

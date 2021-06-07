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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Image.asset(widget.data.trainerImage),
                  Text(widget.data.trainerName),
                  Row(
                    children: [Text('')],
                  ),
                  Text('trainerDesc'),
                ],
              ),
            ),
            Container(
              child: Text('here gid'),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key key}) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.asset('name'),
            ),
            Container(
              child: Column(
                children: [
                  Text('Course Name'),
                  Text('Time'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

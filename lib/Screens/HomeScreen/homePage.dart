import 'package:flutter/material.dart';

import '../StepsCounterScreen.dart';

class OurHome extends StatefulWidget {
  const OurHome({Key key}) : super(key: key);

  @override
  _OurHomeState createState() => _OurHomeState();
}

class _OurHomeState extends State<OurHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Text("WELOCME TO HOME"),
            ),

            FlatButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Steps()));
            }, child: Text("Steps Page"))
          ],
        ),
      ),
    );
  }
}

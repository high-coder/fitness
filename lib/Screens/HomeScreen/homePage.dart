import 'package:flutter/material.dart';


class OurHome extends StatefulWidget {
  const OurHome({Key key}) : super(key: key);

  @override
  _OurHomeState createState() => _OurHomeState();
}

class _OurHomeState extends State<OurHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("WELOCME TO HOME"),
      ),
    );
  }
}

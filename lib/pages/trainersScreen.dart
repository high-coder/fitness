import 'dart:math';

import 'package:fitness_app/pages/trainer.dart';
import 'package:fitness_app/services/database.dart';
import 'package:flutter/material.dart';

class TrainerPage extends StatefulWidget {
  const TrainerPage({Key key}) : super(key: key);

  @override
  _TrainerPageState createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  OurDatabase database = new OurDatabase();

  List trainerList = [];

  @override
  void initState() {
    // TODO: implement initState
    database.getTrainers().then((value) => setState(() => trainerList = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.black45,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find Your',
                      style: TextStyle(color: Color(0xff363491), fontSize: 30),
                    ),
                    Text(
                      'Favorite Trainer',
                      style: TextStyle(
                          color: Color(0xff363491), fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 12, bottom: 12),
              ),
              SizedBox(
                height: 30,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: trainerList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (trainerList[index]['workouts'].length == 0) {
                    return Container();
                  }
                  return GestureDetector(
                    onTap: () {
                      print(trainerList[index]);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Trainer(data: trainerList[index])));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10, right: 25, left: 25),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          // image: DecorationImage(
                          //     image: AssetImage('assets/bub.png'), fit: BoxFit.cover),
                          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          borderRadius: BorderRadius.circular(10)),
                      height: size.height * 0.25,
                      width: size.width * 0.8,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trainerList[index]['fullName'],
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      WidgetSpan(
                                          child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 5),
                                              child: Icon(
                                                Icons.whatshot,
                                                color: Colors.amber,
                                              ))),
                                      TextSpan(
                                        text: trainerList[index]['workouts'] == null
                                            ? '0 Workouts'
                                            : '${trainerList[index]['workouts'].length} Workouts',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ])),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

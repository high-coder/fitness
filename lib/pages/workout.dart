import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key key, this.data, this.which}) : super(key: key);
  final data;
  final String which;

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    int val = random.nextInt(555);
List exercise;
    if(widget.which == "local") {
       exercise = widget.data;

    } else{
       exercise = widget.data['exercises'];

    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black45,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "Don't miss the Fitness",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text(
                  'Practice',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: exercise.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print(exercise[index]);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //         Trainer(data: trainerList[index])));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 25, bottom: 10, left: 25),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          borderRadius: BorderRadius.circular(10)),
                      height: size.height * 0.2 + 40,
                      width: size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex:2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  exercise[index]['name'],
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                                  maxLines: 2,
                                ),
                                Text(
                                  exercise[index]['type'],
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  exercise[index]['desc'],
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Rounds ${exercise[index]['repetition']} | Sets ${exercise[index]['set']}',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          if (exercise[index]['image'] == null)
                            Expanded(
                              flex:2,
                                child: Image.asset('assets/equipment.png')
                            )
                          else
                            Expanded(
                                flex:2,
                                child: Image.network(exercise[index]['image'])),
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

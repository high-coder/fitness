import 'dart:math';

import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key key, this.data}) : super(key: key);
  final data;

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    int val = random.nextInt(555);
    print(val);
    print(widget.data['exercises']);
    List exercise = widget.data['exercises'];
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
                      margin: EdgeInsets.symmetric(horizontal: 25),
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
                                exercise[index]['name'],
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                exercise[index]['type'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                exercise[index]['desc'],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Rounds ${exercise[index]['repetition']} | Sets ${exercise[index]['set']}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Image.network(exercise[index]['image']),
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

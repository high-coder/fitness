import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key key, this.data}) : super(key: key);
  final data;

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.data['exercises']);
    List exercise = widget.data['exercises'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // decoration: BoxDecoration(color: Colors.red),
                height: size.height * 0.4,
                child: SvgPicture.asset("assets/Yoga.svg"),
              ),
              Container(
                height: size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.data['name']),
                    Text('20 - 30 min'),
                    Icon(Icons.play_arrow_sharp)
                  ],
                ),
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
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      height: size.height * 0.2,
                      width: size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(exercise[index]['image']),
                          Column(
                            children: [
                              Text(exercise[index]['name']),
                              Text(exercise[index]['desc'])
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

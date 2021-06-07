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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text('Explore Trainers'),
                margin: EdgeInsets.only(top: 12, bottom: 12),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: trainerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print(trainerList[index]);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Trainer(data: trainerList[index])));
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
                          Image.asset('assets/trainer.png'),
                          Column(
                            children: [
                              Text(trainerList[index]['name']),
                              Text(trainerList[index]['desc'])
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

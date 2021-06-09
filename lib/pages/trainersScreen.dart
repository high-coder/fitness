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
    print(trainerList[0]);
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
                          color: Color(0xff363491),
                          fontSize: 30,
                          fontWeight: FontWeight.w800),
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
                  return GestureDetector(
                    onTap: () {
                      print(trainerList[index]);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Trainer(data: trainerList[index])));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Color(0xb0891f90),
                          image: DecorationImage(
                              image: AssetImage('assets/yoga.png'),
                              fit: BoxFit.cover),
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
                                trainerList[index]['name'],
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                trainerList[index]['desc'],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Icon(Icons.handyman))),
                                      TextSpan(
                                        text: trainerList[index]['workouts'] ==
                                                null
                                            ? '0 Workouts'
                                            : '${trainerList[index]['workouts'].length} Workouts',
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

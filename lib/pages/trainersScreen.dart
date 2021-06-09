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
                      'Favorite Workouts',
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
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/yoga.png')),
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

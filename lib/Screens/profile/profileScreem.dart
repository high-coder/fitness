import 'package:fitness_app/Screens/HomeScreen/homePage.dart';
import 'package:fitness_app/Screens/myWorkouts/myworkout.dart';
import 'package:fitness_app/constants/MyColors.dart';
import 'package:fitness_app/constants/MyTextStyle.dart';
import 'package:fitness_app/providers/currentState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _dob = TextEditingController();

  FocusNode _nameFocus;
  FocusNode _dobFocus;

  String gender = "female";
  DateTime selectedDate;
  var d = 0;
  var m = 0;
  var y = 0;
  var ismale = false;
  var isUser = true;
  var checkbox = [false, false, false];

  void _updateCheckbox(int position) {
    setState(() {
      checkbox[position] = !checkbox[position];
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        d = selectedDate.day;
        m = selectedDate.month;
        y = selectedDate.year;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _nameFocus = FocusNode();

    _dobFocus = FocusNode();

    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);

    if (_instance.currentUser.gender != null) {
      gender = _instance.currentUser.gender;
      if (gender == "male") {
        ismale = true;
      } else {
        ismale = false;
      }
      setState(() {});
    }

    if(_instance.currentUser.name!= null) {
      _name.text = _instance.currentUser.name;
    }

    if (_instance.currentUser.dob != null) {
      d = _instance.currentUser.dob.day;
      m = _instance.currentUser.dob.month;
      y = _instance.currentUser.dob.year;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameFocus.dispose();

    _dobFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        elevation: 0,
        title: Text(
          'Enter your details',
          style: MyTextStyle.text3,
        ),
      ),
      bottomNavigationBar: Consumer<CurrentState>(
        builder: (context, _, __) {
          return GestureDetector(
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyLocalWorkouts()));

            },
            child: Container(
              height: height * 0.08,
              color: MyColors.blue_ribbon,
              child: Center(
                child: Text(
                  "My Workouts",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
          );
        },
        //child: ,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 10, left: 45, right: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 115,
                    width: 115,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: MyColors.blue_ribbon),
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: MyColors.blue_ribbon, borderRadius: BorderRadius.circular(100)),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'NAME',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 28),
                    child: TextField(

                      enabled: false,
                      focusNode: _nameFocus,
                      controller: _name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'DATE OF BIRTH',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 28),
                    child: GestureDetector(
                      onTap: () {
                        //_selectDate(context);
                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 2, color: Colors.black38)),
                          height: 50,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment:
                            d != 0 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                            children: [
                              if (d != 0) Center(child: Text('$d - $m - $y')),
                              Icon(
                                Icons.calendar_today_rounded,
                                color: MyColors.blue_ribbon,
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'GENDER',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 28),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ismale ? MyColors.blue_ribbon : null,
                                border: !ismale ? Border.all(width: 2, color: Colors.grey) : null,
                              ),
                              child: Center(
                                  child: Text(
                                    'Male',
                                    style: ismale ? MyTextStyle.text4 : MyTextStyle.text3,
                                  )),
                              height: 50,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   ismale = false;
                              //   gender = "female";
                              // });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: !ismale ? MyColors.blue_ribbon : null,
                                border: ismale ? Border.all(width: 2, color: Colors.grey) : null,
                              ),
                              height: 50,
                              child: Center(
                                  child: Text(
                                    'Female',
                                    style: !ismale ? MyTextStyle.text4 : MyTextStyle.text3,
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 15),
              //       child: Text(
              //         'User Type',
              //         style: MyTextStyle.referEarnText,
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(top: 7, bottom: 28),
              //       child: Row(
              //         children: [
              //           Expanded(
              //             child: GestureDetector(
              //               onTap: () {
              //                 setState(() {
              //                   isUser = true;
              //                 });
              //               },
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(10),
              //                   color: isUser ? MyColors.blue_ribbon : null,
              //                   border: !isUser ? Border.all(width: 2, color: Colors.grey) : null,
              //                 ),
              //                 child: Center(
              //                     child: Text(
              //                       'User',
              //                       style: isUser ? MyTextStyle.text4 : MyTextStyle.text3,
              //                     )),
              //                 height: 50,
              //               ),
              //             ),
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Expanded(
              //             child: GestureDetector(
              //               onTap: () {
              //                 setState(() {
              //                   isUser = false;
              //                 });
              //               },
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(10),
              //                   color: !isUser ? MyColors.blue_ribbon : null,
              //                   border: isUser ? Border.all(width: 2, color: Colors.grey) : null,
              //                 ),
              //                 height: 50,
              //                 child: Center(
              //                     child: Text(
              //                       'Trainer',
              //                       style: !isUser ? MyTextStyle.text4 : MyTextStyle.text3,
              //                     )),
              //               ),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

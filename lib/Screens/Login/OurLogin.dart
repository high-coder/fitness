
import 'package:fitness_app/constants/MyColors.dart';
import 'package:fitness_app/constants/MyTextStyle.dart';
import 'package:fitness_app/constants/constants.dart';
import 'package:fitness_app/providers/currentState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OurLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen:false);
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topCenter,
                        colors: colors,
                        //stops: stops
                      )
                  ),
                  width: _width,
                  height: _height -29,

                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 100.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 20.0,
                        ),
                        // alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 20.0,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Take a moment for yourself",
                                style: MyTextStyle.heading4,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 5.0,
                                width: 70.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  color: MyColors.lightgrey3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 20.0,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "We provide mechanical and repairing services to people which they can access from anywhere and anytime.",
                          style: MyTextStyle.text10,
                        ),
                      ),
                      Consumer<CurrentState>(
                        builder: (context, _,Widget child) {
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: 20.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 1.0, color: _instance.customColor),
                              ),
                            ),
                            child: TextFormField(
                              onChanged: (input) {
                                _instance.validator(input);
                                // phoneNo = "+91" + input;
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                // ignore: deprecated_member_use
                                WhitelistingTextInputFormatter.digitsOnly,
                              ],
                              maxLines: null,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your phone no.',
                                icon: Icon(
                                  Icons.smartphone_sharp,
                                  color: _instance.customColor,
                                ),
                              ),
                            ),
                          );
                        },
                        //child: ,
                      ),
                      Consumer<CurrentState>(
                        builder:(context, _, Widget child) {
                          return GestureDetector(
                            onTap: () {
                              print("The button is not disable");
                              //Navigator.pushNamed(context, "/verify");
                              //_instance.loginUserWithGoogle();
                            },
                            child: Container(
                              height: _height / 15,
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 20.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                color:  MyColors.shopButton,
                              ),
                              child: child,
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:20.0),
                              child: Text(
                                "Sign in with google",
                                style: MyTextStyle.shopButton2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Icon(
                                Icons.arrow_forward_sharp,
                                color: MyColors.yellowish,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<CurrentState>(
                        builder:(context, _, Widget child) {
                          return AbsorbPointer(
                            absorbing: _instance.disableButton,
                            child: GestureDetector(
                              onTap: () {
                                print("The button is not disable");
                                //Navigator.pushNamed(context, "/verify");
                                _instance.login(context);
                              },
                              child: Container(
                                height: _height / 15,
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 20.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  color: _instance.disableButton == true ? MyColors.shopButton.withOpacity(0.7) : MyColors.shopButton,
                                ),
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 150.0),
                              child: Text(
                                "Continue",
                                style: MyTextStyle.shopButton2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Icon(
                                Icons.arrow_forward_sharp,
                                color: MyColors.yellowish,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

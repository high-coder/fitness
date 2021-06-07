
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/constants/MyColors.dart';
import 'package:fitness_app/constants/MyTextStyle.dart';
import 'package:fitness_app/providers/currentState.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class Verification extends StatefulWidget {
  //final String phone;
  //Verification(this.phone);
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  String _verificationCode;
  final _codeController = TextEditingController();
  @override
  // _verifyPhone() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       //phoneNumber: '+91${widget.phone}',
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await FirebaseAuth.instance
  //             .signInWithCredential(credential)
  //             .then((value) async {
  //           if (value.user != null) {
  //             Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => HomeScreen()),
  //                 (route) => false);
  //           }
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e.message);
  //       },
  //       codeSent: (String verficationID, int resendToken) {
  //         setState(() {
  //           _verificationCode = verficationID;
  //         });
  //       },
  //       codeAutoRetrievalTimeout: (String verificationID) {
  //         setState(() {
  //           _verificationCode = verificationID;
  //         });
  //       },
  //       timeout: Duration(seconds: 120));
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_verifyPhone();
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen:false);

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Verification",
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
                    "Enter the verification code sent \non your associated phone number.",
                    style: MyTextStyle.text10,
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 50.0,
                          bottom: 5.0,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "CODE",
                          style: MyTextStyle.text10,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: PinEntryTextField(
                          fields: 6,
                          showFieldAsBox: true,
                          // onSubmit: (pin) async {
                          //   print('submitted');
                          //   try {
                          //     await FirebaseAuth.instance
                          //         .signInWithCredential(
                          //             PhoneAuthProvider.credential(
                          //                 verificationId: _verificationCode,
                          //                 smsCode: pin))
                          //         .then((value) async {
                          //       if (value.user != null) {
                          //         Navigator.pushAndRemoveUntil(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) => HomeScreen()),
                          //             (route) => false);
                          //       }
                          //     });
                          //   } catch (e) {
                          //     FocusScope.of(context).unfocus();
                          //     // _scaffoldkey.currentState.showSnackBar(
                          //     //     SnackBar(content: Text('invalid OTP')));
                          //   }
                          // },

                          //fieldWidth: ,
                          isTextObscure: false,
                          onSubmit: (value) {
                            _verificationCode = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      onPressed: () {},//_verifyPhone,
                      child: Text(
                        "Resend code?",
                        style: MyTextStyle.text11,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        //Navigator.pushReplacementNamed(context, "/login");
                        _instance.verifyOtp(_verificationCode, context);
                      },
                      child: Container(
                        height: _height / 15,
                        width: _width / 3,
                        margin: EdgeInsets.only(top: 20.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          color: MyColors.shopButton,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Verify",
                                style: MyTextStyle.shopButton2,
                              ),
                              Icon(
                                Icons.arrow_forward_sharp,
                                color: MyColors.yellowish,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class _VerificationState extends State<Verification> {
//   final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
//   String _verificationCode;
//   final TextEditingController _pinPutController = TextEditingController();
//   final FocusNode _pinPutFocusNode = FocusNode();
//   final BoxDecoration pinPutDecoration = BoxDecoration(
//     color: const Color.fromRGBO(43, 46, 66, 1),
//     borderRadius: BorderRadius.circular(10.0),
//     border: Border.all(
//       color: const Color.fromRGBO(126, 203, 224, 1),
//     ),
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldkey,
//       appBar: AppBar(
//         title: Text('OTP Verification'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: 40),
//             child: Center(
//               child: Text(
//                 'Verify +91-${widget.phone}',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(30.0),
//             child: PinPut(
//               fieldsCount: 6,
//               textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
//               eachFieldWidth: 40.0,
//               eachFieldHeight: 55.0,
//               focusNode: _pinPutFocusNode,
//               controller: _pinPutController,
//               submittedFieldDecoration: pinPutDecoration,
//               selectedFieldDecoration: pinPutDecoration,
//               followingFieldDecoration: pinPutDecoration,
//               pinAnimationType: PinAnimationType.fade,
//               onSubmit: (pin) async {},
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

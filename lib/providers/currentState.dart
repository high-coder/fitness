import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/Screens/HomeScreen/homePage.dart';
import 'package:fitness_app/Screens/Login/newUserDetails.dart';
import 'package:fitness_app/Screens/Login/verification.dart';
import 'package:fitness_app/constants/MyColors.dart';
import 'package:fitness_app/modelss/ourUser.dart';
import 'package:fitness_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentState extends ChangeNotifier{
  Color customColor = MyColors.pureblack;
  bool disableButton = true;
  String _inputText;
  OurUser currentUser = OurUser();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  validator(String input) {
    _inputText = "+91" + input;
    print(_inputText);
    if (input.length < 10) {
      disableButton = true;
      if (customColor == Colors.red) {
        print("Do nothing");
      } else {
        print("notifying the listeneers");
        customColor = Colors.red;
        notifyListeners();
      }
      //return "Invalid Phone number";
    } else {
      disableButton = false;
      customColor = MyColors.pureblack;
      notifyListeners();
    }
  }



  String phoneNo, smsSent, _verificationId;

  Future<void> login(context) async {
    print(_inputText);
    disableButton = true;

    print("this function is being called");

    // PhoneVerificationCompleted verificationCompleted = (
    //     PhoneAuthCredential phoneAuthCredential) async {
    //   print("Step 1");
    //   //await _auth.signInWithCredential(phoneAuthCredential);
    // };
    final PhoneVerificationCompleted verifiedSuccess =
        (PhoneAuthCredential phoneAuthCredential) {
      print("the verification is successfull");
      //Navigator.of(context).pushNamed(context, "/verify");
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      disableButton = false;
      print(authException);
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceCodeResent]) async {
      print("the code has been sent to your mobile");
      _verificationId = verificationId;
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Verification()));

      // Here we have to navigate the user to the otp entering page
      // Navigator.of(context).push(MaterialPageRoute(
      //   //builder: (context) => OtpScreen(),
      // ));
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    try {
      print("Inside the try ");
      print(_inputText);
      await _auth.verifyPhoneNumber(
        phoneNumber: _inputText,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  verifyOtp(String input, context) async {
    print(input);
    String retVal = "error";
    OurUser _user = OurUser();
    print(input);
    final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: input);
    try {
      //  await _auth.signInWithCredential(credential);
      UserCredential _authResult = await _auth.signInWithCredential(credential);

      // Here i have to save the details of the user in the database
      if (_authResult.additionalUserInfo.isNewUser) {
        currentUser.uid = _authResult.user.uid;
        currentUser.phone = _inputText;
        currentUser.type = "Customer";

        retVal = await OurDatabase().createUser(currentUser);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
        // after this send the user to the create page where he might enter his name and option to select trainer
      } else {
        // get the information of the user from the database this already exists
        currentUser = await OurDatabase().getUserInfo(_authResult.user.uid);
        if(currentUser!= null) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> OurHome()),ModalRoute.withName('/'), );

        }
      }
      print("End of the await");

      // when signup with the otp
      if (retVal == "success") {
        print("why not inside this mane");
        Navigator.pushNamedAndRemoveUntil(
            context, "/homescreen", (route) => false);
      }

      //saveAllData();
    } catch (e) {
      print(e);
      print("Something went wrong");
      //prin
    }
  }

  bool buttonNotActive = false;
  String buttonValue = "Take Me Home";
  saveNewUserData(Map<String,dynamic> user) async{
    String _retVal = "something went wrong";
    buttonNotActive = true;
    buttonValue = "home........";
    notifyListeners();
    try{

      await OurDatabase().updateUserData(_auth.currentUser.uid, user);
      _retVal = "success";
    } catch(E) {
      buttonValue = "Take me home";
      buttonNotActive = false;
    }
    buttonValue = "Take me home";
    buttonNotActive = false;
    notifyListeners();
    return _retVal;
  }



}
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/Screens/HomeScreen/homePage.dart';
import 'package:fitness_app/Screens/Login/newUserDetails.dart';
import 'package:fitness_app/Screens/Login/verification.dart';
import 'package:fitness_app/constants/MyColors.dart';
import 'package:fitness_app/modelss/ourUser.dart';
import 'package:fitness_app/modelss/stepsModel.dart';
import 'package:fitness_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pedometer/pedometer.dart';

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
    UserData = await Hive.openBox("userData");

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
        currentUser.steps = [];
        retVal = await OurDatabase().createUser(currentUser);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
        // after this send the user to the create page where he might enter his name and option to select trainer
      } else {
        // get the information of the user from the database this already exists
        currentUser = await OurDatabase().getUserInfo(_authResult.user.uid);
        if(currentUser.steps == null) {
          currentUser.steps =[];
        }
        UserData.put("user", currentUser);
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
      currentUser.gender = user["gender"];
      currentUser.name = user["fullName"];
      currentUser.dob = user["dob"];
      UserData.put("user", currentUser);

    } catch(E) {
      buttonValue = "Take me home";
      buttonNotActive = false;
    }
    buttonValue = "Take me home";
    buttonNotActive = false;
    notifyListeners();
    return _retVal;
  }

  /// ----------------------- beginning the code for the pedometer over here now -----------------
  // Pedometer _pedometer;
  // StreamSubscription<int> _subscription;
  // Box<int> stepsBox = Hive.box('steps');
  // int todaySteps;
  //
  // final Color carbonBlack = Color(0xff1a1a1a);
  //
  //
  // void startListening() {
  //   _pedometer = Pedometer();
  //   print("beginning the subscriptionno");
  //   // _subscription = _pedometer.pedometerStream.listen(
  //   //   getTodaySteps,
  //   //   onError: _onError,
  //   //   onDone: _onDone,
  //   //   cancelOnError: true,
  //   // );
  // }
  //
  //
  // void _onDone() => print("Finished pedometer tracking");
  // void _onError(error) => print("Flutter Pedometer Error: $error");
  //
  // Future<int> getTodaySteps(int value) async {
  //   print(value);
  //   int savedStepsCountKey = 999999;
  //   int savedStepsCount = stepsBox.get(savedStepsCountKey, defaultValue: 0);
  //   print("The saved steps count is $savedStepsCount");
  //   int todayDayNo = Jiffy(DateTime.now()).dayOfYear;
  //   print("The today day number is $todayDayNo");
  //   if (value < savedStepsCount) {
  //     // Upon device reboot, pedometer resets. When this happens, the saved counter must be reset as well.
  //     savedStepsCount = 0;
  //     // persist this value using a package of your choice here
  //     stepsBox.put(savedStepsCountKey, savedStepsCount);
  //   }
  //
  //   // load the last day saved using a package of your choice here
  //   int lastDaySavedKey = 888888;
  //   int lastDaySaved = stepsBox.get(lastDaySavedKey, defaultValue: 0);
  //   print("the last day saved steps is equal to $lastDaySaved");
  //   // When the day changes, reset the daily steps count
  //   // and Update the last day saved as the day changes.
  //   if (lastDaySaved < todayDayNo) {
  //     lastDaySaved = todayDayNo;
  //     print("the today day number is equal to $todayDayNo");
  //     savedStepsCount = value;
  //
  //     stepsBox
  //       ..put(lastDaySavedKey, lastDaySaved)
  //       ..put(savedStepsCountKey, savedStepsCount);
  //   }
  //
  //     print("the value is $value");
  //     print('the saved is $savedStepsCount');
  //     todaySteps = value - savedStepsCount;
  //     notifyListeners();
  //   stepsBox.put(todayDayNo, todaySteps);
  //   return todaySteps; // this is your daily steps value.
  // }
  //
  // void stopListening() {
  //   _subscription.cancel();
  // }

  /// ------------------------ this is commented might be used in the fututer



  // --------------------------- Begin the code for the -------------------------------//


  Box UserData;

  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String status = '?', steps = '?';
  Box<int> stepsBox = Hive.box('steps');

  void onStepCount(StepCount event) {
    // print(currentUser.steps.length);
    // print(currentUser.steps[0].steps);
    print(event);
    //setState(() {
      steps = event.steps.toString();
    //});
    notifyListeners();
    print(event.steps);
    int savedStepsCountKey = 999999;
    int savedStepsCount = stepsBox.get(savedStepsCountKey, defaultValue: 0);
    print("The saved steps count is $savedStepsCount");
    int todayDayNo = Jiffy(DateTime.now()).dayOfYear;
    print("The today day number is $todayDayNo");
    if (event.steps < savedStepsCount) {
      // Upon device reboot, pedometer resets. When this happens, the saved counter must be reset as well.
      savedStepsCount = 0;
      // persist this value using a package of your choice here
      stepsBox.put(savedStepsCountKey, savedStepsCount);
    }

    // load the last day saved using a package of your choice here
    int lastDaySavedKey = 888888;
    int lastDaySaved = stepsBox.get(lastDaySavedKey, defaultValue: 0);
    print("the last day saved steps is equal to $lastDaySaved");
    // When the day changes, reset the daily steps count
    // and Update the last day saved as the day changes.
    if (lastDaySaved < todayDayNo) {
      lastDaySaved = todayDayNo;
      print("the today day number is equal to $todayDayNo");
      savedStepsCount = event.steps;

      stepsBox
        ..put(lastDaySavedKey, lastDaySaved)
        ..put(savedStepsCountKey, savedStepsCount);
    }

    //setState(() {
      print("the value is ${event.steps}");
      print('the saved is $savedStepsCount');
    steps  = (event.steps.toInt() - savedStepsCount).toString();

    if(currentUser.steps.isEmpty) {
        currentUser.steps.insert(0, StepsModel(
          steps:int.parse(steps),
          date: DateTime.now(),
          calories: 0.03 * int.parse(steps),    // will need to change this thing in the future to a more reasonable thing
        ));
      }
    else {
      if((DateTime.now().year == currentUser.steps[0].date.year) && (DateTime.now().month == currentUser.steps[0].date.month) && (DateTime.now().day == currentUser.steps[0].date.day)) {
        currentUser.steps[0].steps = int.parse(steps);
        currentUser.steps[0].calories =  0.03 * int.parse(steps);
      } else {
        currentUser.steps.insert(0, StepsModel(
          steps: int.parse(steps),
          date: DateTime.now(),
          calories:  0.03 * int.parse(steps),   // will need to change this thing in the future to a more reasonable thing
        ));
      }
    }
    //});
    stepsBox.put(todayDayNo, int.parse(steps));
    //return status; // this is your daily steps value.


  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    //setState(() {
      status = event.status;
    //});
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    //setState(() {
      status = 'Pedestrian Status not available';
    //});
    print(status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    //setState(() {
      steps = 'Step Count not available';
    //});
  }

  void initPlatformState() {

    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    //if (!mounted) return;
  }
  Future<String> onStartApi() async {


    String _retVal = "error";
    UserData = await Hive.openBox("userData");

    try {
      currentUser =  UserData.get("user");


      // print(currentUser.name);
      print(currentUser.name);
      if (currentUser.name != null) {
        _retVal = "success";
      }
    } catch (e) {
      print(e);
      // the user is not logged in
    }
    initPlatformState();

    return _retVal;
  }
}
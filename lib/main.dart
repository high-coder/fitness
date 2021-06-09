import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/Screens/Login/OurLogin.dart';
import 'package:fitness_app/modelss/caloriesTrackerModel.dart';
import 'package:fitness_app/modelss/stepsModel.dart';
import 'package:fitness_app/pages/newWorkout.dart';
import 'package:fitness_app/pages/nutrition.dart';
import 'package:fitness_app/pages/trainer.dart';
import 'package:fitness_app/pages/trainersScreen.dart';
import 'package:fitness_app/providers/currentState.dart';
import 'package:fitness_app/services/loginChecker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'modelss/ourUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(OurUserHiveGen());
  Hive.registerAdapter(StepsModelHiveGen());
  Hive.registerAdapter(CaloriesTrackerHiveGen());
  await Hive.openBox<int>('steps');
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentState>(
          create: (context) => CurrentState(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            textTheme: GoogleFonts.darkerGrotesqueTextTheme(
              Theme.of(context).textTheme,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // darkTheme: ThemeData.dark().copyWith(
          //   textTheme: GoogleFonts.darkerGrotesqueTextTheme(
          //     Theme.of(context).textTheme,
          //   ),
          // ),
          home: Root()),
    );
  }
}

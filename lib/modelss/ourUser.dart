import 'package:fitness_app/modelss/caloriesTrackerModel.dart';
import 'package:fitness_app/modelss/localCourseModel.dart';
import 'package:fitness_app/modelss/stepsModel.dart';
import 'package:hive/hive.dart';

part 'ourUser.g.dart';

@HiveType(typeId: 134, adapterName: "OurUserHiveGen")
class OurUser{

  @HiveField(0)
  String uid;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String name;

  @HiveField(3)
  String type;  // customer or trainer

  @HiveField(4)
  String gender;

  @HiveField(5)
  DateTime dob;

  @HiveField(6)
  List<StepsModel> steps = [];

  @HiveField(7)
  List calories = [];

  @HiveField(8)
  List localCourses = [];

  @HiveField(9)
  List purchasedCourses = [];


  @HiveField(10)
  List<CaloriesTracker> caloriesList = [];

  OurUser({this.phone,this.name,this.type,this.uid, this.dob,this.gender,this.steps, this.calories,this.localCourses,this.purchasedCourses, this.caloriesList});


  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'phone':phone,
      'fullName':name,
      //'email':email,
      'type':type,
      'dob':dob,
      'steps':steps,
      'calories':calories,
      'workouts':localCourses,
      'purchasedCourses':purchasedCourses,
      'caloriesList':caloriesList
    };
  }


  //OurUser = OurUser.toInstance(json);


  OurUser toInstance(Map<String, dynamic> json) {
    return OurUser(
      uid: json['uid'],
      phone: json['phone'],
      type: json['type'],
      name: json['fullName'],
      gender: json['gender'],
      dob: json['dob'] != null ? json['dob'].toDate() : json['dob'],
      steps: json['steps'],
      calories: json['calories'],
      localCourses: json['workouts'],
      purchasedCourses: json["purchasedCourses"],
      caloriesList: json['caloriesList']
    );
  }
}
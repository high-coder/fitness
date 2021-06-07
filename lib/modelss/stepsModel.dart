import 'package:hive/hive.dart';

part 'stepsModel.g.dart';

@HiveType(typeId: 133, adapterName: "StepsModelHiveGen")
class StepsModel {

  @HiveField(0)
  int steps;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  double calories;


  StepsModel({this.steps,this.date,this.calories});
}
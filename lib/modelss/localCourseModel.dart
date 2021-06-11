import 'package:hive/hive.dart';

part 'localCourseModel.g.dart';
@HiveType(typeId: 139, adapterName: "LocalCourseModelHiveGen")

class LocalCourseModel {
  @HiveField(0)
  Map details;

  @HiveField(1)
  List exercises;

  LocalCourseModel({this.exercises,this.details});


}
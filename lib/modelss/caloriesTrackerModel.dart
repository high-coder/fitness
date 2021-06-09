
import 'package:hive/hive.dart';


part 'caloriesTrackerModel.g.dart';
@HiveType(typeId: 135, adapterName: "CaloriesTrackerHiveGen")
class CaloriesTracker {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  List caloriesData = [];

  CaloriesTracker({this.date,this.caloriesData});
}
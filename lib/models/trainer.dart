class TrainerModel {
  final String trainerName;
  final String trainerDesc;
  final List workouts;
  TrainerModel({this.trainerName, this.trainerDesc, this.workouts});



  Map<String,dynamic> toMap() {
    return {
      'trainerName' :trainerName,
      'trainerDesc':trainerDesc,

    };
  }


}

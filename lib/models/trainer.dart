class ExerciseModel {
  final String exerciseName;
  final String exerciseDesc;

  final String exerciseType;
  final String rounds;
  final String sets;
  final String image;

  ExerciseModel({this.image, this.exerciseType, this.exerciseName, this.exerciseDesc, this.rounds, this.sets});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': exerciseName,
      'type': exerciseType,
      'desc': exerciseDesc,
      'repetition': rounds,
      'set': sets
    };
  }
}

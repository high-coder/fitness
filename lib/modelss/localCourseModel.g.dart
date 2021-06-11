// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localCourseModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalCourseModelHiveGen extends TypeAdapter<LocalCourseModel> {
  @override
  final int typeId = 139;

  @override
  LocalCourseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalCourseModel(
      exercises: (fields[1] as List)?.cast<dynamic>(),
      details: (fields[0] as Map)?.cast<dynamic, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, LocalCourseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.details)
      ..writeByte(1)
      ..write(obj.exercises);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalCourseModelHiveGen &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

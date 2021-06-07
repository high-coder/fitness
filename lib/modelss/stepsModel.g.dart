// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stepsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StepsModelHiveGen extends TypeAdapter<StepsModel> {
  @override
  final int typeId = 133;

  @override
  StepsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StepsModel(
      steps: fields[0] as int,
      date: fields[1] as DateTime,
      calories: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, StepsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.steps)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.calories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepsModelHiveGen &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caloriesTrackerModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaloriesTrackerHiveGen extends TypeAdapter<CaloriesTracker> {
  @override
  final int typeId = 135;

  @override
  CaloriesTracker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaloriesTracker(
      date: fields[0] as DateTime,
      caloriesData: (fields[1] as List)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, CaloriesTracker obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.caloriesData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaloriesTrackerHiveGen &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

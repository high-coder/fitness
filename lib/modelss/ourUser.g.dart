// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ourUser.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OurUserHiveGen extends TypeAdapter<OurUser> {
  @override
  final int typeId = 134;

  @override
  OurUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OurUser(
      phone: fields[1] as String,
      name: fields[2] as String,
      type: fields[3] as String,
      uid: fields[0] as String,
      dob: fields[5] as DateTime,
      gender: fields[4] as String,
      steps: (fields[6] as List)?.cast<StepsModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, OurUser obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.dob)
      ..writeByte(6)
      ..write(obj.steps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OurUserHiveGen &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

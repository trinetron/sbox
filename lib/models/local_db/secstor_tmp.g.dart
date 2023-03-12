// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secstor_tmp.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChivetmpAdapter extends TypeAdapter<C_hive_tmp> {
  @override
  final int typeId = 2;

  @override
  C_hive_tmp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return C_hive_tmp(
      id: fields[0] as String,
      note: fields[1] as String,
      task: fields[2] as String,
      login: fields[3] as String,
      pass: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, C_hive_tmp obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.task)
      ..writeByte(3)
      ..write(obj.login)
      ..writeByte(4)
      ..write(obj.pass);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChivetmpAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

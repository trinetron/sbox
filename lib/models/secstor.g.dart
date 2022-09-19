// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secstor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<C_hive> {
  @override
  final int typeId = 0;

  @override
  C_hive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return C_hive(
      complete: fields[1] as bool,
      note: fields[2] as String,
      task: fields[3] as String,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, C_hive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.complete)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.task);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

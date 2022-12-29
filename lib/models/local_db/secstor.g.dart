// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secstor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChiveAdapter extends TypeAdapter<C_hive> {
  @override
  final int typeId = 0;

  @override
  C_hive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return C_hive(
      id: fields[0] as String,
      complete: fields[1] as bool,
      note: fields[2] as String,
      task: fields[3] as String,
      login: fields[4] as String,
      pass: fields[5] as String,
      card: fields[6] as String,
      name: fields[7] as String,
      date: fields[8] as String,
      cvv: fields[9] as String,
      pin: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, C_hive obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.complete)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.task)
      ..writeByte(4)
      ..write(obj.login)
      ..writeByte(5)
      ..write(obj.pass)
      ..writeByte(6)
      ..write(obj.card)
      ..writeByte(7)
      ..write(obj.name)
      ..writeByte(8)
      ..write(obj.date)
      ..writeByte(9)
      ..write(obj.cvv)
      ..writeByte(10)
      ..write(obj.pin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

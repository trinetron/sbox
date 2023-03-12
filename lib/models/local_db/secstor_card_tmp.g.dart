// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secstor_card_tmp.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChiveCardtmpAdapter extends TypeAdapter<C_hiveCard_tmp> {
  @override
  final int typeId = 3;

  @override
  C_hiveCard_tmp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return C_hiveCard_tmp(
      id: fields[0] as String,
      note: fields[1] as String,
      card: fields[2] as String,
      name: fields[3] as String,
      date: fields[4] as String,
      dateExp: fields[5] as String,
      cvv: fields[6] as String,
      pinAtm: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, C_hiveCard_tmp obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.card)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.dateExp)
      ..writeByte(6)
      ..write(obj.cvv)
      ..writeByte(7)
      ..write(obj.pinAtm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChiveCardtmpAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

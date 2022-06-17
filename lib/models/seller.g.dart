// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SellerAdapter extends TypeAdapter<Seller> {
  @override
  final int typeId = 0;

  @override
  Seller read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Seller(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as double,
      fields[9] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Seller obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.range)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.pass)
      ..writeByte(7)
      ..write(obj.num)
      ..writeByte(8)
      ..write(obj.long)
      ..writeByte(9)
      ..write(obj.latte);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SellerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

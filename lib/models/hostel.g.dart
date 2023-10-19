// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hostel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HostelModelAdapter extends TypeAdapter<HostelModel> {
  @override
  final int typeId = 0;

  @override
  HostelModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HostelModel(
      id: fields[0] as int,
      name: fields[1] as String,
      logo: fields[2] as String,
      city: fields[3] as String,
      gender: fields[4] as String,
      slug: fields[5] as String,
      phoneNumber: fields[6] as String,
      district: fields[7] as String?,
      startingPrice: fields[8] as String?,
      ownerName: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HostelModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.logo)
      ..writeByte(3)
      ..write(obj.city)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.slug)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.district)
      ..writeByte(8)
      ..write(obj.startingPrice)
      ..writeByte(9)
      ..write(obj.ownerName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HostelModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

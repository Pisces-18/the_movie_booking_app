// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeatVOAdapter extends TypeAdapter<SeatVO> {
  @override
  final int typeId = 19;

  @override
  SeatVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeatVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SeatVO obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.seatName)
      ..writeByte(3)
      ..write(obj.symbol)
      ..writeByte(4)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatVO _$SeatVOFromJson(Map<String, dynamic> json) => SeatVO(
      json['id'] as int?,
      json['type'] as String?,
      json['seat_name'] as String?,
      json['symbol'] as String?,
      json['price'] as int?,
    );

Map<String, dynamic> _$SeatVOToJson(SeatVO instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'seat_name': instance.seatName,
      'symbol': instance.symbol,
      'price': instance.price,
    };

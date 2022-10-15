// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_time_slots_status_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemaTimeSlotsStatusVOAdapter
    extends TypeAdapter<CinemaTimeSlotsStatusVO> {
  @override
  final int typeId = 14;

  @override
  CinemaTimeSlotsStatusVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemaTimeSlotsStatusVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CinemaTimeSlotsStatusVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaTimeSlotsStatusVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaTimeSlotsStatusVO _$CinemaTimeSlotsStatusVOFromJson(
        Map<String, dynamic> json) =>
    CinemaTimeSlotsStatusVO(
      json['id'] as int?,
      json['title'] as String?,
      json['color'] as String?,
    );

Map<String, dynamic> _$CinemaTimeSlotsStatusVOToJson(
        CinemaTimeSlotsStatusVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'color': instance.color,
    };

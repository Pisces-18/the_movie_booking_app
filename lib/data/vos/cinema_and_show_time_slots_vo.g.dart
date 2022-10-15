// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_and_show_time_slots_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemaAndShowTimeSlotsVOAdapter
    extends TypeAdapter<CinemaAndShowTimeSlotsVO> {
  @override
  final int typeId = 17;

  @override
  CinemaAndShowTimeSlotsVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemaAndShowTimeSlotsVO(
      fields[0] as int?,
      fields[1] as String?,
      (fields[2] as List?)?.cast<TimeSlotVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, CinemaAndShowTimeSlotsVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cinemaId)
      ..writeByte(1)
      ..write(obj.cinema)
      ..writeByte(2)
      ..write(obj.timeslots);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaAndShowTimeSlotsVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaAndShowTimeSlotsVO _$CinemaAndShowTimeSlotsVOFromJson(
        Map<String, dynamic> json) =>
    CinemaAndShowTimeSlotsVO(
      json['cinema_id'] as int?,
      json['cinema'] as String?,
      (json['timeslots'] as List<dynamic>?)
          ?.map((e) => TimeSlotVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CinemaAndShowTimeSlotsVOToJson(
        CinemaAndShowTimeSlotsVO instance) =>
    <String, dynamic>{
      'cinema_id': instance.cinemaId,
      'cinema': instance.cinema,
      'timeslots': instance.timeslots,
    };

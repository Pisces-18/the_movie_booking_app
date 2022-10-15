// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_and_show_time_by_date_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemaAndShowTimeByDateVOAdapter
    extends TypeAdapter<CinemaAndShowTimeByDateVO> {
  @override
  final int typeId = 24;

  @override
  CinemaAndShowTimeByDateVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemaAndShowTimeByDateVO(
      (fields[2] as List?)?.cast<CinemaAndShowTimeSlotsVO>(),
      fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CinemaAndShowTimeByDateVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaAndShowTimeByDateVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaAndShowTimeByDateVO _$CinemaAndShowTimeByDateVOFromJson(
        Map<String, dynamic> json) =>
    CinemaAndShowTimeByDateVO(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              CinemaAndShowTimeSlotsVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['date'] as String?,
    );

Map<String, dynamic> _$CinemaAndShowTimeByDateVOToJson(
        CinemaAndShowTimeByDateVO instance) =>
    <String, dynamic>{
      'data': instance.data,
      'date': instance.date,
    };

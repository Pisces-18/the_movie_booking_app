// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditVOAdapter extends TypeAdapter<CreditVO> {
  @override
  final int typeId = 7;

  @override
  CreditVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreditVO(
      fields[0] as int?,
      (fields[1] as List?)?.cast<ActorVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, CreditVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cast);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditVO _$CreditVOFromJson(Map<String, dynamic> json) => CreditVO(
      json['id'] as int?,
      (json['cast'] as List<dynamic>?)
          ?.map((e) => ActorVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreditVOToJson(CreditVO instance) => <String, dynamic>{
      'id': instance.id,
      'cast': instance.cast,
    };

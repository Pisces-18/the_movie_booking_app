// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfigVOAdapter extends TypeAdapter<ConfigVO> {
  @override
  final int typeId = 13;

  @override
  ConfigVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConfigVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, ConfigVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.key)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigVO _$ConfigVOFromJson(Map<String, dynamic> json) => ConfigVO(
      json['id'] as int?,
      json['key'] as String?,
      json['value'],
    );

Map<String, dynamic> _$ConfigVOToJson(ConfigVO instance) => <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'value': instance.value,
    };

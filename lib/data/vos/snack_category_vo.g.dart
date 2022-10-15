// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snack_category_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SnackCategoryVOAdapter extends TypeAdapter<SnackCategoryVO> {
  @override
  final int typeId = 20;

  @override
  SnackCategoryVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SnackCategoryVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as int?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SnackCategoryVO obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.titleMM)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.deletedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnackCategoryVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnackCategoryVO _$SnackCategoryVOFromJson(Map<String, dynamic> json) =>
    SnackCategoryVO(
      json['id'] as int?,
      json['title'] as String?,
      json['title_mm'] as String?,
      json['is_active'] as int?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['deleted_at'] as String?,
    );

Map<String, dynamic> _$SnackCategoryVOToJson(SnackCategoryVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'title_mm': instance.titleMM,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };

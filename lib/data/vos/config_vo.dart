import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';

part 'config_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CONFIG_VO,adapterName: "ConfigVOAdapter")
class ConfigVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "key")
  @HiveField(1)
  String? key;

  @JsonKey(name: "value")
  @HiveField(2)
  dynamic value;

  ConfigVO(this.id, this.key, this.value);

  factory ConfigVO.fromJson(Map<String,dynamic> json)=>_$ConfigVOFromJson(json);

  Map<String,dynamic> toJson()=>_$ConfigVOToJson(this);
}

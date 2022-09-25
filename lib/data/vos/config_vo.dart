import 'package:json_annotation/json_annotation.dart';

import 'cinema_value_vo.dart';

part 'config_vo.g.dart';
@JsonSerializable()
class ConfigVO{
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "key")
  String? key;

  @JsonKey(name: "value")
  dynamic value;

  ConfigVO(this.id, this.key, this.value);

  factory ConfigVO.fromJson(Map<String,dynamic> json)=>_$ConfigVOFromJson(json);

  Map<String,dynamic> toJson()=>_$ConfigVOToJson(this);
}

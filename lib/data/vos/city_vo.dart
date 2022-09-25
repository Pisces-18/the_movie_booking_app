import 'package:json_annotation/json_annotation.dart';

part 'city_vo.g.dart';
@JsonSerializable()
class CityVO{
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  CityVO(this.id, this.name, this.createdAt, this.updatedAt);
  factory CityVO.fromJson(Map<String,dynamic> json) => _$CityVOFromJson(json);

  Map<String,dynamic> toJson() => _$CityVOToJson(this);
}
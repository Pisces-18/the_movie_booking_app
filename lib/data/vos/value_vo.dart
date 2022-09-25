import 'package:json_annotation/json_annotation.dart';

part 'value_vo.g.dart';
@JsonSerializable()
class ValueVO{
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "color")
  String? color;


  ValueVO(this.id, this.title,this.color);

  factory ValueVO.fromJson(Map<String,dynamic> json)=>_$ValueVOFromJson(json);

  Map<String,dynamic> toJson()=>_$ValueVOToJson(this);
}

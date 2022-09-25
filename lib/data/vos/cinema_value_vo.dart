import 'package:json_annotation/json_annotation.dart';

part 'cinema_value_vo.g.dart';
@JsonSerializable()
class CinemaValueVO{
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "color")
  String? color;

  CinemaValueVO(this.id, this.title, this.color);

  factory CinemaValueVO.fromJson(Map<String,dynamic> json)=>_$CinemaValueVOFromJson(json);

  Map<String,dynamic> toJson()=>_$CinemaValueVOToJson(this);
}

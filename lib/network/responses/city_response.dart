import 'package:json_annotation/json_annotation.dart';

part 'city_response.g.dart';
@JsonSerializable()
class CityResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;



  CityResponse(this.code, this.message);

  factory CityResponse.fromJson(Map<String,dynamic> json) => _$CityResponseFromJson(json);

  Map<String,dynamic> toJson() => _$CityResponseToJson(this);
}
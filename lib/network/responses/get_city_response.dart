import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';

part 'get_city_response.g.dart';
@JsonSerializable()
class GetCityResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<CityVO>? data;


  GetCityResponse(this.code, this.message, this.data);

  factory GetCityResponse.fromJson(Map<String,dynamic> json) => _$GetCityResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetCityResponseToJson(this);

}
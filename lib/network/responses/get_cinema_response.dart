import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/cinema_and_show_time_slots_vo.dart';
import '../../data/vos/cinema_vo.dart';

part 'get_cinema_response.g.dart';
@JsonSerializable()
class GetCinemaResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<CinemaVO>? data;

  @JsonKey(name: "latest_time")
  String? latestTime;

  GetCinemaResponse(this.code, this.message, this.data,this.latestTime);

  factory GetCinemaResponse.fromJson(Map<String,dynamic> json) => _$GetCinemaResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetCinemaResponseToJson(this);
}
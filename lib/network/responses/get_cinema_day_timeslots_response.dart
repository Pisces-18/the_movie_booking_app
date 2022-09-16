import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/cinema_vo.dart';

part 'get_cinema_day_timeslots_response.g.dart';
@JsonSerializable()
class GetCinemaDayTimeSlotsResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? essage;

  @JsonKey(name: "data")
  List<CinemaVO>? data;

  GetCinemaDayTimeSlotsResponse(this.code, this.essage, this.data);

  factory GetCinemaDayTimeSlotsResponse.fromJson(Map<String,dynamic> json) => _$GetCinemaDayTimeSlotsResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetCinemaDayTimeSlotsResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/cinema_and_show_time_slots_vo.dart';
import '../../data/vos/cinema_vo.dart';

part 'get_cinema_and_show_time_by_date_response.g.dart';
@JsonSerializable()
class GetCinemaAndShowTimeByDateResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<CinemaAndShowTimeSlotsVO>? data;

  GetCinemaAndShowTimeByDateResponse(this.code, this.message, this.data);

  factory GetCinemaAndShowTimeByDateResponse.fromJson(Map<String,dynamic> json) => _$GetCinemaAndShowTimeByDateResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetCinemaAndShowTimeByDateResponseToJson(this);
}

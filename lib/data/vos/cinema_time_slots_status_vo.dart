import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';

part 'cinema_time_slots_status_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_TIME_SLOTS_STATUS_VO,adapterName: "CinemaTimeSlotsStatusVOAdapter")
class CinemaTimeSlotsStatusVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "title")
  @HiveField(1)
  String? title;

  @JsonKey(name: "color")
  @HiveField(2)
  String? color;

  CinemaTimeSlotsStatusVO(this.id, this.title, this.color);

  factory CinemaTimeSlotsStatusVO.fromJson(Map<String, dynamic> json) =>
      _$CinemaTimeSlotsStatusVOFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaTimeSlotsStatusVOToJson(this);
}

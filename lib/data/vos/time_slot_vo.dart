import 'package:json_annotation/json_annotation.dart';

part 'time_slot_vo.g.dart';
@JsonSerializable()
class TimeSlotVO{
  @JsonKey(name: "cinema_day_timeslot_id")
  int? cinemaDayTimeslotsId;

  @JsonKey(name: "start_time")
  String? startTime;

  TimeSlotVO(this.cinemaDayTimeslotsId, this.startTime);

  factory TimeSlotVO.fromJson(Map<String,dynamic> json)=>_$TimeSlotVOFromJson(json);

  Map<String,dynamic> toJson()=>_$TimeSlotVOToJson(this);
}

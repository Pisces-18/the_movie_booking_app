import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';

import '../../persistence/hive_constants.dart';

part 'cinema_and_show_time_slots_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_AND_SHOW_TIME_SLOTS_VO,adapterName: "CinemaAndShowTimeSlotsVOAdapter")
class CinemaAndShowTimeSlotsVO{
  @JsonKey(name: "cinema_id")
  @HiveField(0)
  int? cinemaId;

  @JsonKey(name: "cinema")
  @HiveField(1)
  String? cinema;

  @JsonKey(name: "timeslots")
  @HiveField(2)
  List<TimeSlotVO>? timeslots;



  CinemaAndShowTimeSlotsVO(this.cinemaId, this.cinema, this.timeslots);

  factory CinemaAndShowTimeSlotsVO.fromJson(Map<String,dynamic> json) => _$CinemaAndShowTimeSlotsVOFromJson(json);

  Map<String,dynamic> toJson() => _$CinemaAndShowTimeSlotsVOToJson(this);
}


import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';

part 'cinema_and_show_time_slots_vo.g.dart';
@JsonSerializable()
class CinemaAndShowTimeSlotsVO{
  @JsonKey(name: "cinema_id")
  int? cinemaId;

  @JsonKey(name: "cinema")
  String? cinema;

  @JsonKey(name: "timeslots")
  List<TimeSlotVO>? timeslots;

  CinemaAndShowTimeSlotsVO(this.cinemaId, this.cinema, this.timeslots);

  factory CinemaAndShowTimeSlotsVO.fromJson(Map<String,dynamic> json) => _$CinemaAndShowTimeSlotsVOFromJson(json);

  Map<String,dynamic> toJson() => _$CinemaAndShowTimeSlotsVOToJson(this);
}


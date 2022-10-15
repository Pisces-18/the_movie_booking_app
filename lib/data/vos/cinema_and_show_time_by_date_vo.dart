import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../persistence/hive_constants.dart';
import 'cinema_and_show_time_slots_vo.dart';

part 'cinema_and_show_time_by_date_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_AND_SHOW_TIME_BY_DATE_VO,adapterName: "CinemaAndShowTimeByDateVOAdapter")
class CinemaAndShowTimeByDateVO{
  @JsonKey(name: "data")
  @HiveField(2)
  List<CinemaAndShowTimeSlotsVO>? data;

  @HiveField(3)
  String? date;

  CinemaAndShowTimeByDateVO(this.data,this.date);

  factory CinemaAndShowTimeByDateVO.fromJson(Map<String,dynamic> json) => _$CinemaAndShowTimeByDateVOFromJson(json);

  Map<String,dynamic> toJson() => _$CinemaAndShowTimeByDateVOToJson(this);
}

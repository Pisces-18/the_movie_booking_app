import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';

import '../../persistence/hive_constants.dart';

part 'check_out_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CHECK_OUT_VO,adapterName: "CheckOutVOAdapter")
class CheckOutVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "booking_no")
  @HiveField(1)
  String? bookingNo;

  @JsonKey(name: "booking_date")
  @HiveField(2)
  String? bookingDate;

  @JsonKey(name: "row")
  @HiveField(3)
  String? row;

  @JsonKey(name: "seat")
  @HiveField(4)
  String? seat;

  @JsonKey(name: "total_seat")
  @HiveField(5)
  int? totalSeat;

  @JsonKey(name: "total")
  @HiveField(6)
  String? total;

  @JsonKey(name: "movie_id")
  @HiveField(7)
  int? movieId;

  @JsonKey(name: "cinema_id")
  @HiveField(8)
  int? cinemaId;

  @JsonKey(name: "username")
  @HiveField(9)
  String? userName;

  @JsonKey(name: "timeslot")
  @HiveField(10)
  TimeSlotVO? timeSlot;

  @JsonKey(name: "snacks")
  @HiveField(11)
  List<SnackVO>? snacks;

  @JsonKey(name: "qr_code")
  @HiveField(12)
  String? qrCode;

  CheckOutVO(
      this.id,
      this.bookingNo,
      this.bookingDate,
      this.row,
      this.seat,
      this.totalSeat,
      this.total,
      this.movieId,
      this.cinemaId,
      this.userName,
      this.timeSlot,
      this.snacks,
      this.qrCode);

  factory CheckOutVO.fromJson(Map<String,dynamic> json) => _$CheckOutVOFromJson(json);

  Map<String,dynamic> toJson() => _$CheckOutVOToJson(this);

}

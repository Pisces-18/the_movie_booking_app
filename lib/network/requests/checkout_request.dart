import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/checkout_snack_vo.dart';

import '../../data/vos/snack_vo.dart';

part 'checkout_request.g.dart';
@JsonSerializable()
class CheckOutRequest{
  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "cinema_day_timeslot_id")
  int? cinemaDayTimeSlotId;

  // @JsonKey(name: "row")
  // String? row;

  @JsonKey(name: "seat_number")
  String? seatNumber;

  @JsonKey(name: "booking_date")
  String? bookingDate;

  // @JsonKey(name: "total_price")
  // int? totalPrice;

  @JsonKey(name: "movie_id")
  int? movieId;

  // @JsonKey(name: "cinema_id")
  // int? cinemaId;
  @JsonKey(name: "payment_type_id")
  int? paymentTypeId;

  @JsonKey(name: "snacks")
  List<SnackVO>? snacks;


  CheckOutRequest(this.name, this.cinemaDayTimeSlotId, this.seatNumber,
      this.bookingDate, this.movieId, this.paymentTypeId, this.snacks);

  factory CheckOutRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckOutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutRequestToJson(this);

}

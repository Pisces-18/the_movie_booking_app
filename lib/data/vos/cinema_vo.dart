import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';

import '../../persistence/hive_constants.dart';
import 'facility_vo.dart';
import 'facility_vo.dart';

part 'cinema_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_VO,adapterName: "CinemaVOAdapter")
class CinemaVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "phone")
  @HiveField(2)
  String? phone;

  @JsonKey(name: "email")
  @HiveField(3)
  String? email;

  @JsonKey(name: "address")
  @HiveField(4)
  String? address;

  @JsonKey(name: "promo_vdo_url")
  @HiveField(5)
  String? promoVdoUrl;

  @JsonKey(name: "facilities")
  @HiveField(6)
  List<FacilityVO>? facilities;

  @JsonKey(name: "safety")
  @HiveField(7)
  List<String>? safety;


  CinemaVO(this.id, this.name, this.phone, this.email, this.address,
      this.promoVdoUrl, this.facilities, this.safety);

  factory CinemaVO.fromJson(Map<String,dynamic> json) => _$CinemaVOFromJson(json);

  Map<String,dynamic> toJson() => _$CinemaVOToJson(this);
}


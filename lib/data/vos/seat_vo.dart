import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';

part 'seat_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SEAT_VO,adapterName: "SeatVOAdapter")
class SeatVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "type")
  @HiveField(1)
  String? type;

  @JsonKey(name: "seat_name")
  @HiveField(2)
  String? seatName;

  @JsonKey(name: "symbol")
  @HiveField(3)
  String? symbol;

  @JsonKey(name: "price")
  @HiveField(4)
  int? price;


  SeatVO(this.id, this.type, this.seatName, this.symbol, this.price);

  factory SeatVO.fromJson(Map<String,dynamic> json) => _$SeatVOFromJson(json);

  Map<String,dynamic> toJson() => _$SeatVOToJson(this);
}
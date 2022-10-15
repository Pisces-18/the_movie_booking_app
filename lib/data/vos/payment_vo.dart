import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';

part 'payment_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_PAYMENT_VO,adapterName: "PaymentVOAapter")
class PaymentVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "title")
  @HiveField(1)
  String? title;

  @JsonKey(name: "icon")
  @HiveField(2)
  String? icon;

  @JsonKey(name: "created_at")
  @HiveField(3)
  String? createdAt;

  @JsonKey(name: "updated_at")
  @HiveField(4)
  String? updatedAt;

  @JsonKey(name: "deleted_at")
  @HiveField(5)
  String? deletedAt;


  PaymentVO(this.id, this.title, this.icon, this.createdAt, this.updatedAt,
      this.deletedAt);

  factory PaymentVO.fromJson(Map<String,dynamic> json) => _$PaymentVOFromJson(json);

  Map<String,dynamic> toJson() => _$PaymentVOToJson(this);
}

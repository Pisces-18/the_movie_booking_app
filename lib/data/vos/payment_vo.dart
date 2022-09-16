import 'package:json_annotation/json_annotation.dart';

part 'payment_vo.g.dart';
@JsonSerializable()
class PaymentVO{
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "description")
  String? description;


  PaymentVO(this.id, this.name, this.description);

  factory PaymentVO.fromJson(Map<String,dynamic> json) => _$PaymentVOFromJson(json);

  Map<String,dynamic> toJson() => _$PaymentVOToJson(this);
}

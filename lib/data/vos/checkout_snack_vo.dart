import 'package:json_annotation/json_annotation.dart';

part 'checkout_snack_vo.g.dart';
@JsonSerializable()
class CheckOutSnackVO{
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "quantity")
  int? quantity;

  CheckOutSnackVO(this.id, this.quantity);

  factory CheckOutSnackVO.fromJson(Map<String, dynamic> json) =>
      _$CheckOutSnackVOFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutSnackVOToJson(this);
}

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
import 'actor_vo.dart';

part 'credit_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CREDIT_VO,adapterName: "CreditVOAdapter")
class CreditVO{
  @JsonKey(name :"id")
  @HiveField(0)
  int? id;

  @JsonKey(name :"cast")
  @HiveField(1)
  List<ActorVO>? cast;


  CreditVO(this.id, this.cast);

  factory CreditVO.fromJson(Map<String, dynamic> json) =>
      _$CreditVOFromJson(json);

  Map<String, dynamic> toJson() => _$CreditVOToJson(this);

}
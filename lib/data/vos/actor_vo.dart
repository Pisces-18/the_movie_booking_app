import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';


part 'actor_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ACTOR_VO,adapterName: "ActorVOAdapter")
class ActorVO{
  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "gender")
  @HiveField(1)
  int? gender;

  @JsonKey(name: "id")
  @HiveField(2)
  int? id;

  @JsonKey(name: "known_for_department")
  @HiveField(3)
  String? knownForDepartment;

  @JsonKey(name: "name")
  @HiveField(4)
  String? name;

  @JsonKey(name: "original_name")
  @HiveField(5)
  String? originalName;

  @JsonKey(name: "popularity")
  @HiveField(6)
  double? popularity;

  @JsonKey(name: "profile_path")
  @HiveField(7)
  String? profilePath;

  @JsonKey(name: "cast_id")
  @HiveField(8)
  int? castId;

  @JsonKey(name: "character")
  @HiveField(9)
  String? character;

  @JsonKey(name: "credit_id")
  @HiveField(10)
  String? creditId;

  @JsonKey(name: "order")
  @HiveField(11)
  int? order;


  ActorVO(
      this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.originalName,
      this.popularity,
      this.profilePath,
      this.castId,
      this.character,
      this.creditId,
      this.order);

  factory ActorVO.fromJson(Map<String, dynamic> json) =>
      _$ActorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ActorVOToJson(this);

// @override
// String toString() {
//   return 'ActorVO{profilePath: $profilePath, adult: $adult, id: $id,  name: $name, popularity: $popularity}';
// }
}

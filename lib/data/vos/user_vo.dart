import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/user_data_vo.dart';

import '../../persistence/hive_constants.dart';


part 'user_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_USER_VO,adapterName: "UserVOAdapter")
class UserVO{
  @HiveField(0)
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  @HiveField(1)
  String? message;

  @JsonKey(name: "data")
  @HiveField(2)
  UserDataVO data;

  @JsonKey(name : "token")
  @HiveField(3)
  String? token;

  UserVO(this.code, this.message, this.data, this.token);

  factory UserVO.fromJson(Map<String,dynamic> json)=>_$UserVOFromJson(json);

  Map<String,dynamic> toJson()=>_$UserVOToJson(this);
}
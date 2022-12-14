import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/user_data_vo.dart';


part 'user_response.g.dart';
@JsonSerializable()
class UserResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  UserDataVO? data;

  @JsonKey(name : "token")
  String? token;

  UserResponse(this.code, this.message, this.data, this.token);

  factory UserResponse.fromJson(Map<String,dynamic> json)=>_$UserResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$UserResponseToJson(this);
}
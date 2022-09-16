import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';

part 'get_snack_list_response.g.dart';
@JsonSerializable()
class GetSnackListResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? essage;

  @JsonKey(name: "data")
  List<SnackVO>? data;

  GetSnackListResponse(this.code, this.essage, this.data);

  factory GetSnackListResponse.fromJson(Map<String,dynamic> json) => _$GetSnackListResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetSnackListResponseToJson(this);
}
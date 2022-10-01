import 'package:json_annotation/json_annotation.dart';



class DateViewVO{
  // @JsonKey(name: "date")
  String? date="";

  // @JsonKey(name: "is_selected")
  bool? isSelected;

  DateViewVO(this.date, this.isSelected);
  // factory DateViewVO.fromJson(Map<String, dynamic> json) =>
  //     _$DateViewVOFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$DateViewVOToJson(this);
}
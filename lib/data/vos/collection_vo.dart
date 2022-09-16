import 'package:json_annotation/json_annotation.dart';

part 'collection_vo.g.dart';
@JsonSerializable()
class CollectionVO{
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "poster_path")
  String? posterPath;

  @JsonKey(name: "backdrop_path")
  String? backDropPath;

  CollectionVO(this.id, this.name, this.posterPath, this.backDropPath);

  factory CollectionVO.fromJson(Map<String,dynamic> json)=>_$CollectionVOFromJson(json);//Casting data from network with json format to Vos

  Map<String,dynamic> toJson()=>_$CollectionVOToJson(this);//Casting to json format

}
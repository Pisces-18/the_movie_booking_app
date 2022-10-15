import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/production_company_vo.dart';
import 'package:the_movie_booking_app/data/vos/production_country_vo.dart';
import 'package:the_movie_booking_app/data/vos/spoken_language_vo.dart';

import '../../persistence/hive_constants.dart';
import 'collection_vo.dart';
import 'genre_vo.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO,adapterName: "MovieVOAdapter")
class MovieVO{
  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "backdrop_path")
  @HiveField(1)
  String? backDropPath;

  @JsonKey(name: "belongs_to_collection")
  @HiveField(2)
  CollectionVO? belongsToCollection;

  @JsonKey(name: "budget")
  @HiveField(3)
  double? budget;

  @JsonKey(name: "genres")
  @HiveField(4)
  List<GenreVO>? genres;

  @JsonKey(name: "homepage")
  @HiveField(5)
  String? homePage;

  @JsonKey(name: "genre_ids")
  @HiveField(6)
  List<int>? genreIds;

  @JsonKey(name: "id")
  @HiveField(7)
  int? id;

  @JsonKey(name: "imdb_id")
  @HiveField(8)
  String? imdbId;

  @JsonKey(name: "media_type")
  @HiveField(9)
  String? mediaType;

  @JsonKey(name: "original_language")
  @HiveField(10)
  String? originalLanguage;

  @JsonKey(name: "original_title")
  @HiveField(11)
  String? originalTitle;

  @JsonKey(name: "overview")
  @HiveField(12)
  String? overview;

  @JsonKey(name: "popularity")
  @HiveField(13)
  double? popularity;

  @JsonKey(name: "poster_path")
  @HiveField(14)
  String? posterPath;

  @JsonKey(name: "production_companies")
  @HiveField(15)
  List<ProductionCompanyVO>? productionCompanies;

  @JsonKey(name: "production_countries")
  @HiveField(16)
  List<ProductionCountryVO>? productionCountries;

  @JsonKey(name: "release_date")
  @HiveField(17)
  String? releaseDate;

  @JsonKey(name: "revenue")
  @HiveField(18)
  int? revenue;

  @JsonKey(name: "runtime")
  @HiveField(19)
  int? runtime;

  @JsonKey(name: "spoken_languages")
  @HiveField(20)
  List<SpokenLanguageVO>? spokenLanguages;

  @JsonKey(name: "status")
  @HiveField(21)
  String? status;

  @JsonKey(name: "tagline")
  @HiveField(22)
  String? tagline;


  @JsonKey(name: "title")
  @HiveField(23)
  String? title;

  @JsonKey(name: "video")
  @HiveField(24)
  bool? video;

  @JsonKey(name: "vote_average")
  @HiveField(25)
  double? voteAverage;

  @JsonKey(name: "vote_count")
  @HiveField(26)
  int? voteCount;

  @HiveField(27)
  bool? isNowPlaying;

  @HiveField(28)
  bool? isComingSoon;


  MovieVO(
      this.adult,
      this.backDropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homePage,
      this.genreIds,
      this.id,
      this.imdbId,
      this.mediaType,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.isNowPlaying,
      this.isComingSoon);

  factory MovieVO.fromJson(Map<String,dynamic> json)=>_$MovieVOFromJson(json);//Casting data from network with json format to Vos

  Map<String,dynamic> toJson()=>_$MovieVOToJson(this);//Casting to json format

// @override
// String toString() {
//   return 'MovieVO{adult: $adult, backDropPath: $backDropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount}';
// }
}
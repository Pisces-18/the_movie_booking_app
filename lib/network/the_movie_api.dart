import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/network/responses/get_cinema_day_timeslots_response.dart';
import 'package:the_movie_booking_app/network/responses/get_credits_by_movie_response.dart';
import 'package:the_movie_booking_app/network/responses/movie_list_response.dart';

import '../data/vos/movie_vo.dart';

part 'the_movie_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheMovieApi{
  factory TheMovieApi(Dio dio)=_TheMovieApi;

  @GET(ENDPOINT_GET_NOW_PLAYING)
  Future<MovieListResponse> getNowPlayingMovies(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page
      );

  @GET(EMDPOINT_GET_UPCOMING)
  Future<MovieListResponse> getUpcomingMovies(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page
      );

  @GET("$ENDPOINT_GET_MOVIE_DETAILS/{movie_id}")
  Future<MovieVO> getMovieDetails(
      @Path("movie_id") String movieId,
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page
      );

  @GET("$ENDPOINT_GET_CREDITS_BY_MOVIE/{movie_Id}/credits")
  Future<GetCreditsByMovieResponse> getCreditsByMovie(
      @Path("movie_Id") String movieId,
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      );




}
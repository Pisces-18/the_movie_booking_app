import 'package:dio/dio.dart';
import 'package:the_movie_booking_app/data/vos/actor_vo.dart';
import 'package:the_movie_booking_app/data/vos/checkout_snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/network/dataagents/movie_data_agent.dart';
import 'package:the_movie_booking_app/network/responses/checkout_request.dart';
import 'package:the_movie_booking_app/network/the_cinema_api.dart';

import '../../data/vos/credit_vo.dart';
import '../the_movie_api.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  TheMovieApi? mApi;
  TheCinemaApi? cApi;
  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mApi = TheMovieApi(dio);
    cApi = TheCinemaApi(dio);
  }

  @override
  Future<List<MovieVO>>? getNowPlayingMovies(int page) {
    return mApi
        ?.getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results??[])
        .first;
  }

  @override
  Future<List<MovieVO>>? getUpcomingMovies(int page) {
    return mApi
        ?.getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results??[])
        .first;
  }

  @override
  Future<MovieVO>? getMovieDetails(int movieId) {
    return mApi
        ?.getMovieDetails(movieId.toString(), API_KEY, LANGUAGE_EN_US, 1.toString());
  }

  @override
  Future<List<ActorVO>>? getCreditsByMovie(int movieId) {
    return mApi
        ?.getCreditsByMovie(movieId.toString(), API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.cast??[])
        .first;
  }

  @override
  Future<List<CinemaVO>>? getCinemaDayTimeSlots(int movieId, String date) {
    return cApi
        ?.getCinemaDayTimeSlots(AUTHORIZATION, movieId.toString(), date)
        .asStream()
        .map((response) => response.data?? [])
        .first;
  }

  @override
  Future<List<SnackVO>>? getSnackList() {
    return cApi
        ?.getSnackList(AUTHORIZATION)
        .asStream()
        .map((response) => response.data ?? [])
        .first;
  }

  @override
  Future<List<PaymentVO>>? getPaymentMethodList() {
    return cApi
        ?.getPaymentMethodList(AUTHORIZATION)
        .asStream()
        .map((response) => response.data ?? [])
        .first;
  }

  @override
  Future<void> postCheckout(int cinemaDayTimeSlotId, String row, String seatNumber, String bookingDate, int totalPrice, int movieId, int cinemaId, List<CheckOutSnackVO> snacks) async {
    cApi?.postCheckout(CheckOutRequest(cinemaDayTimeSlotId, row, seatNumber, bookingDate, totalPrice, movieId, cinemaId, snacks));
  }


}

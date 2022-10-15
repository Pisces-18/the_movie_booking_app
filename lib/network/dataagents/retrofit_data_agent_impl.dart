import 'package:dio/dio.dart';
import 'package:the_movie_booking_app/data/vos/actor_vo.dart';
import 'package:the_movie_booking_app/data/vos/banner_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_and_show_time_slots_vo.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';
import 'package:the_movie_booking_app/data/vos/config_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_data_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/network/dataagents/movie_data_agent.dart';
import 'package:the_movie_booking_app/network/requests/checkout_request.dart';
import 'package:the_movie_booking_app/network/the_cinema_api.dart';

import '../../data/vos/check_out_vo.dart';
import '../../data/vos/cinema_and_show_time_by_date_vo.dart';
import '../../data/vos/cinema_vo.dart';
import '../../data/vos/credit_vo.dart';
import '../../data/vos/user_vo.dart';
import '../responses/city_response.dart';
import '../responses/get_checkout_response.dart';
import '../responses/user_response.dart';
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
    // final dio = Dio();

    final dio = Dio(
      BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          HEADER_REQUESTED_WITH: XML_HTTP_REQUEST,
        },
      ),
    );
    mApi = TheMovieApi(dio);
    cApi = TheCinemaApi(dio);
  }

  @override
  Future<List<MovieVO>>? getNowPlayingMovies(int page) {
    return mApi
        ?.getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results ?? [])
        .first;
  }

  @override
  Future<List<MovieVO>>? getUpcomingMovies(int page) {
    return mApi
        ?.getUpcomingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results ?? [])
        .first;
  }

  @override
  Future<MovieVO>? getMovieDetails(int movieId) {
    return mApi?.getMovieDetails(
        movieId.toString(), API_KEY, LANGUAGE_EN_US, 1.toString());
  }

  @override
  Future<CreditVO>? getCreditsByMovie(int movieId) {
    return mApi
        ?.getCreditsByMovie(movieId.toString(), API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response)
        .first;
  }

  // @override
  // Future<CityResponse>? getOTP(String phone) async {
  //   return cApi
  //       ?.getOTP(phone)
  //       .asStream()
  //       .map((response) => response)
  //       .first;
  //     }

  @override
  Future<UserVO>? signInWithPhone(String phone, int otp) {
    return cApi
        ?.signInWithPhone(phone, otp.toString())
        .asStream()
        .map((response) => response)
        .first;
  }

  @override
  Future<UserVO>? signInWithGoogle(String accessToken, String name) {
    return cApi
        ?.signInWithGoogle(accessToken, name)
        .asStream()
        .map((response) => response)
        .first;
  }

  @override
  Future<List<CityVO>>? getCities() {
    return cApi
        ?.getCities()
        .asStream()
        .map((response) => response.data ?? [])
        .first;
  }

  @override
  // Future<void> setCity(String token,int cityId)async {
  //   cApi?.setCity(token, cityId.toString());
  // }

  @override
  Future<List<BannerVO>>? getBanners() {
    return cApi
        ?.getBanners()
        .asStream()
        .map((response) => response.data ?? [])
        .first;
  }

  @override
  Future<List<CinemaAndShowTimeSlotsVO>>? getCinemaAndShowTimeByDate(
      String token, String date) {
    return cApi
        ?.getCinemaAndShowTimeByDate(token, date)
        .asStream()
        .map((response) => response.data ?? [])
        .first;
  }

  @override
  Future<List<SnackCategoryVO>>? getSnackCategory(String token) {
    return cApi
        ?.getSnackCategory(token)
        .asStream()
        .map((response) => response.data ?? [])
        .first;
  }

  @override
  Future<List<SnackVO>>? getSnacks(String token, int categoryId) {
    return cApi
        ?.getSnacks(token, categoryId.toString())
        .asStream()
        .map((response) => response.data ?? [])
        .first;
  }

  @override
  Future<List<PaymentVO>>? getPaymentTypes(String token) {
    return cApi
        ?.getPaymentTypes(token)
        .asStream()
        .map((response) => response.data ?? [])
        .first;
  }

  // @override
  // Future<Future<CheckOutVO>?> postCheckout(String token,String name,int cinemaDayTimeSlotId ,String seatNumber,String bookingDate,int movieId,int paymentTypeId,List<SnackVO> snacks) async {
  //   return cApi?.postCheckout(token, CheckOutRequest(name, cinemaDayTimeSlotId, seatNumber, bookingDate, movieId, paymentTypeId, snacks));
  // }

  @override
  Future<List<ConfigVO>>? getConfig() {
    return cApi
        ?.getConfig()
        .asStream()
        .map((response) => response.data ?? [])
        .first;
  }

  @override
  Future<List<CinemaVO>>? getCinemas() {
    return cApi
        ?.getCinemas()
        .asStream()
        .map((response) => response.data ?? [])
        .first;
  }

  @override
  Future<List<List<SeatVO>>>? getSeatingPlanByShowTime(
      String token, int cinemaDayTimeslotId, String bookingDate) {
    return cApi
        ?.getSeatingPlanByShowTime(
            token, cinemaDayTimeslotId.toString(), bookingDate)
        .asStream()
        .map((response) => response.data ?? [[]])
        .first;
  }

  @override
  Future<GetCheckOutResponse>? postCheckout(
      String token,
      String name,
      int cinemaDayTimeSlotId,
      String seatNumber,
      String bookingDate,
      int movieId,
      int paymentTypeId,
      List<SnackVO> snacks) {
    return cApi?.postCheckout(
        token,
        CheckOutRequest(name, cinemaDayTimeSlotId, seatNumber, bookingDate,
            movieId, paymentTypeId, snacks));
  }

  @override
  Future<CityResponse>? setCity(String token, int cityId) {
    return cApi?.setCity(token, cityId.toString());
  }

  @override
  Future<CityResponse>? getOTP(String phone) {
    return cApi?.getOTP(phone);
  }
}

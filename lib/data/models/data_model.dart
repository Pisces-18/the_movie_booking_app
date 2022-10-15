import 'package:the_movie_booking_app/data/vos/actor_vo.dart';

import '../../network/responses/city_response.dart';
import '../../network/responses/get_checkout_response.dart';
import '../../network/responses/user_response.dart';
import '../vos/banner_vo.dart';
import '../vos/cinema_and_show_time_by_date_vo.dart';
import '../vos/cinema_and_show_time_slots_vo.dart';
import '../vos/cinema_time_slots_status_vo.dart';
import '../vos/cinema_vo.dart';
import '../vos/city_vo.dart';
import '../vos/config_vo.dart';
import '../vos/credit_vo.dart';
import '../vos/movie_vo.dart';
import '../vos/payment_vo.dart';
import '../vos/snack_category_vo.dart';
import '../vos/snack_vo.dart';
import '../vos/user_data_vo.dart';
import '../vos/user_vo.dart';

abstract class DataModel{
  ///Network
  Future<List<MovieVO>>? getNowPlayingMovies(int page);
  Future<List<MovieVO>>? getUpcomingMovies(int page);
  Future<MovieVO>? getMovieDetails(int movieId);
  Future<CreditVO>? getCreditsByMovie(int movieId);
  Future<CityResponse>? getOTP(String phone);
  Future<UserVO>? signInWithPhone(String phone,int otp);
  Future<UserVO>? signInWithGoogle(String accessToken,String name);
  Future<List<CityVO>>? getCities();
  Future<CityResponse>? setCity(String token,int cityId);
  Future<List<BannerVO>>? getBanners();
  Future<List<CinemaAndShowTimeSlotsVO>>? getCinemaAndShowTimeByDate(String token,String date);
  void getSnackCategory(String token);
  Future<List<SnackVO>>? getSnacks(String token,int categoryId);
  Future<List<PaymentVO>>? getPaymentTypes(String token);
  Future<GetCheckOutResponse>? postCheckout(String token,String name,int cinemaDayTimeSlotId ,String seatNumber,String bookingDate,int movieId,int paymentTypeId,List<SnackVO> snacks) ;
  void getConfig();
  void getCinemas();
  void getSeatingPlanByShowTime(String token,int cinemaDayTimeslotId, String bookingDate);

  ///Database
  Future<UserDataVO>? signInWithPhoneDatabase();
  Future<UserDataVO>? signInWithGoogleDatabase();
  Future<List<CityVO>>? getCitiesFromDatabase();
  Future<List<MovieVO>>? getNowPlayingMoviesFromDatabase();
  Future<List<MovieVO>>? getUpComingMoviesFromDatabase();
  Future<MovieVO>? getMovieDetailsFromDatabase(int movieId);
  Future<CreditVO>? getCreditsByMovieFromDatabase(int movieId);
  Future<List<BannerVO>>? getBannersFromDatabase();
  Future<List<CinemaVO>>? getCinemasFromDatabase();
  Future<CinemaVO>? getCinemaDetailsFromDatabase(int cinemaId);
  Future<List<CinemaTimeSlotsStatusVO>>? getCinemaTimeSlotsStatusFromDatabase();
  Future<List<SnackCategoryVO>>? getSnackCategoriesFromDatabase();
  Future<List<SnackVO>>? getSnacksFromDatabase(int categoryId);
  Future<List<PaymentVO>>? getPaymentTypesFromDatabase();
  Future<CinemaAndShowTimeByDateVO>? getCinemaAndShowTimeByDateFromDatabase(String date);

}
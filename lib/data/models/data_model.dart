import 'package:the_movie_booking_app/data/vos/actor_vo.dart';

import '../../network/responses/city_response.dart';
import '../../network/responses/get_checkout_response.dart';
import '../../network/responses/user_response.dart';
import '../vos/banner_vo.dart';
import '../vos/check_out_vo.dart';
import '../vos/checkout_snack_vo.dart';
import '../vos/cinema_and_show_time_slots_vo.dart';
import '../vos/cinema_vo.dart';
import '../vos/city_vo.dart';
import '../vos/config_vo.dart';
import '../vos/movie_vo.dart';
import '../vos/payment_vo.dart';
import '../vos/snack_category_vo.dart';
import '../vos/snack_vo.dart';
import '../vos/user_vo.dart';

abstract class DataModel{
  Future<List<MovieVO>>? getNowPlayingMovies(int page);
  Future<List<MovieVO>>? getUpcomingMovies(int page);
  Future<MovieVO>? getMovieDetails(int movieId);
  Future<List<ActorVO>>? getCreditsByMovie(int movieId);
  Future<CityResponse>? getOTP(String phone);
  Future<UserResponse>? signInWithPhone(String phone,int otp);
  Future<UserResponse>? signInWithGoogle(String accessToken,String name);
  Future<List<CityVO>>? getCities();
  Future<CityResponse>? setCity(int cityId);
  Future<List<BannerVO>>? getBanners();
  Future<List<CinemaAndShowTimeSlotsVO>>? getCinemaAndShowTimeByDate(String date);
  void getSnackCategory();
  Future<List<SnackVO>>? getSnacks(int categoryId);
  Future<List<PaymentVO>>? getPaymentTypes();
  Future<GetCheckOutResponse>? postCheckout(String name,int cinemaDayTimeSlotId ,String seatNumber,String bookingDate,int movieId,int paymentTypeId,List<SnackVO> snacks) ;
  void getConfig();
  void getCinemas();
  void getSeatingPlanByShowTime(int cinemaDayTimeslotId, String bookingDate);
}
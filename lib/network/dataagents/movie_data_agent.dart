import 'package:the_movie_booking_app/data/vos/actor_vo.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';
import 'package:the_movie_booking_app/data/vos/config_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_data_vo.dart';
import 'package:the_movie_booking_app/network/responses/get_checkout_response.dart';
import 'package:the_movie_booking_app/network/responses/user_response.dart';

import '../../data/vos/banner_vo.dart';
import '../../data/vos/check_out_vo.dart';
import '../../data/vos/cinema_and_show_time_by_date_vo.dart';
import '../../data/vos/cinema_and_show_time_slots_vo.dart';
import '../../data/vos/cinema_vo.dart';
import '../../data/vos/credit_vo.dart';
import '../../data/vos/movie_vo.dart';
import '../../data/vos/payment_vo.dart';
import '../../data/vos/seat_vo.dart';
import '../../data/vos/snack_category_vo.dart';
import '../../data/vos/user_vo.dart';
import '../responses/city_response.dart';

abstract class MovieDataAgent{
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
  Future<List<SnackCategoryVO>>? getSnackCategory(String token);
  Future<List<SnackVO>>? getSnacks(String token,int categoryId);
  Future<List<PaymentVO>>? getPaymentTypes(String token);
  Future<GetCheckOutResponse>? postCheckout(String token,String name,int cinemaDayTimeSlotId ,String seatNumber,String bookingDate,int movieId,int paymentTypeId,List<SnackVO> snacks);
  Future<List<ConfigVO>>? getConfig();
  Future<List<CinemaVO>>? getCinemas();
  Future<List<List<SeatVO>>>? getSeatingPlanByShowTime(String token,int cinemaDayTimeslotId,String bookingDate);
}
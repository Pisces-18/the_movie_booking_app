import 'package:the_movie_booking_app/data/vos/actor_vo.dart';

import '../vos/checkout_snack_vo.dart';
import '../vos/cinema_vo.dart';
import '../vos/credit_vo.dart';
import '../vos/movie_vo.dart';
import '../vos/payment_vo.dart';
import '../vos/snack_vo.dart';

abstract class DataModel{
  Future<List<MovieVO>>? getNowPlayingMovies(int page);
  Future<List<MovieVO>>? getUpcomingMovies(int page);
  Future<MovieVO>? getMovieDetails(int movieId);
  Future<List<ActorVO>>? getCreditsByMovie(int movieId);
  Future<List<CinemaVO>>? getCinemaDayTimeSlots(int movieId,String date);
  Future<List<SnackVO>>? getSnackList();
  Future<List<PaymentVO>>? getPaymentMethodList();
  Future<void> postCheckout(int cinemaDayTimeSlotId, String row,String seatNumber,String bookingDate,int totalPrice,int movieId,int cinemaId,List<CheckOutSnackVO> snacks);

}
import 'package:the_movie_booking_app/data/vos/actor_vo.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';

import '../../data/vos/checkout_snack_vo.dart';
import '../../data/vos/cinema_vo.dart';
import '../../data/vos/movie_vo.dart';
import '../../data/vos/payment_vo.dart';

abstract class MovieDataAgent{
  Future<List<MovieVO>>? getNowPlayingMovies(int page);
  Future<List<MovieVO>>? getUpcomingMovies(int page);
  Future<MovieVO>? getMovieDetails(int movieId);
  Future<List<ActorVO>>? getCreditsByMovie(int movieId);
  Future<List<CinemaVO>>? getCinemaDayTimeSlots(int movieId,String date);
  Future<List<SnackVO>>? getSnackList();
  Future<List<PaymentVO>>? getPaymentMethodList();
  Future<void> postCheckout(int cinemaDayTimeSlotId, String row,String seatNumber,String bookingDate,int totalPrice,int movieId,int cinemaId,List<CheckOutSnackVO> snacks);
}
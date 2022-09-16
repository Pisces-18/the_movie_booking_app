import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/data/vos/actor_vo.dart';
import 'package:the_movie_booking_app/data/vos/checkout_snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/network/dataagents/movie_data_agent.dart';
import 'package:the_movie_booking_app/network/dataagents/retrofit_data_agent_impl.dart';

class DataModelImpl extends DataModel{
  MovieDataAgent mDataAgent=RetrofitDataAgentImpl();
  static final DataModelImpl _singleton=DataModelImpl._internal();

  factory DataModelImpl(){
    return _singleton;
  }

  DataModelImpl._internal();
  @override
  Future<List<MovieVO>>? getNowPlayingMovies(int page) {
   return mDataAgent.getNowPlayingMovies(page);
  }

  @override
  Future<List<MovieVO>>? getUpcomingMovies(int page) {
    return mDataAgent.getUpcomingMovies(page);
  }

  @override
  Future<MovieVO>? getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetails(movieId);
  }

  @override
  Future<List<ActorVO>>? getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<List<CinemaVO>>? getCinemaDayTimeSlots(int movieId, String date) {
    return mDataAgent.getCinemaDayTimeSlots(movieId, date);
  }

  @override
  Future<List<SnackVO>>? getSnackList() {
    return mDataAgent.getSnackList();
  }

  @override
  Future<List<PaymentVO>>? getPaymentMethodList() {
    return mDataAgent.getPaymentMethodList();
  }

  @override
  Future<void> postCheckout(int cinemaDayTimeSlotId, String row, String seatNumber, String bookingDate, int totalPrice, int movieId, int cinemaId, List<CheckOutSnackVO> snacks) {
    return mDataAgent.postCheckout(cinemaDayTimeSlotId, row, seatNumber, bookingDate, totalPrice, movieId, cinemaId, snacks);
  }

}
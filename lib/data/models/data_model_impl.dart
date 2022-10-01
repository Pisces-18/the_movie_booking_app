import 'package:flutter/cupertino.dart';
import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/data/vos/actor_vo.dart';
import 'package:the_movie_booking_app/data/vos/banner_vo.dart';
import 'package:the_movie_booking_app/data/vos/checkout_snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_and_show_time_slots_vo.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';
import 'package:the_movie_booking_app/data/vos/config_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/value_vo.dart';
import 'package:the_movie_booking_app/network/dataagents/movie_data_agent.dart';
import 'package:the_movie_booking_app/network/dataagents/retrofit_data_agent_impl.dart';

import '../../network/api_constants.dart';
import '../../network/responses/city_response.dart';
import '../../network/responses/get_checkout_response.dart';
import '../../network/responses/user_response.dart';
import '../vos/check_out_vo.dart';
import '../vos/cinema_vo.dart';
import '../vos/seat_vo.dart';
import '../vos/user_vo.dart';

class DataModelImpl extends DataModel{
  MovieDataAgent mDataAgent=RetrofitDataAgentImpl();

  static final DataModelImpl _singleton=DataModelImpl._internal();

  factory DataModelImpl(){
    return _singleton;
  }

  DataModelImpl._internal();

  ///Data Repository
  String? mTokenRepository;
  List<dynamic>? mConfigRepository;
  String? test;
  List<CinemaVO>? mCinemaRepository;
  List<CinemaAndShowTimeSlotsVO>? mCinemaTimeSlotsRepository;
  List<SnackCategoryVO>? mSnackCategoryRepository;
  List<List<SeatVO>>? mSeatingPlanRepository;
  CheckOutVO? mCheckOutRepository;
  String? checkOutMessageRepository;


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
  Future<UserResponse>? signInWithPhone(String phone,int otp){
    return mDataAgent.signInWithPhone(phone, otp)?.then((user) {
      //mTokenRepository="Bearer ${userVO.token}";
      mTokenRepository="Bearer ${user.token}";
      return user;
    }).catchError((error){
  debugPrint("Errors======>$error");
  });
  }

  @override
  Future<UserResponse>? signInWithGoogle(String accessToken,String name){
    return mDataAgent.signInWithGoogle(accessToken, name)?.then((user){
      mTokenRepository="Bearer ${user.token}";
      return user;
    }).catchError((error){
      debugPrint("Errors====>$error");
    });
  }


  @override
  Future<List<CityVO>>? getCities() {
    return mDataAgent.getCities();
  }

  // @override
  // Future<String> setCity(int cityId)async {
  //   mDataAgent.setCity(AUTHORIZATION, cityId);
  // }
  @override
  Future<List<BannerVO>>? getBanners() {
    return mDataAgent.getBanners();
  }

  @override
  Future<List<CinemaAndShowTimeSlotsVO>>? getCinemaAndShowTimeByDate(String date) {
     return mDataAgent.getCinemaAndShowTimeByDate(mTokenRepository?? "",date);
  }

  @override
  Future<List<SnackVO>>? getSnacks(int categoryId) {
    return mDataAgent.getSnacks(mTokenRepository?? "",categoryId);

  }

  @override
  Future<List<PaymentVO>>? getPaymentTypes() {
    return mDataAgent.getPaymentTypes(mTokenRepository?? "");
  }

  // @override
  // Future<Future<CheckOutVO>?> postCheckout(String name,int cinemaDayTimeSlotId ,String seatNumber,String bookingDate,int movieId,int paymentTypeId,List<SnackVO> snacks) {
  //   return mDataAgent.postCheckout(AUTHORIZATION, name, cinemaDayTimeSlotId, seatNumber, bookingDate, movieId, paymentTypeId, snacks);
  // }

  @override
  void getSnackCategory() {
    mDataAgent.getSnackCategory(mTokenRepository?? "")?.then((snackCategories) {
      mSnackCategoryRepository=snackCategories;
      debugPrint("Snack ${mSnackCategoryRepository?[0].title}");
    }).catchError((error){
      debugPrint("Snack Category Error====>$error");
    });
  }


  @override
  void getConfig() {
     mDataAgent.getConfig()?.then((configList) {
      // mConfigRepository=configList;
      // test=configList;
       mConfigRepository=configList[1].value;
       debugPrint("Message  ===>${configList[1].value}");

     });
  }

  @override
  void getCinemas() {
    mDataAgent.getCinemas()?.then((cinemaList) {
      mCinemaRepository=cinemaList;
      //
    }).catchError((error){
      debugPrint(error);
    });
  }

  @override
  void getSeatingPlanByShowTime(int cinemaDayTimeslotId, String bookingDate) {
    mDataAgent.getSeatingPlanByShowTime(mTokenRepository?? "", cinemaDayTimeslotId, bookingDate)?.then((seatList) {
      mSeatingPlanRepository=seatList;
    }).catchError((error){
      debugPrint("Seating Plan Error====>$error");
    });
  }

  @override
  Future<GetCheckOutResponse>? postCheckout(String name, int cinemaDayTimeSlotId, String seatNumber, String bookingDate, int movieId, int paymentTypeId, List<SnackVO> snacks) {
    return mDataAgent.postCheckout(mTokenRepository?? "", name, cinemaDayTimeSlotId, seatNumber, bookingDate, movieId, paymentTypeId, snacks)?.then((checkout) {
       mCheckOutRepository=checkout.data;
       debugPrint("Check Out Data==>${checkout.code}");
       //checkOutMessageRepository=checkout.message;
       return Future.value(checkout);
     }).catchError((error){
       debugPrint("Checkout Response Error===>$error");
     });
  }

  @override
  Future<CityResponse>? setCity(int cityId) {
   return mDataAgent.setCity(mTokenRepository?? "", cityId);
  }

  @override
  Future<CityResponse>? getOTP(String phone) {
    return mDataAgent.getOTP(phone);
  }

}
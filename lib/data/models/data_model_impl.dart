import 'package:flutter/cupertino.dart';
import 'package:the_movie_booking_app/data/models/data_model.dart';
import 'package:the_movie_booking_app/data/vos/actor_vo.dart';
import 'package:the_movie_booking_app/data/vos/banner_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_and_show_time_slots_vo.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';
import 'package:the_movie_booking_app/data/vos/config_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/network/dataagents/movie_data_agent.dart';
import 'package:the_movie_booking_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:the_movie_booking_app/persistence/daos/banner_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/cinema_time_slots_status_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/cinema_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/city_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/config_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/credit_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/payment_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/snack_category_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/snack_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/user_dao.dart';
import '../../network/responses/city_response.dart';
import '../../network/responses/get_checkout_response.dart';
import '../../network/responses/user_response.dart';
import '../../persistence/daos/cinema_and_show_time_by_date_dao.dart';
import '../../persistence/daos/movie_dao.dart';
import '../vos/check_out_vo.dart';
import '../vos/cinema_and_show_time_by_date_vo.dart';
import '../vos/cinema_time_slots_status_vo.dart';
import '../vos/cinema_vo.dart';
import '../vos/credit_vo.dart';
import '../vos/seat_vo.dart';
import '../vos/user_data_vo.dart';
import '../vos/user_vo.dart';

class DataModelImpl extends DataModel {
  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();

  static final DataModelImpl _singleton = DataModelImpl._internal();

  factory DataModelImpl() {
    return _singleton;
  }

  DataModelImpl._internal();

  ///Daos
  MovieDao mMovieDao = MovieDao();
  CreditDao mCreditDao = CreditDao();
  BannerDao cBannerDao = BannerDao();
  CityDao cCityDao = CityDao();
  UserDao cUserDao = UserDao();
  CinemaDao cCinemaDao = CinemaDao();
  CinemaTimeSlotsStatusDao cCinemaConditionDao = CinemaTimeSlotsStatusDao();
  SnackCategoryDao cSnackCategoryDao = SnackCategoryDao();
  PaymentDao cPaymentDao = PaymentDao();
  SnackDao cSnackDao = SnackDao();
  CinemaAndShowTimeByDateDao cCinemaAndShowTimeByDateDao =
      CinemaAndShowTimeByDateDao();

  ///Data Repository
  //String? mTokenRepository;
  // List<SnackCategoryVO>? mSnackCategoryRepository;
  List<List<SeatVO>>? mSeatingPlanRepository;
  //CheckOutVO? mCheckOutRepository;
  // String? checkOutMessageRepository;

  ///Network
  @override
  Future<List<MovieVO>>? getNowPlayingMovies(int page) {
    return mDataAgent.getNowPlayingMovies(page)?.then((movies) async {
      List<MovieVO> nowPlayingMovies = movies.map((movie) {
        movie.isNowPlaying = true;
        movie.isComingSoon = false;
        return movie;
      }).toList();
      mMovieDao.saveAllMovies(nowPlayingMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>>? getUpcomingMovies(int page) {
    return mDataAgent.getUpcomingMovies(page)?.then((movies) async {
      List<MovieVO> upComingMovies = movies.map((movie) {
        movie.isComingSoon = true;
        movie.isNowPlaying = false;
        return movie;
      }).toList();
      mMovieDao.saveAllMovies(upComingMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<MovieVO>? getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetails(movieId)?.then((movie) async {
      mMovieDao.saveSingleMovie(movie);
      return Future.value(movie);
    });
  }

  @override
  Future<CreditVO>? getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovie(movieId)?.then((credit) async {
      mCreditDao.saveCreditByMovieId(credit);
      return Future.value(credit);
    });
  }

  @override
  Future<UserVO>? signInWithPhone(String phone, int otp) {
    return mDataAgent.signInWithPhone(phone, otp)?.then((user) async{
      //mTokenRepository = "Bearer ${user.token}";
      //debugPrint(mTokenRepository);
      UserDataVO userData = user.data;
      userData.token = "Bearer ${user.token}";
      cUserDao.saveUser(userData);
      return Future.value(user);
    }).catchError((error) {
      debugPrint("Errors======>$error");
    });
  }

  @override
  Future<UserVO>? signInWithGoogle(String accessToken, String name) {
    return mDataAgent.signInWithGoogle(accessToken, name)?.then((user) async{
      //mTokenRepository = "Bearer ${user.token}";
      UserDataVO userData = user.data;
      userData.token = "Bearer ${user.token}";
      cUserDao.saveUser(userData);
      return Future.value(user);
    }).catchError((error) {
      debugPrint("Errors====>$error");
    });
  }

  @override
  Future<List<CityVO>>? getCities() {
    return mDataAgent.getCities()?.then((cities) async {
      cCityDao.saveAllCity(cities);
      return Future.value(cities);
    });
  }

  @override
  Future<List<BannerVO>>? getBanners() {
    return mDataAgent.getBanners()?.then((banners) async {
      cBannerDao.saveAllBanners(banners);
      return Future.value(banners);
    });
  }

  @override
  Future<List<CinemaAndShowTimeSlotsVO>>? getCinemaAndShowTimeByDate(
      String token, String date) {
      CinemaAndShowTimeByDateVO cinemaAndTimeSlotsList=CinemaAndShowTimeByDateVO([], "");
    return mDataAgent
        .getCinemaAndShowTimeByDate(token, date)
        ?.then((times) async {
      List<CinemaAndShowTimeSlotsVO> timeSlots=times;
      cinemaAndTimeSlotsList.data=times;
      cinemaAndTimeSlotsList.date = date;
      debugPrint("TimeS===>${cinemaAndTimeSlotsList.data}");
      //cinemaAndTimeSlotsList
      cCinemaAndShowTimeByDateDao
          .saveCinemaAndShowTimeSlotsByDate(cinemaAndTimeSlotsList);
      return Future.value(times);
    }).catchError((error) {
      debugPrint("Times error==>$error");
    });
  }

  @override
  Future<List<SnackVO>>? getSnacks(String token, int categoryId) {
    return mDataAgent.getSnacks(token, categoryId)?.then((snackList) async {
      cSnackDao.saveAllSnack(snackList);
      return Future.value(snackList);
    });
  }

  @override
  Future<List<PaymentVO>>? getPaymentTypes(String token) {
    return mDataAgent.getPaymentTypes(token)?.then((paymentList) async {
      cPaymentDao.saveAllPayment(paymentList);
      return Future.value(paymentList);
    });
  }

  @override
  void getSnackCategory(String token) {
    mDataAgent.getSnackCategory(token)?.then((snackCategories) async{
      //mSnackCategoryRepository = snackCategories;
      cSnackCategoryDao.saveAllSnackCategories(snackCategories);
      return Future.value(snackCategories);
      //debugPrint("Snack ${mSnackCategoryRepository?[0].title}");
    }).catchError((error) {
      debugPrint("Snack Category Error====>$error");
    });
  }

  @override
  void getConfig() {
    mDataAgent.getConfig()?.then((configList) async {
      // mConfigRepository=configList;
      // test=configList;
      // mConfigList = configList;
      List timeSlotsStatusList = configList[1].value;
      List<CinemaTimeSlotsStatusVO> timeSlotStatus = (timeSlotsStatusList)
          .map((v) => CinemaTimeSlotsStatusVO.fromJson(v))
          .toList();
      cCinemaConditionDao.saveAllCinemaTimeSlotsStatus(timeSlotStatus);
    });
  }

  @override
  void getCinemas() {
    mDataAgent.getCinemas()?.then((cinemaList) async{
      cCinemaDao.saveAllCinemas(cinemaList);
      return Future.value(cinemaList);
    }).catchError((error) {
      debugPrint("$error");
    });
  }

  @override
  void getSeatingPlanByShowTime(
      String token, int cinemaDayTimeslotId, String bookingDate) {
    mDataAgent
        .getSeatingPlanByShowTime(token, cinemaDayTimeslotId, bookingDate)
        ?.then((seatList) {
      mSeatingPlanRepository = seatList;
    }).catchError((error) {
      debugPrint("Seating Plan Error====>$error");
    });
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
    return mDataAgent
        .postCheckout(token, name, cinemaDayTimeSlotId, seatNumber, bookingDate,
            movieId, paymentTypeId, snacks)
        ?.then((checkout) {
      //mCheckOutRepository = checkout.data;
      //debugPrint("Check Out Data==>${checkout.code}");
      //checkOutMessageRepository=checkout.message;
      return Future.value(checkout);
    }).catchError((error) {
      debugPrint("Checkout Response Error===>$error");
    });
  }

  @override
  Future<CityResponse>? setCity(String token, int cityId) {

      UserDataVO? user;
      user?.cityOfUser=cCityDao.getSingleCity(cityId);
      String c=user?.cityOfUser?.name?? "";
      debugPrint("City Database===>$c");
      cUserDao.saveUser(user!);
     // return Future.value(city);

     return mDataAgent.setCity(token, cityId);
  }

  @override
  Future<CityResponse>? getOTP(String phone) {
    return mDataAgent.getOTP(phone);
  }

  ///Database

  @override
  Future<UserDataVO>? signInWithPhoneDatabase() async {
    return Future.value(cUserDao.getUser()?.first);
  }

  @override
  Future<UserDataVO>? signInWithGoogleDatabase() async{
    return Future.value(cUserDao.getUser()?.first);
  }

  @override
  Future<List<CityVO>>? getCitiesFromDatabase() {
    return Future.value(cCityDao.getAllCity());
  }

  @override
  Future<List<MovieVO>>? getNowPlayingMoviesFromDatabase() async {
    return Future.value(mMovieDao
        .getAllMovies()
        .where((movie) => movie.isNowPlaying ?? true)
        .toList());
  }

  @override
  Future<List<MovieVO>>? getUpComingMoviesFromDatabase() async {
    return Future.value(mMovieDao
        .getAllMovies()
        .where((movie) => movie.isComingSoon ?? true)
        .toList());
  }

  @override
  Future<MovieVO>? getMovieDetailsFromDatabase(int movieId) async {
    return Future.value(mMovieDao.getMovieById(movieId));
  }

  @override
  Future<CreditVO>? getCreditsByMovieFromDatabase(int movieId) async {
    return Future.value(mCreditDao.getAllActorsByMovieId(movieId));
  }

  @override
  Future<List<BannerVO>>? getBannersFromDatabase() async {
    return Future.value(cBannerDao.getAllBanners());
  }

  @override
  Future<List<CinemaVO>>? getCinemasFromDatabase() async {
    return Future.value(cCinemaDao.getAllCinema());
  }

  @override
  Future<CinemaVO>? getCinemaDetailsFromDatabase(int cinemaId)async{
    return Future.value(cCinemaDao.getSingleCinema(cinemaId));
  }

  @override
  Future<List<CinemaTimeSlotsStatusVO>>?
      getCinemaTimeSlotsStatusFromDatabase() {
    return Future.value(cCinemaConditionDao.getAllCinemaTimeSlotsStatus());
  }

  @override
  Future<List<SnackCategoryVO>>? getSnackCategoriesFromDatabase() {
    return Future.value(cSnackCategoryDao.getAllSnackCategories());
  }

  @override
  Future<List<PaymentVO>>? getPaymentTypesFromDatabase() {
    return Future.value(cPaymentDao.getAllPayment());
  }

  @override
  Future<List<SnackVO>>? getSnacksFromDatabase(int categoryId) {
    if (categoryId == 0) {
      return Future.value(cSnackDao.getAllSnacks());
    } else {
      return Future.value(cSnackDao
          .getAllSnacks()
          .where((snack) => snack.categoryId == categoryId)
          .toList());
    }
  }

  @override
  Future<CinemaAndShowTimeByDateVO>?
      getCinemaAndShowTimeByDateFromDatabase(String date) async {
    return Future.value(cCinemaAndShowTimeByDateDao.getCinemaAndShowTimeSlotsByDate(date));
  }
}

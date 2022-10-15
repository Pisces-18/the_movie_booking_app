import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:the_movie_booking_app/data/models/data_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/check_out_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_and_show_time_by_date_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_and_show_time_slots_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';
import 'package:the_movie_booking_app/data/vos/date_vo.dart';
import 'package:the_movie_booking_app/data/vos/facility_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/time_slot_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_data_vo.dart';
import 'package:the_movie_booking_app/pages/splash_screen_page.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

import 'data/models/data_model.dart';
import 'data/vos/actor_vo.dart';
import 'data/vos/banner_vo.dart';
import 'data/vos/cinema_time_slots_status_vo.dart';
import 'data/vos/collection_vo.dart';
import 'data/vos/config_vo.dart';
import 'data/vos/credit_vo.dart';
import 'data/vos/genre_vo.dart';
import 'data/vos/movie_vo.dart';
import 'data/vos/production_company_vo.dart';
import 'data/vos/production_country_vo.dart';
import 'data/vos/spoken_language_vo.dart';
import 'data/vos/user_vo.dart';




void main() async{
  await Hive.initFlutter();

  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());
  Hive.registerAdapter(CreditVOAdapter());
  Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(BannerVOAdapter());
  Hive.registerAdapter(UserDataVOAdapter());
  Hive.registerAdapter(CityVOAdapter());
  Hive.registerAdapter(ConfigVOAdapter());
  Hive.registerAdapter(CinemaTimeSlotsStatusVOAdapter());
  Hive.registerAdapter(CinemaVOAdapter());
  Hive.registerAdapter(FacilityVOAdapter());
  Hive.registerAdapter(CinemaAndShowTimeSlotsVOAdapter());
  Hive.registerAdapter(CinemaAndShowTimeByDateVOAdapter());
  Hive.registerAdapter(TimeSlotVOAdapter());
  Hive.registerAdapter(SeatVOAdapter());
  Hive.registerAdapter(SnackCategoryVOAdapter());
  Hive.registerAdapter(SnackVOAdapter());
  Hive.registerAdapter(PaymentVOAapter());
  Hive.registerAdapter(CheckOutVOAdapter());


  await Hive.openBox<UserDataVO>(BOX_NAME_USER_DATA_VO);
  await Hive.openBox<CityVO>(BOX_NAME_CITY_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<CreditVO>(BOX_NAME_CREDIT_VO);
  await Hive.openBox<BannerVO>(BOX_NAME_BANNER_VO);
  await Hive.openBox<CinemaVO>(BOX_NAME_CINEMA_VO);
  await Hive.openBox<CinemaTimeSlotsStatusVO>(BOX_NAME_CINEMA_TIME_SLOTS_STATUS_VO);
  await Hive.openBox<SnackCategoryVO>(BOX_NAME_SNACK_CATEGORY_VO);
  await Hive.openBox<SnackVO>(BOX_NAME_SNACK_VO);
  await Hive.openBox<PaymentVO>(BOX_NAME_PAYMENT_VO);
  await Hive.openBox<CinemaAndShowTimeByDateVO>(BOX_NAME_CINEMA_AND_SHOW_TIME_BY_DATE_VO);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  DataModel dDataModel=DataModelImpl();
  @override
  void initState(){
    super.initState();
    setState((){
      dDataModel.getConfig();
      dDataModel.getCinemas();
    });
  }
  Widget build(BuildContext context) {

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Movie Booking App',
      home: SplashScreenPage()
    );
  }
}


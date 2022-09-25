import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/data_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/network/dataagents/movie_data_agent.dart';
import 'package:the_movie_booking_app/pages/choose_time_and_cinema_page.dart';
import 'package:the_movie_booking_app/pages/cinema_page.dart';
import 'package:the_movie_booking_app/pages/date_test_page.dart';
import 'package:the_movie_booking_app/pages/food_and_beverage_all_page.dart';
import 'package:the_movie_booking_app/pages/payment_page.dart';
import 'package:the_movie_booking_app/pages/splash_screen_page.dart';
import 'package:the_movie_booking_app/pages/ticket_confirmation_page.dart';
import 'package:the_movie_booking_app/pages/ticket_page.dart';

import 'data/models/data_model.dart';
import 'network/dataagents/retrofit_data_agent_impl.dart';



void main() {


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
      title: 'Flutter Demo',
      home: SplashScreenPage()
    );
  }
}


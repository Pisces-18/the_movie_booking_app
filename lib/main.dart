import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/data_model_impl.dart';
import 'package:the_movie_booking_app/pages/splash_screen_page.dart';

import 'data/models/data_model.dart';




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


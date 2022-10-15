import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../data/vos/cinema_vo.dart';
import '../hive_constants.dart';

class CinemaDao{
  static final CinemaDao _singleton=CinemaDao._internal();

  factory CinemaDao(){
    return _singleton;
  }

  CinemaDao._internal();

  void saveAllCinemas(List<CinemaVO> cinemaList)async{
    Map<int,CinemaVO> cinemaMap=Map.fromIterable(cinemaList, key: (cinema) => cinema.id,value: (cinema)=>cinema);
    await getCinemaBox().putAll(cinemaMap);
  }

  List<CinemaVO> getAllCinema(){
   List<CinemaVO> cinemaList= getCinemaBox().values.toList();
   cinemaList.forEach((element) {
     debugPrint("Cinema From Database===>${element.name}");

   });
    return cinemaList;
  }

  CinemaVO? getSingleCinema(int cinemaId){
    return getCinemaBox().get(cinemaId);
  }

  Box<CinemaVO> getCinemaBox(){
    return Hive.box<CinemaVO>(BOX_NAME_CINEMA_VO);
  }
}
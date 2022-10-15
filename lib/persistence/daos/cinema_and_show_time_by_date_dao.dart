import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../data/vos/cinema_and_show_time_by_date_vo.dart';
import '../../data/vos/cinema_and_show_time_slots_vo.dart';
import '../hive_constants.dart';

class CinemaAndShowTimeByDateDao {
  static final CinemaAndShowTimeByDateDao _singleton =
      CinemaAndShowTimeByDateDao._internal();

  factory CinemaAndShowTimeByDateDao() {
    return _singleton;
  }

  CinemaAndShowTimeByDateDao._internal();

  void saveAllCinemaAndShowTimeSlots(
      List<CinemaAndShowTimeByDateVO> cinemaAndShowTimeSlotsByDateList) async {
    Map<String, CinemaAndShowTimeByDateVO> cinemaAndShowTimeSlotsMap =
        Map.fromIterable(cinemaAndShowTimeSlotsByDateList,
            key: (cinemaAndShowTimeSlots) => cinemaAndShowTimeSlots.date,
            value: (cinemaAndShowTimeSlots) => cinemaAndShowTimeSlots);
    await getCinemaAndShowTimeSlotsBox().putAll(cinemaAndShowTimeSlotsMap);
  }

  void saveCinemaAndShowTimeSlotsByDate(CinemaAndShowTimeByDateVO timeSlotsByDate)async{
    return getCinemaAndShowTimeSlotsBox().put(timeSlotsByDate.date, timeSlotsByDate);
  }

  List<CinemaAndShowTimeByDateVO> getAllCinemaAndShowTimeSlots(){
    List<CinemaAndShowTimeByDateVO> cl=getCinemaAndShowTimeSlotsBox().values.toList();
    cl.forEach((element) {
      debugPrint("Slots Database==>${element.date}");
    });
    return cl;
  }

  CinemaAndShowTimeByDateVO? getCinemaAndShowTimeSlotsByDate(String date){
    return getCinemaAndShowTimeSlotsBox().get(date);
  }

  Box<CinemaAndShowTimeByDateVO> getCinemaAndShowTimeSlotsBox() {
    return Hive.box<CinemaAndShowTimeByDateVO>(BOX_NAME_CINEMA_AND_SHOW_TIME_BY_DATE_VO);
  }
}

import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/cinema_time_slots_status_vo.dart';

import '../hive_constants.dart';

class CinemaTimeSlotsStatusDao{
  static final CinemaTimeSlotsStatusDao _singleton=CinemaTimeSlotsStatusDao._internal();

  factory CinemaTimeSlotsStatusDao(){
    return _singleton;
  }
  CinemaTimeSlotsStatusDao._internal();

  void saveAllCinemaTimeSlotsStatus(List<CinemaTimeSlotsStatusVO> timeSlotsStatusList)async{
    Map<int,CinemaTimeSlotsStatusVO> cinemaConditionMap=Map.fromIterable(timeSlotsStatusList, key: (cinemaCondtion) => cinemaCondtion.id, value: (cinemaCondition) => cinemaCondition);
    await getCinemaTimeSlotsStatusBox().putAll(cinemaConditionMap);
  }

  List<CinemaTimeSlotsStatusVO> getAllCinemaTimeSlotsStatus(){
    return getCinemaTimeSlotsStatusBox().values.toList();
  }

  Box<CinemaTimeSlotsStatusVO> getCinemaTimeSlotsStatusBox(){
    return Hive.box<CinemaTimeSlotsStatusVO>(BOX_NAME_CINEMA_TIME_SLOTS_STATUS_VO);
  }
}
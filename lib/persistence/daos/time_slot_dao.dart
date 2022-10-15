import 'package:hive/hive.dart';

import '../../data/vos/time_slot_vo.dart';
import '../hive_constants.dart';

class TimeSlotDao{
  static final TimeSlotDao _singleton=TimeSlotDao._internal();

  factory TimeSlotDao(){
    return _singleton;
  }

  TimeSlotDao._internal();

  void saveAllTimeSlots(List<TimeSlotVO> timeSlotList) async{
    Map<int,TimeSlotVO> timeSlotMap=Map.fromIterable(timeSlotList, key: (timeSlot) => timeSlot.id, value: (timeSlot) =>timeSlot);
    await getTimeSlotBox().putAll(timeSlotMap);
  }

  List<TimeSlotVO> getAllTimeSlots(){
    return getTimeSlotBox().values.toList();
  }

  TimeSlotVO? getSingleTimeSlot(int cinemaDayTimeSlotId){
    return getTimeSlotBox().get(cinemaDayTimeSlotId);
  }

  Box<TimeSlotVO> getTimeSlotBox(){
    return Hive.box<TimeSlotVO>(BOX_NAME_TIME_SLOT_VO);
  }
}
import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/seat_vo.dart';

import '../hive_constants.dart';

class SeatDao{
  static final SeatDao _singleton=SeatDao._internal();

  factory SeatDao(){
    return _singleton;
  }

  SeatDao._internal();

  void saveAllSeats(List<SeatVO> seatList)async{
    Map<int,SeatVO> seatMap=Map.fromIterable(seatList, key: (seat) => seat.id, value: (seat) => seat);
    await getSeatBox().putAll(seatMap);
  }

  void saveSingleSeat(SeatVO seat)async{
    return getSeatBox().put(seat.id, seat);
  }

  List<SeatVO> getAllSeat(){
    return getSeatBox().values.toList();
  }

  SeatVO? getSingleSeat(int seatId){
    return getSeatBox().get(seatId);
  }

  Box<SeatVO> getSeatBox(){
    return Hive.box<SeatVO>(BOX_NAME_SEAT_VO);
  }
}
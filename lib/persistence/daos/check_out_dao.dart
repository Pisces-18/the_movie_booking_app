import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/check_out_vo.dart';

import '../hive_constants.dart';

class CheckOutDao{
  static final CheckOutDao _singleton=CheckOutDao._internal();

  factory CheckOutDao(){
    return _singleton;
  }

  CheckOutDao._internal();

  void saveCheckOutData(CheckOutVO checkOut)async{
    return getCheckOutBox().put(checkOut.id, checkOut);
  }

  CheckOutVO? getCheckOutData(int checkOutId){
    return getCheckOutBox().get(checkOutId);
  }

  Box<CheckOutVO> getCheckOutBox(){
    return Hive.box<CheckOutVO>(BOX_NAME_CHECK_OUT_VO);
  }
}
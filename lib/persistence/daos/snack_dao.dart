import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';

import '../hive_constants.dart';

class SnackDao{
  static final SnackDao _singleton=SnackDao._internal();

  factory SnackDao(){
    return _singleton;
  }

  SnackDao._internal();

  void saveAllSnack(List<SnackVO> snackList)async{
    Map<int,SnackVO> snackMap=Map.fromIterable(snackList, key: (snack) => snack.id, value: (snack) => snack);
    await getSnackBox().putAll(snackMap);
  }

  void saveSingleSnack(SnackVO snack)async{
    return getSnackBox().put(snack.id, snack);
  }

  List<SnackVO> getAllSnacks(){
    return getSnackBox().values.toList();
  }

  SnackVO? getSingleSnack(int snackId){
    return getSnackBox().get(snackId);
  }

  Box<SnackVO> getSnackBox(){
    return Hive.box<SnackVO>(BOX_NAME_SNACK_VO);
  }
}
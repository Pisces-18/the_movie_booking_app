import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/credit_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';

import '../../data/vos/actor_vo.dart';
import '../hive_constants.dart';

class CreditDao {
  static final CreditDao _singleton = CreditDao._internal();

  factory CreditDao() {
    return _singleton;
  }

  CreditDao._internal();

  void saveCreditByMovieId(CreditVO credit) async {
    await getCreditBox().put(credit.id,credit);
  }

  CreditVO? getAllActorsByMovieId(int movieId) {
    // return getActorBox().values.toList();
    CreditVO? creditFromDatabase=getCreditBox().get(movieId);
    (creditFromDatabase?.cast)?.forEach((element) => debugPrint("Actor Name ==> ${element.name}"));
    return creditFromDatabase;
  }

  Box<CreditVO> getCreditBox() {
    return Hive.box<CreditVO>(BOX_NAME_CREDIT_VO);
  }
}

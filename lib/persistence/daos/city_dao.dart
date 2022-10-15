import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/city_vo.dart';

import '../hive_constants.dart';

class CityDao {
  static final CityDao _singleton = CityDao._internal();

  factory CityDao() {
    return _singleton;
  }

  CityDao._internal();

  void saveAllCity(List<CityVO> cityList) async {
    Map<int, CityVO> cityMap = Map.fromIterable(cityList,
        key: (city) => city.id, value: (city) => city);
    await getCityBox().putAll(cityMap);
  }

  void saveSingleCity(CityVO city) async{
    return getCityBox().put(city.id, city);
  }

  List<CityVO> getAllCity(){
    // return getCityBox().values.toList();
    List<CityVO> cities=getCityBox().values.toList();
    cities.forEach((element) { debugPrint("cities from database==> ${element.name}");});
    return cities;
  }

  CityVO? getSingleCity(int cityId){
    return getCityBox().get(cityId);
  }

  Box<CityVO> getCityBox() {
    return Hive.box<CityVO>(BOX_NAME_CITY_VO);
  }
}

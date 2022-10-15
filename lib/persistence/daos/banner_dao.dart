import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/persistence/hive_constants.dart';

import '../../data/vos/banner_vo.dart';

class BannerDao{
  static final BannerDao _singleton=BannerDao._internal();

  factory BannerDao(){
    return _singleton;
  }

  BannerDao._internal();

  void saveAllBanners(List<BannerVO> bannerList) async{
    Map<int,BannerVO> bannerMap=Map.fromIterable(bannerList, key: (banner) => banner.id, value: (banner) => banner);
    await getBannerBox().putAll(bannerMap);
  }

  List<BannerVO> getAllBanners(){
    return getBannerBox().values.toList();
  }

  Box<BannerVO> getBannerBox(){
    return Hive.box<BannerVO>(BOX_NAME_BANNER_VO);
  }
}
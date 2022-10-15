import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/snack_category_vo.dart';

import '../hive_constants.dart';

class SnackCategoryDao {
  static final SnackCategoryDao _singleton = SnackCategoryDao._internal();

  factory SnackCategoryDao() {
    return _singleton;
  }

  SnackCategoryDao._internal();

  void saveAllSnackCategories(List<SnackCategoryVO> snackCategoryList) async {
    Map<int, SnackCategoryVO> snackCategoryMap = Map.fromIterable(
        snackCategoryList,
        key: (snackCategory) => snackCategory.id,
        value: (snackCategory) => snackCategory);
    await getSnackCategoryBox().putAll(snackCategoryMap);
  }

  List<SnackCategoryVO> getAllSnackCategories() {
    return getSnackCategoryBox().values.toList();
  }

  Box<SnackCategoryVO> getSnackCategoryBox() {
    return Hive.box<SnackCategoryVO>(BOX_NAME_SNACK_CATEGORY_VO);
  }
}

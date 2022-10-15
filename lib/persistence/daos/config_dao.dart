// import 'package:hive/hive.dart';
//
// import '../../data/vos/config_vo.dart';
// import '../hive_constants.dart';
//
// class ConfigDao {
//   static final ConfigDao _singleton = ConfigDao._internal();
//
//   factory ConfigDao() {
//     return _singleton;
//   }
//
//   ConfigDao._internal();
//   void saveAllConfigs(List<ConfigVO> configList) async {
//     Map<int, ConfigVO> configMap = Map.fromIterable(configList,
//         key: (config) => config.id, value: (config) => config);
//     await getConfigBox().putAll(configMap);
//   }
//
//   List<ConfigVO> getAllConfigs(){
//     return getConfigBox().values.toList();
//   }
//
//   // ConfigVO? getSingleConfig(int configId){
//   //   return getConfigBox().get(configId);
//   // }
//
//   Box<ConfigVO> getConfigBox() {
//     return Hive.box<ConfigVO>(BOX_NAME_CONFIG_VO);
//   }
// }

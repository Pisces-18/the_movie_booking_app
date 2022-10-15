import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../data/vos/user_data_vo.dart';
import '../hive_constants.dart';

class UserDao{
  static final UserDao _singleton=UserDao._internal();

  factory UserDao(){
    return _singleton;
  }
  UserDao._internal();
  void saveUsers(List<UserDataVO> users)async{
    Map<int,UserDataVO> usersMap=Map.fromIterable(users, key: (user)=>user.id, value: (user)=>user);
    await getUserBox().putAll(usersMap);
  }

  void saveUser(UserDataVO user)async{
    return getUserBox().put(user.id, user);
  }

  List<UserDataVO>? getUser(){
    return getUserBox().values.toList();
  }

  Box<UserDataVO> getUserBox(){
    return Hive.box<UserDataVO>(BOX_NAME_USER_DATA_VO);
  }
}
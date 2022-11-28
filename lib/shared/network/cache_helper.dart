import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences sharedPreferences;

  static Future init()
  async{
    sharedPreferences =await SharedPreferences.getInstance();
  }

  static Future<bool> putString({@required String key,@required String value})
  async{
   return await sharedPreferences.setString(key, value);
  }

  static String getString({@required String key})
  {
    return sharedPreferences.getString(key);
  }



  // save data
  static Future<bool> saveData({
    @required String key,
    @required dynamic value
  })async{
    if(value is String) return await sharedPreferences.setString(key, value);
    if(value is int) return await sharedPreferences.setInt(key, value);
    if(value is bool) return await sharedPreferences.setBool(key, value);

    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData({@required key})
  async{
    return await sharedPreferences.remove(key);
  }

}
import 'package:shared_preferences/shared_preferences.dart';

abstract class PrefCacheClient<T> {
  String get prefKey;

  Future<bool> isExistTable();

  //Basic Query Functions: Create - Read - Update - Delete - Get all

  //The insert function will override old data if the record is existed
  Future<bool> storeData({T? data});

  Future<T?> getData({dynamic data});

  Future<bool> updateRecord(T? data);

  Future<bool> deleteRecord({dynamic data});

  Future<bool> destroyData() async {
    return (await SharedPreferences.getInstance()).remove(prefKey);
  }
}

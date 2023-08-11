// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vending_machine/central_logic/database/pref_cached_client.dart';
import 'package:vending_machine/central_logic/database/pref_key.dart';
import 'package:vending_machine/central_logic/database/vending_machine_data_model.dart';

class VendingMachineDataCachedClient
    extends PrefCacheClient<VendingMachineDataModel> {
  VendingMachineDataCachedClient._privateConstructor();

  static final VendingMachineDataCachedClient instance =
      VendingMachineDataCachedClient._privateConstructor();
  @override
  String get prefKey => PrefsKeys.vendingMechineKey.value;

  @override
  Future<bool> isExistTable() async {
    return (await getData()) != null;
  }

  @override
  Future<bool> storeData({data}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final encodedData = jsonEncode(data);
      return pref.setString(prefKey, encodedData);
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteRecord({dynamic data}) async {
    return true;
  }

  @override
  Future<VendingMachineDataModel?> getData({data}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final prefData = pref.getString(prefKey) ?? '';
      if (prefData != '') {
        final data = jsonDecode(prefData) as Map<String, dynamic>;
        return VendingMachineDataModel.fromJson(data);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> updateRecord(VendingMachineDataModel? data) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final encodedData = jsonEncode(data);
      return pref.setString(prefKey, encodedData);
    } catch (_) {
      return false;
    }
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_bmi_project/models/store_details.dart';

Future<bool> storeBool(bool data) async {
  SharedPreferences objName = await SharedPreferences.getInstance();
  return await objName.setBool("bool", data);
}

Future<bool> retrieveBool() async {
  SharedPreferences objName = await SharedPreferences.getInstance();
  return objName.getBool("bool") ?? false;
}

Future<bool> storeUsername(String username) async {
  SharedPreferences objName = await SharedPreferences.getInstance();
  return await objName.setString('username', username);
}

Future<bool> storePassword(String password) async {
  SharedPreferences objName = await SharedPreferences.getInstance();
  return await objName.setString('password', password);
}

Future<String?> retrieveUsername() async {
  SharedPreferences objName = await SharedPreferences.getInstance();
  return objName.getString('username');
}

Future<String?> retrievePassword() async {
  SharedPreferences objName = await SharedPreferences.getInstance();
  return objName.getString('password');
}

Future<void> storeDetails(List<StoreDetails> storeList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> storeDetailsJson = storeList.map((storeDetail) => jsonEncode(storeDetail.toJson())).toList();
  prefs.setStringList('storeDetailsList', storeDetailsJson);
}

Future<List<StoreDetails>> retrieveStoreDetailsList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? storeDetailsJson = prefs.getStringList('storeDetailsList');
  if (storeDetailsJson == null) return [];
  return storeDetailsJson.map((storeJson) => StoreDetails.fromJson(jsonDecode(storeJson))).toList();
}

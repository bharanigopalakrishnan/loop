import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Count extends ChangeNotifier {
  int? data;

  Count({this.data});

  void updateData() {
    data = data! + 1;
    notifyListeners();
    saveCountToLocalStorage();
  }

  Future<void> saveCountToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('count', data!);
  }

  Future<void> loadCountFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data = prefs.getInt('count') ?? 0;
    notifyListeners();
  }
}

import 'package:sbox/models/local_db/hive_names.dart';

import '/models/local_db/secstor.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DatabaseProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  Box<C_hive> _boxA = Hive.box<C_hive>(HiveBoxes.db_hive);

  C_hive _selectedboxA = C_hive();

  Box<C_hive> get boxA => _boxA;

  C_hive get selectedboxA => _selectedboxA;

  ///* Updating the current selected index for that contact to pass to read from hive
  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    updateSelectedContact();
    notifyListeners();
  }

  ///* Updating the current selected item from hive
  void updateSelectedContact() {
    _selectedboxA = readFromHive()!;
    notifyListeners();
  }

  ///* reading the current selected item from hive
  C_hive? readFromHive() {
    C_hive? getItem = _boxA.getAt(_selectedIndex);

    return getItem;
  }

  void deleteFromHive() {
    _boxA.deleteAt(_selectedIndex);
    debugPrint(' _boxA.deleteAt   $_selectedIndex ');
  }
}

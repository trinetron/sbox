import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/models/local_db/secstor.dart';

class EditSiteProvider extends ChangeNotifier {
  int id = 0;
  String dataSite = '';
  String dataLogin = '';
  String dataPass = '';
  String dataNote = '';

  int hintOnSite = 0;
  int hintOnLogin = 0;
  int hintOnPass = 0;
  int hintOnNote = 0;

  bool hintSiteOn = false;
  bool hintLoginOn = false;
  bool hintPassOn = false;
  bool hintNoteOn = false;

  String hintSite = '';
  String hintLogin = '';
  String hintPass = '';
  String hintNote = '';

  void changeDataText(var newDataText, int objNum) {
    switch (objNum) {
      case 1:
        dataSite = newDataText;
        break;
      case 2:
        dataLogin = newDataText;
        break;
      case 3:
        dataPass = newDataText;
        break;
      case 4:
        dataNote = newDataText;
        break;
    }

    notifyListeners();
  }

  void changeDataId(var newId) {
    id = newId;
  }

  void changeHintOn(var newHintOn) {
    debugPrint('newHintOn  $newHintOn');

    if (newHintOn == 1) {
      if (hintSiteOn == false) {
        hintSite = LocaleKeys.add_site.tr();
        hintSiteOn = true;
        hintOnSite = 1;
        debugPrint('hintSiteOn  $hintSiteOn');
      } else {
        hintSite = '';
        hintSiteOn = false;
        hintOnSite = 0;
        debugPrint('hintSiteOn  $hintSiteOn');
      }
    }

    if (newHintOn == 2) {
      if (hintLoginOn == false) {
        hintLogin = LocaleKeys.add_login.tr();
        hintLoginOn = true;
        hintOnLogin = 2;
        debugPrint('hintLoginOn  $hintLoginOn');
      } else {
        hintLogin = '';
        hintLoginOn = false;
        hintOnLogin = 0;
        debugPrint('hintLoginOn  $hintLoginOn');
      }
    }

    if (newHintOn == 3) {
      if (hintPassOn == false) {
        hintPass = LocaleKeys.add_pass.tr();
        hintPassOn = true;
        hintOnPass = 3;
        debugPrint('hintSiteOn  $hintPassOn');
      } else {
        hintPass = '';
        hintPassOn = false;
        hintOnPass = 0;
        debugPrint('hintPassOn  $hintPassOn');
      }
    }

    if (newHintOn == 4) {
      if (hintNoteOn == false) {
        hintNote = LocaleKeys.add_note.tr();
        hintNoteOn = true;
        hintOnNote = 4;
        debugPrint('hintNoteOn  $hintNoteOn');
      } else {
        hintNote = '';
        hintNoteOn = false;
        hintOnNote = 0;
        debugPrint('hintNoteOn  $hintNoteOn');
      }
    }

    // if ((objName == 'login') && (newHintOn == true)) {
    //   hintSite = LocaleKeys.add_login;
    //   hintSiteOn = true;
    // } else {
    //   hintSite = '';
    //   hintSiteOn = false;
    // }

    // if ((objName == 'pass') && (newHintOn == true)) {
    //   hintSite = LocaleKeys.add_pass;
    //   hintSiteOn = true;
    // } else {
    //   hintSite = '';
    //   hintSiteOn = false;
    // }

    // if ((objName == 'note') && (newHintOn == true)) {
    //   hintSite = LocaleKeys.add_note;
    //   hintSiteOn = true;
    // } else {
    //   hintSite = '';
    //   hintSiteOn = false;
    // }

    notifyListeners();
  }

  void onFormSubmit() {
    // var i = int.parse(id);

    Box<C_hive> sBox = Hive.box<C_hive>(HiveBoxes.db_hive);
    // sBox.deleteAt(i);
    sBox.putAt(
        id,
        C_hive(
          task: dataSite,
          login: dataLogin,
          pass: dataPass,
          note: dataNote,
        ));
  }
}

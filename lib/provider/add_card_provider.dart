import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/local_db/secstor_card.dart';

class AddCardProvider extends ChangeNotifier {
  String dataNote = '';
  String dataCard = '';
  String dataName = '';
  String dataDate = '';
  String dataDateExp = '';
  String dataCvv = '';
  String dataPinAtm = '';
  int id = 0;
  bool flgAddCard = true;

  int hintOnNote = 0;
  int hintOnCard = 0;
  int hintOnName = 0;
  int hintOnDate = 0;
  int hintOnDateExp = 0;
  int hintOnCvv = 0;
  int hintOnPinAtm = 0;

  bool hintNoteOn = false;
  bool hintCardOn = false;
  bool hintNameOn = false;
  bool hintDateOn = false;
  bool hintDateExpOn = false;
  bool hintCvvOn = false;
  bool hintPinAtmOn = false;

  String hintNote = '';
  String hintCard = '';
  String hintName = '';
  String hintDate = '';
  String hintDateExp = '';
  String hintCvv = '';
  String hintPinAtm = '';

  void cleanDataText() {
    dataNote = '';
    dataCard = '';
    dataName = '';
    dataDate = '';
    dataDateExp = '';
    dataCvv = '';
    dataPinAtm = '';
    id = 0;
    notifyListeners();
  }

  void changeDataId(var newId) {
    id = newId;
  }

  void changeFlgAddCard(bool vol) {
    flgAddCard = vol;
  }

  String setTextVol(int objNum) {
    switch (objNum) {
      case 1:
        return dataNote;

      case 2:
        return dataCard;

      case 3:
        return dataName;

      case 4:
        return dataDate;

      case 5:
        return dataDateExp;

      case 6:
        return dataCvv;

      case 7:
        return dataPinAtm;

      default:
        return '';
    }
  }

  int hintOn(int objNum) {
    switch (objNum) {
      case 1:
        return hintOnNote;
      case 2:
        return hintOnCard;
      case 3:
        return hintOnName;
      case 4:
        return hintOnDate;
      case 5:
        return hintOnDateExp;
      case 6:
        return hintOnCvv;
      case 7:
        return hintOnPinAtm;
      default:
        return hintOnNote;
    }
  }

  void changeDataText(var newDataText, int objNum) {
    switch (objNum) {
      case 1:
        dataNote = newDataText;
        break;
      case 2:
        dataCard = newDataText;
        break;
      case 3:
        dataName = newDataText;
        break;
      case 4:
        dataDate = newDataText;
        break;
      case 5:
        dataDateExp = newDataText;
        break;
      case 6:
        dataCvv = newDataText;
        break;
      case 7:
        dataPinAtm = newDataText;
        break;
    }

    notifyListeners();
  }

  void changeHintOn(var newHintOn) {
    debugPrint('newHintOn  $newHintOn');

    if (newHintOn == 1) {
      if (hintNoteOn == false) {
        hintNote = LocaleKeys.add_note.tr();
        hintNoteOn = true;
        hintOnNote = 1;
        debugPrint('hintNoteOn  $hintNoteOn');
      } else {
        hintNote = '';
        hintNoteOn = false;
        hintOnNote = 0;
        debugPrint('hintNoteOn  $hintNoteOn');
      }
    }

    if (newHintOn == 2) {
      if (hintCardOn == false) {
        hintCard = LocaleKeys.add_card.tr();
        hintCardOn = true;
        hintOnCard = 2;
        debugPrint('hintCardOn  $hintCardOn');
      } else {
        hintCard = '';
        hintCardOn = false;
        hintOnCard = 0;
        debugPrint('hintCardOn  $hintCardOn');
      }
    }

    if (newHintOn == 3) {
      if (hintNameOn == false) {
        hintName = LocaleKeys.add_name.tr();
        hintNameOn = true;
        hintOnName = 3;
        debugPrint('hintNameOn  $hintNameOn');
      } else {
        hintName = '';
        hintNameOn = false;
        hintOnName = 0;
        debugPrint('hintNameOn  $hintNameOn');
      }
    }

    if (newHintOn == 4) {
      if (hintDateOn == false) {
        hintDate = LocaleKeys.add_date.tr();
        hintDateOn = true;
        hintOnDate = 4;
        debugPrint('hintDateOn  $hintDateOn');
      } else {
        hintDate = '';
        hintDateOn = false;
        hintOnDate = 0;
        debugPrint('hintDateOn  $hintDateOn');
      }
    }

    if (newHintOn == 5) {
      if (hintDateExpOn == false) {
        hintDateExp = LocaleKeys.add_date_exp.tr();
        hintDateExpOn = true;
        hintOnDateExp = 5;
        debugPrint('hintDateExpOn  $hintDateExpOn');
      } else {
        hintDateExp = '';
        hintDateExpOn = false;
        hintOnDateExp = 0;
        debugPrint('hintDateExpOn  $hintDateExpOn');
      }
    }

    if (newHintOn == 6) {
      if (hintCvvOn == false) {
        hintCvv = LocaleKeys.add_cvv.tr();
        hintCvvOn = true;
        hintOnCvv = 6;
        debugPrint('hintCvvOn  $hintCvvOn');
      } else {
        hintCvv = '';
        hintCvvOn = false;
        hintOnCvv = 0;
        debugPrint('hintCvvOn  $hintCvvOn');
      }
    }

    if (newHintOn == 7) {
      if (hintPinAtmOn == false) {
        hintPinAtm = LocaleKeys.add_pin.tr();
        hintPinAtmOn = true;
        hintOnPinAtm = 7;
        debugPrint('hintPinAtmOn  $hintPinAtmOn');
      } else {
        hintPinAtm = '';
        hintPinAtmOn = false;
        hintOnPinAtm = 0;
        debugPrint('hintPinAtmOn  $hintPinAtmOn');
      }
    }
    notifyListeners();
  }

  void onFormSubmit() {
    Box<C_hiveCard> sBox = Hive.box<C_hiveCard>(HiveBoxes.db_hiveCard);
    if (flgAddCard) {
      sBox.add(C_hiveCard(
          note: dataNote,
          card: dataCard,
          name: dataName,
          date: dataDate,
          dateExp: dataDateExp,
          cvv: dataCvv,
          pinAtm: dataPinAtm));
    } else {
      sBox.putAt(
          id,
          C_hiveCard(
              note: dataNote,
              card: dataCard,
              name: dataName,
              date: dataDate,
              dateExp: dataDateExp,
              cvv: dataCvv,
              pinAtm: dataPinAtm));
    }
  }
}

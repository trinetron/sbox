import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_cryptor/file_cryptor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/models/local_db/hive_setting.dart';
import 'package:sbox/provider/menu_provider.dart';
import 'package:sbox/provider/permissions_provider.dart';
import 'package:sbox/provider/permissions_provider.dart';
import 'package:sbox/provider/permissions_provider.dart';
import 'package:sbox/provider/radio_provider.dart';
import 'package:sbox/provider/state_provider.dart';
import 'package:sbox/models/local_db/secstor_card.dart';
import 'package:sbox/ui/screens/login_screen.dart';
import 'package:sbox/ui/screens/main_screen.dart';
import 'dart:io' show Platform;
import 'package:cr_file_saver/file_saver.dart';
import '/models/local_db/secstor.dart';
import 'package:flutter/material.dart';
//import 'package:hive/hive.dart';

class DatabaseProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int _selectedIndexCard = 0;
  String pass = '';
  bool initialized = false;
  bool dbFilesExist = false;
  bool msgFilesExist = false;

  String msgSetting = '';
  final hiveSetting = HiveSetting();

  String keyUsr = '';
  String keyMix = '';
  static const String key = 'ED+AB1y5hSnt353cw0E4yZ/nd3xDT/VkVgFozawPYJY=';
  String dir2 = '';

  // @override
  // void dispose() async {
  //   super.dispose();
  //   Hive.close();
  // }

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  late Box<C_hive> _boxA = Hive.box<C_hive>(HiveBoxes.db_hive);

  late C_hive _selectedboxA = C_hive();

  Box<C_hive> get boxA => _boxA;

  C_hive get selectedboxA => _selectedboxA;

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  late Box<C_hiveCard> _boxB = Hive.box<C_hiveCard>(HiveBoxes.db_hiveCard);

  late C_hiveCard _selectedboxB = C_hiveCard();

  Box<C_hiveCard> get boxB => _boxB;

  C_hiveCard get selectedboxB => _selectedboxB;

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Cryptor

  Future<bool> restoreDbFile(context) async {
    // List<String> listFiles = [
    //   'sec_box.hive',
    //   'sec_box_card.hive',
    // ];

    requestStoragePermission();

    var selectedDirectory = await FilePicker.platform.pickFiles();
    if (selectedDirectory == null) {
      return false;
    }
    String dir = selectedDirectory.files.first.path.toString();
    //  +        '/' +        selectedDirectory.files.first.name;

    Directory? appDocDir = await getApplicationDocumentsDirectory();
    String dir2 = appDocDir.path.toString().toLowerCase() + '/sbox';

    debugPrint('dir $dir');
    debugPrint('dir2 $dir2');

    await _boxA.close();
    await _boxB.close();

    bool checkZip = await unzipPack(dir, dir2);

    if (checkZip) {
      await initConfig(context);
      await initSecBD(context);
      context.read<RadioProvider>().changelastD();
    }

    return true;
  }

  bool zipPack(String pathSource, String pathFileTarget, List listFiles) {
    try {
      var encoder = ZipFileEncoder();
      encoder.create(pathFileTarget);
      for (var fName in listFiles) {
        String tmpPath = pathSource + '/' + fName;
        encoder.addFile(File(tmpPath));
      }
      encoder.close();
      return true;
    } catch (e) {
      debugPrint('Error $e');
      return false;
    }
  }

  bool unzipPack(String pathSourceZipFile, String pathTarget) {
    try {
      final bytes = File(pathSourceZipFile).readAsBytesSync();
      final archive = ZipDecoder().decodeBytes(bytes);
      for (final file in archive) {
        final filename = file.name;
        if (file.isFile) {
          final data = file.content as List<int>;
          File(pathTarget + '/' + filename)
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
        }
      }
      return true;
    } catch (e) {
      debugPrint('Error $e');
      return false;
    }
  }

  Future<bool> backupDbFile(context) async {
    List<String> listFiles = [
      'sec_box.hive',
      'sec_box_card.hive',
    ];

    Directory? appDocDir = await getApplicationDocumentsDirectory();
    String? dir = appDocDir.path.toString().toLowerCase() + '/sbox';

    String? dir2 = '';
    bool checkZip = false;

    if ((Platform.isAndroid) || (Platform.isIOS)) {
      try {
        final granted =
            await CRFileSaver.requestWriteExternalStoragePermission();

        debugPrint('requestWriteExternalStoragePermission: $granted');

        String dirTmp = dir + '/sBoxBackUp_' + curDateTime() + '.x3';
        checkZip = zipPack(dir, dirTmp, listFiles);

        dir2 = await CRFileSaver.saveFileWithDialog(SaveFileDialogParams(
          sourceFilePath: dirTmp,
          destinationFileName: 'sBoxBackUp_' + curDateTime() + '.x3',
        ));
        debugPrint('dir $dir');
        debugPrint('dir2 $dir2');
        debugPrint('Saved to $dir');
        return true;
      } catch (error) {
        debugPrint('Error: $error');
        return false;
      }
    } else {
      requestStoragePermission();

      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) {
        return false;
      }
      dir2 = selectedDirectory;
      dir2 = (dir2 + '/sBoxBackUp_' + curDateTime() + '.x3');

      checkZip = zipPack(dir, dir2, listFiles);

      debugPrint('dir $dir');
      debugPrint('dir2 $dir2');

      if (checkZip) {
        return true;
      } else {
        return false;
      }
    }

    debugPrint('dir $dir');
    debugPrint('dir2 $dir2');

    //var directory = await Directory(dir2).create(recursive: true);
    // debugPrint('create directory.path $directory.path');
  }

  Future<void> requestStoragePermission() async {
    var serviceStatus = await Permission.storage.isGranted;

    bool isStorageOn = serviceStatus == ServiceStatus.enabled;
    debugPrint(isStorageOn.toString());

    var status = await Permission.storage.request();

    if (status == PermissionStatus.granted) {
      debugPrint('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      debugPrint('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      debugPrint('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  String curDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd(HH-mm)');
    String formattedDate = formatter.format(now);
    debugPrint(formattedDate);
    return formattedDate;
  }

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Hive
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

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Hive
  ///* Updating the current selected index for that contact to pass to read from hive
  void updateSelectedCardIndex(int indexCard) {
    _selectedIndexCard = indexCard;
    updateSelectedCardContact();
    notifyListeners();
  }

  ///* Updating the current selected item from hive
  void updateSelectedCardContact() {
    _selectedboxB = readFromCardHive()!;
    notifyListeners();
  }

  ///* reading the current selected item from hive
  C_hiveCard? readFromCardHive() {
    C_hiveCard? getItemCard = _boxB.getAt(_selectedIndexCard);

    return getItemCard;
  }

  void deleteFromCardHive() {
    _boxB.deleteAt(_selectedIndex);
    debugPrint(' _boxB.deleteAt   $_selectedIndexCard ');
  }

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  bool get isAuth {
    return initialized != false;
  }

  void msgdbFilesExists(var val) {
    msgFilesExist = val;
  }

  Future<bool> dbFilesExists() async {
    Directory? appDocDir = await getApplicationDocumentsDirectory();
    String appPath = appDocDir.path + '/sbox';
    // String appPath = appDocDir.path;
    if ((await Hive.boxExists(HiveBoxes.db_hive, path: appPath)) &&
        (await Hive.boxExists(HiveBoxes.db_hiveCard, path: appPath))) {
      debugPrint('dbFilesExists true');
      return true;
    } else {
      debugPrint('dbFilesExists false');
      return false;
    }
  }

  void changeDataLogin(String val) {
    pass = val;
    // if (pass == 'xxx') {
    //   initialized = true;
    // }
    debugPrint('pass  $pass');
    notifyListeners();
  }

  initConfig(context) async {
    try {
      msgSetting = await hiveSetting.readSetting();
      await context.read<MenuProvider>().menuSet(msgSetting, context);
      debugPrint('initConfig try run: ---');
      //notifyListeners();
    } catch (e) {
      debugPrint('initConfig error caught: $e');
      debugPrint('err run: ---');
    }
  }

  initSecBD(BuildContext context) async {
    try {
      //var key = Hive.generateSecureKey();
      //String keyUsr = '12345';
      keyUsr = pass;
      keyMix = '';
      debugPrint(key);

      keyMix = key.replaceRange(0, keyUsr.length, keyUsr);

      debugPrint('keyMix $keyMix');

      final keyEnc = base64.decode(keyMix);
      debugPrint(keyEnc.toString());

      Directory? appDocDir = await getApplicationDocumentsDirectory();
      String appPath = appDocDir.path + '/sbox';
      // String appPath = appDocDir.path;
      debugPrint('appPath  $appPath');

      _boxA = await Hive.openBox<C_hive>(HiveBoxes.db_hive,
          encryptionCipher: HiveAesCipher(keyEnc),
          crashRecovery: false,
          path: appPath);

      debugPrint('_boxA.isOpen $_boxA.isOpen.toString()');

      _boxB = await Hive.openBox<C_hiveCard>(HiveBoxes.db_hiveCard,
          encryptionCipher: HiveAesCipher(keyEnc),
          crashRecovery: false,
          path: appPath);

      debugPrint('_boxB.isOpen $_boxB.isOpen.toString()');

      // if ((await Hive.isBoxOpen('db_hive')) &&
      //     (await Hive.isBoxOpen('db_hiveCard'))) {
      if ((_boxA.isOpen) && (_boxB.isOpen)) {
        context.read<StateProvider>().changeInit(true);
        context.read<StateProvider>().changeErrState(false);
        context.read<RadioProvider>().changeInt(1, context);
        notifyListeners();

        await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MainScreen()));
      } else {
        context.read<StateProvider>().changeErrState(false);
        context.read<StateProvider>().changeInit(false);
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(LocaleKeys.pass_err.tr()),
        ));
      }

      debugPrint('initSecBD try run: ---');
    } catch (e, s) {
      debugPrint('initSecBD error caught: $e');
      debugPrint('initSecBD error Стек: $s');

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(LocaleKeys.pass_err.tr()),
      // ));

      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => LoginScreen()));

      debugPrint('initSecBD err run: ---');
    } finally {
      //
      // context.read<StateProvider>().changeInit(true);
      // notifyListeners();
      // await Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => MainScreen()));
    }
  }
}

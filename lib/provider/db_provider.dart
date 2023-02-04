import 'dart:convert';
import 'dart:io';

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
import 'package:sbox/provider/state_provider.dart';
import 'package:sbox/models/local_db/secstor_card.dart';
import 'package:sbox/ui/screens/login_screen.dart';
import 'package:sbox/ui/screens/main_screen.dart';

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
  String key = 'ED+AB1y5hSnt353cw0E4yZ/nd3xDT/VkVgFozawPYJY=';
  String dir2 = '';

  @override
  void dispose() async {
    Hive.close();
  }

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
    List<String> listFiles = [
      'sec_box.hive',
      // 'sec_box.lock',
      'sec_box_card.hive',
      //  'sec_box_card.lock',
      'setbox.hive',
      //  'setbox.lock'
    ];

    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    Directory? appDocDir = await getExternalStorageDirectory();
    if (selectedDirectory == null) {
      return false;
    }

    // String dir2 = appDocDir.path.toString().toLowerCase() + '\\sbox';
    String dir2 = appDocDir!.path.toString().toLowerCase();
    String dir = selectedDirectory;
    debugPrint('dir = appDocDir $dir');
    debugPrint('dir2 $dir2');

    // var now = new DateTime.now();
    // var formatter = new DateFormat('yyyy-MM-dd');
    // String formattedDate = formatter.format(now);
    // debugPrint(formattedDate);

    // dir2 = (dir2 + '\\sbox_' + formattedDate);

    // var directory = await Directory(dir2).create(recursive: true);

    // debugPrint(directory.path);

    for (var fName in listFiles) {
      String d1 = dir + '\\' + fName + '.sbox';
      String d2 = dir2 + '\\' + fName;
      var d1F = File(d1);
      debugPrint('d1 $d1');
      debugPrint('d2 $d2');
      await Hive.close();
      File nFile = await copyFile(d1F, d2);
      if (nFile != null) {
        initConfig(context);
        initSecBD(context);
      }
    }

    return true;
  }

  Future<bool> backupDbFile() async {
    List<String> listFiles = [
      'sec_box.hive',
      // 'sec_box.lock',
      'sec_box_card.hive',
      // 'sec_box_card.lock',
      //'setbox.hive',
      //  'setbox.lock'
    ];

    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    Directory? appDocDir = await getExternalStorageDirectory();
    if (selectedDirectory == null) {
      return false;
    }

    // String dir = appDocDir.path.toString().toLowerCase() + '/sbox';
    String dir = appDocDir!.path.toString().toLowerCase();
    debugPrint('dir = appDocDir $dir');

    dir2 = selectedDirectory;
    //dir2 = dir;
    debugPrint(selectedDirectory);

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    debugPrint(formattedDate);

    // // You can request multiple permissions at once.
    // Map<Permission, PermissionStatus> statuses = await [
    //   Permission.storage,
    // ].request();
    // print(statuses[Permission.storage]);

    dir2 = (dir2 + '/sbox_' + formattedDate);
    debugPrint('dir2  $dir2');

    var directory = await Directory(dir2).create(recursive: true);

    debugPrint('directory.path $directory.path');

    for (var fName in listFiles) {
      // String d1 = dir + '\\' + fName;
      // String d2 = dir2 + '\\' + fName + '.sbox';
      String d1 = dir + '/' + fName;
      String d2 = dir2 + '/' + fName + '.sbox';
      var d1F = File(d1);
      debugPrint('d1 $d1');
      debugPrint('d2 $d2');

      copyFile(d1F, d2);
    }

    return true;
  }

  Future<bool> encFile(var inputFileF, var outputFileF, var selectedDirectory,
      var compress) async {
    String keyCrypt = keyMix.substring(4, 36);
    debugPrint(keyCrypt);

    // var picked = await FilePicker.platform.pickFiles();
    // if (picked != null) {
    //   print(picked.files.first.name);
    // }

    // String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    Directory? appDocDir = await getExternalStorageDirectory();
    if (selectedDirectory == null) {
      return false;
      // selectedDirectory = appDocDir.path.toString().toLowerCase();
    }
    // } else {
    //   dir = selectedDirectory;
    //   debugPrint(selectedDirectory);
    // }

    // String dir = appDocDir.path.toString().toLowerCase() + '\\sbox';
    String dir = appDocDir!.path.toString().toLowerCase();
    debugPrint('dir = appDocDir $dir');

    dir2 = selectedDirectory;
    debugPrint(selectedDirectory);

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);

    dir2 = (dir2 + '\\sbox_' + formattedDate);

    var directory = await Directory(dir2).create(recursive: true);

    print(directory.path);

    FileCryptor fileCryptor = FileCryptor(
      key: keyCrypt,
      iv: 16,
      dir: dir,
      useCompress: compress,
    );

    File encryptedFile = await fileCryptor.encrypt(
        inputFile: inputFileF, outputFile: outputFileF);
    print(encryptedFile.absolute);

    dir = dir + '\\' + outputFileF;
    dir2 = dir2 + '\\' + outputFileF;
    var dirF = File(dir);
    print('dir $dir');
    moveFile(dirF, dir2);

    if (encryptedFile != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> decFile(
      String inputFileF, String outputFileF, String dir, bool compress) async {
    String keyCrypt = keyMix.substring(4, 36);
    debugPrint(keyCrypt);

    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    Directory? appDocDir = await getExternalStorageDirectory();
    if (selectedDirectory == null) {
      return false;
      // selectedDirectory = appDocDir.path.toString().toLowerCase();
    }
    // } else {
    //   dir = selectedDirectory;
    //   debugPrint(selectedDirectory);
    // }

    dir2 = appDocDir!.path.toString().toLowerCase();

    dir = selectedDirectory;
    debugPrint('selectedDirectory dir $dir');

    // var now = new DateTime.now();
    // var formatter = new DateFormat('yyyy-MM-dd');
    // String formattedDate = formatter.format(now);
    // print(formattedDate);

    // var directory = await Directory(dir2).create(recursive: true);

    // print(directory.path);

    FileCryptor fileCryptor = FileCryptor(
      key: keyCrypt,
      iv: 16,
      dir: dir,
      useCompress: compress,
    );

    File decryptedFile = await fileCryptor.decrypt(
        inputFile: inputFileF, outputFile: outputFileF);
    //print('decryptedFile.absolute $decryptedFile.absolute');

    dir = dir + '\\' + outputFileF;
    dir2 = (dir2 + '\\' + outputFileF);
    print('dir $dir');
    print('dir2 $dir2');
    //dir2 = directory.path + '\\' + outputFileF;
    var dirF = File(dir);
    print('dir $dir');
    moveFile(dirF, dir2);

    if (decryptedFile != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<File> copyFile(File sourceFile, String newPath) async {
    try {
      /// prefer using rename as it is probably faster
      /// if same directory path
      return await sourceFile.rename(newPath);
    } catch (e) {
      /// if rename fails, copy the source file
      final newFile = await sourceFile.copy(newPath);

      return newFile;
    }
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      /// prefer using rename as it is probably faster
      /// if same directory path
      return await sourceFile.rename(newPath);
    } catch (e) {
      /// if rename fails, copy the source file
      final newFile = await sourceFile.copy(newPath);
      if (newFile != null) {
        await sourceFile.delete();
      }
      return newFile;
    }
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
    Directory? appDocDir = await getExternalStorageDirectory();
    // String appPath = appDocDir.path + '\\sbox';
    String appPath = appDocDir!.path;
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

      Directory? appDocDir = await getExternalStorageDirectory();
      // String appPath = appDocDir.path + '/sbox';
      String appPath = appDocDir!.path;
      debugPrint('appPath  $appPath');

      var boxSite = await Hive.openBox<C_hive>(HiveBoxes.db_hive,
          encryptionCipher: HiveAesCipher(keyEnc),
          crashRecovery: false,
          path: appPath);
      var boxCard = await Hive.openBox<C_hiveCard>(HiveBoxes.db_hiveCard,
          encryptionCipher: HiveAesCipher(keyEnc),
          crashRecovery: false,
          path: appPath);

      if ((boxSite != null) && (boxCard != null)) {
        context.read<StateProvider>().changeInit(true);
        context.read<StateProvider>().changeErrState(false);
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

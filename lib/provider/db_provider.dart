import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:csv/csv.dart';
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
import 'package:sbox/models/local_db/secstor_card_tmp.dart';
import 'package:sbox/models/local_db/secstor_tmp.dart';
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
import 'dart:convert';

class DatabaseProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int _selectedIndexCard = 0;
  String pass = '';
  bool checkPassErr = true;
  bool initialized = false;
  bool dbFilesExist = false;
  bool msgFilesExist = false;

  String msgSetting = '';
  final hiveSetting = HiveSetting();

  String keyUsr = '';
  String keyMix = '';
  static const String key = 'ED+AB1y5hSnt353cw0E4yZ/nd3xDT/VkVgFozawPYJY=';
  String dir2 = '';

  String masterPassVol = '';

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
  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Cryptor

  Future<bool> restoreDbFile(context) async {
    requestStoragePermission();

    var selectedDirectory = await FilePicker.platform.pickFiles();
    if (selectedDirectory == null) {
      return false;
    }
    String dir = selectedDirectory.files.first.path.toString();

    Directory? appDocDir = await getApplicationDocumentsDirectory();
    String dir2 = appDocDir.path + '/sbox';

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

  Future<bool> zipPack(
      String pathSource, String pathFileTarget, List listFiles) async {
    try {
      var encoder = await ZipFileEncoder();
      encoder.create(await pathFileTarget);
      for (var fName in await listFiles) {
        String tmpPath = pathSource + '/' + fName;
        await encoder.addFile(await File(tmpPath));
        debugPrint('zip encoder.addFile $tmpPath');
      }
      encoder.close();
      return true;
    } catch (e) {
      debugPrint('Error $e');
      return false;
    }
  }

//This function unzips a source zip file and writes the file contents to the specified target directory.
  bool unzipPack(String pathSourceZipFile, String pathTarget) {
    try {
      //reads in the bytes from the source zip file
      final bytes = File(pathSourceZipFile).readAsBytesSync();
      //decodes the bytes into an archive
      final archive = ZipDecoder().decodeBytes(bytes);
      //for each file in the archive
      for (final file in archive) {
        //obtains the filename
        final filename = file.name;
        //checks if the file is a regular file
        if (file.isFile) {
          //obtains the file contents as a byte list
          final data = file.content as List<int>;
          //creates the file in the specified target directory and writes the contents
          File('$pathTarget/$filename')
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
        }
      }
      return true;
    } catch (e) {
      //handles the error if the code throws an exception
      debugPrint('Error $e');
      return false;
    }
  }

// This function generates a backup of two Hive database files to a specified directory.
  Future<bool> backupDbFile(context) async {
    List<String> listFiles = [
      'sec_box.hive', // The name of the first Hive database file to backup
      'sec_box_card.hive', // The name of the second Hive database file to backup
    ];

    Directory? appDocDir =
        await getApplicationDocumentsDirectory(); // Get the directory where the app is installed
    String? dir =
        appDocDir.path + '/sbox'; // Set the directory path for the backup

    String? dir2 = ''; // Set the variable dir2 to an empty string
    bool checkZip = false; // Set the checkZip variable to false

    // Check if the app is running on an Android or iOS device
    if ((Platform.isAndroid) || (Platform.isIOS)) {
      try {
        // Request permission to write to external storage
        final granted =
            await CRFileSaver.requestWriteExternalStoragePermission();
        debugPrint('requestWriteExternalStoragePermission: $granted');

        // Generate a new temporary directory path
        String dirTmp = dir + '/sBoxBackUp_' + curDateTime() + '.x3';

        // Package the specified files into a zip file
        checkZip = await zipPack(dir, dirTmp, listFiles);

        // Save the backup file to the device's storage
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
      // If the app is running on any other device (e.g. web)
      requestStoragePermission(); // Request permission to access the device's storage

      // Allow the user to select a directory to save the backup file to
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) {
        return false;
      }

      // Generate a new directory path for the backup file
      dir2 = selectedDirectory;
      dir2 = (dir2 + '/sBoxBackUp_' + curDateTime() + '.x3');

      // Package the specified files into a zip file
      checkZip = await zipPack(dir, dir2, listFiles);

      debugPrint('dir $dir');
      debugPrint('dir2 $dir2');

      // Return true if the backup file was successfully generated and saved, otherwise return false
      if (checkZip) {
        return true;
      } else {
        return false;
      }
    }
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
    _boxB.deleteAt(_selectedIndexCard);
    debugPrint(' _boxB.deleteAt   $_selectedIndexCard ');
  }

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  bool get isAuth {
    return initialized = false;
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

      keyMix = _genMixPass(keyUsr, key);

      //keyMix = key.replaceRange(0, keyUsr.length, keyUsr);

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
        context.read<DatabaseProvider>().checkPassErr = false;
        notifyListeners();

        await Navigator.of(context).push(
            PageRouteBuilder(pageBuilder: (context, a1, a2) => MainScreen()));
      } else {
        context.read<StateProvider>().changeErrState(false);
        context.read<StateProvider>().changeInit(false);
        context.read<DatabaseProvider>().checkPassErr = true;
        notifyListeners();
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(LocaleKeys.pass_err.tr()),
        // ));
      }

      debugPrint('initSecBD try run: ---');
    } catch (e, s) {
      debugPrint('initSecBD error caught: $e');
      debugPrint('initSecBD error Стек: $s');
      debugPrint('initSecBD err run: ---');
    } finally {
      //
      // context.read<StateProvider>().changeInit(true);
      // notifyListeners();
      // await Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => MainScreen()));
    }
  }

  Future<bool> generateCsvFiles() async {
    List<String> listFiles = [
      'sbox_accounts.csv',
      'sbox_card.csv',
    ];

    Directory? appDocDir = await getApplicationDocumentsDirectory();
    String? dir = appDocDir.path + '/sbox';
    // String dir = appDocDir.path;

//>>>>>>>>>>>>>>>>>>>>>>>>>>>.
    await genCSV(dir, listFiles);
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    String? dir2 = dir;
    bool checkZip = false;

    if ((Platform.isAndroid) || (Platform.isIOS)) {
      try {
        final granted =
            await CRFileSaver.requestWriteExternalStoragePermission();

        debugPrint('requestWriteExternalStoragePermission: $granted');

        String dirTmp = dir + '/sBoxCSVpack_' + curDateTime() + '.zip';
        checkZip = await zipPack(dir, dirTmp, listFiles);

        dir2 = await CRFileSaver.saveFileWithDialog(SaveFileDialogParams(
          sourceFilePath: dirTmp,
          destinationFileName: 'sBoxCSVpack_' + curDateTime() + '.zip',
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
      dir2 = (dir2 + '/sBoxCSVpack_' + curDateTime() + '.zip');

      checkZip = await zipPack(dir, dir2, listFiles);

      debugPrint('dir $dir');
      debugPrint('dir2 $dir2');

      if (checkZip) {
        await delFile(File(dir + '/' + listFiles[0]));
        await delFile(File(dir + '/' + listFiles[1]));
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> genCSV(String dir, List listFiles) async {
    List<List<dynamic>> rows = [];

    var bx = Hive.box<C_hive>(HiveBoxes.db_hive);

    List<dynamic> row = [];
    row.add("URL");
    row.add("Login");
    row.add("Password");
    row.add("Description");
    rows.add(row);
    for (int i = 0; i < bx.length; i++) {
      List<dynamic> row = [];
      row.add(bx.get(i)?.task.toString());
      row.add(bx.get(i)?.login.toString());
      row.add(bx.get(i)?.pass.toString());
      row.add(bx.get(i)?.note.toString());
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    debugPrint("dir $dir");

    File f = File(dir + '/' + listFiles[0]);
    var sink = await f.openWrite();
    sink.writeln(csv);
    await f.openRead();
    await sink.close();
    //sink.flush();

    //sink.writeAsString(csv);

    //>>>>>>>>>>>>>>>>>>

    List<List<dynamic>> rows2 = [];

    var bx2 = Hive.box<C_hiveCard>(HiveBoxes.db_hiveCard);

    List<dynamic> row2 = [];
    row2.add("Description");
    row2.add("Card");
    row2.add("Name");
    row2.add("Date");
    row2.add("DateExp");
    row2.add("CVV");
    row2.add("PIN_ATM");
    rows2.add(row2);
    for (int i = 0; i < bx.length; i++) {
      List<dynamic> row2 = [];
      row2.add(bx2.get(i)?.note.toString());
      row2.add(bx2.get(i)?.card.toString());
      row2.add(bx2.get(i)?.name.toString());
      row2.add(bx2.get(i)?.date.toString());
      row2.add(bx2.get(i)?.dateExp.toString());
      row2.add(bx2.get(i)?.cvv.toString());
      row2.add(bx2.get(i)?.pinAtm.toString());
      rows2.add(row2);
    }

    String csv2 = const ListToCsvConverter().convert(rows2);

    debugPrint("dir $dir");

    File f2 = File(dir + '/' + listFiles[1]);
    var sink2 = await f2.openWrite();
    sink2.writeln(csv2);
    await f2.openRead();
    await sink2.close();
    //   await sink2.flush();
    //f2.writeAsString(csv2);

    if ((f != null) && (f2 != null)) {
      return true;
    } else
      return false;
  }

  void changeDataMasterPass(String vol) {
    masterPassVol = vol;
    notifyListeners();
  }

  Future<void> changeMasterPass() async {
    bool chkFinish = await dbFilesNew();
    chkFinish
        ? debugPrint('MasterPass Changed')
        : debugPrint('MasterPass not Changed');
  }

  Future<bool> dbFilesNew() async {
    requestStoragePermission();

    keyUsr = masterPassVol;
    keyMix = '';
    debugPrint(key);

    keyMix = _genMixPass(keyUsr, key);

    // keyMix = key.replaceRange(0, keyUsr.length, keyUsr);

    debugPrint('keyMix $keyMix');

    final keyEnc = base64.decode(keyMix);
    debugPrint(keyEnc.toString());

    Directory? appDocDir = await getApplicationDocumentsDirectory();
    String appPath = appDocDir.path + '/sbox';

    debugPrint('appPath  $appPath');

    _boxA.isOpen
        ? debugPrint('_boxA.isOpen true')
        : debugPrint('_boxA.isOpen false');

    _boxB.isOpen
        ? debugPrint('_boxB.isOpen true')
        : debugPrint('_boxB.isOpen false');

    Box<C_hive_tmp> _boxC = await Hive.openBox<C_hive_tmp>(
        HiveBoxes.db_hive_tmp,
        encryptionCipher: HiveAesCipher(keyEnc),
        crashRecovery: true,
        path: appPath);

    _boxC.isOpen
        ? debugPrint('_boxC.isOpen true')
        : debugPrint('_boxC.isOpen false');

    Box<C_hiveCard_tmp> _boxD = await Hive.openBox<C_hiveCard_tmp>(
        HiveBoxes.db_hiveCard_tmp,
        encryptionCipher: HiveAesCipher(keyEnc),
        crashRecovery: true,
        path: appPath);

    _boxD.isOpen
        ? debugPrint('_boxD.isOpen true')
        : debugPrint('_boxD.isOpen false');

    // debugPrint('_boxD.isOpen $_boxD.isOpen.toString()');

    //Box<C_hive> sBox = Hive.box<C_hive>(HiveBoxes.db_hive);

    if (await dbFilesExistsNewDB()) {
      for (int i = 0; i < _boxA.length; i++) {
        _boxC.add(C_hive_tmp(
          task: (_boxA.getAt(i)!.task.isEmpty) ? ' ' : _boxA.getAt(i)!.task,
          login: (_boxA.getAt(i)!.login.isEmpty) ? ' ' : _boxA.getAt(i)!.login,
          pass: (_boxA.getAt(i)!.pass.isEmpty) ? ' ' : _boxA.getAt(i)!.pass,
          note: (_boxA.getAt(i)!.note.isEmpty) ? ' ' : _boxA.getAt(i)!.note,
        ));
      }

      for (int i = 0; i < _boxB.length; i++) {
        _boxD.add(C_hiveCard_tmp(
          note: (_boxB.getAt(i)!.note.isEmpty) ? ' ' : _boxB.getAt(i)!.note,
          card: (_boxB.getAt(i)!.card.isEmpty) ? ' ' : _boxB.getAt(i)!.card,
          name: (_boxB.getAt(i)!.name.isEmpty) ? ' ' : _boxB.getAt(i)!.name,
          date: (_boxB.getAt(i)!.date.isEmpty) ? ' ' : _boxB.getAt(i)!.date,
          dateExp:
              (_boxB.getAt(i)!.dateExp.isEmpty) ? ' ' : _boxB.getAt(i)!.dateExp,
          cvv: (_boxB.getAt(i)!.cvv.isEmpty) ? ' ' : _boxB.getAt(i)!.cvv,
          pinAtm:
              (_boxB.getAt(i)!.pinAtm.isEmpty) ? ' ' : _boxB.getAt(i)!.pinAtm,
        ));
      }

      await _boxA.clear();
      await _boxB.clear();

      await _boxA.close();
      await _boxB.close();

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

      for (int i = 0; i < _boxC.length; i++) {
        _boxA.add(C_hive(
          task: (_boxC.getAt(i)!.task.isEmpty) ? ' ' : _boxC.getAt(i)!.task,
          login: (_boxC.getAt(i)!.login.isEmpty) ? ' ' : _boxC.getAt(i)!.login,
          pass: (_boxC.getAt(i)!.pass.isEmpty) ? ' ' : _boxC.getAt(i)!.pass,
          note: (_boxC.getAt(i)!.note.isEmpty) ? ' ' : _boxC.getAt(i)!.note,
        ));
      }

      for (int i = 0; i < _boxD.length; i++) {
        _boxB.add(C_hiveCard(
          note: (_boxD.getAt(i)!.note.isEmpty) ? ' ' : _boxD.getAt(i)!.note,
          card: (_boxD.getAt(i)!.card.isEmpty) ? ' ' : _boxD.getAt(i)!.card,
          name: (_boxD.getAt(i)!.name.isEmpty) ? ' ' : _boxD.getAt(i)!.name,
          date: (_boxD.getAt(i)!.date.isEmpty) ? ' ' : _boxD.getAt(i)!.date,
          dateExp:
              (_boxD.getAt(i)!.dateExp.isEmpty) ? ' ' : _boxD.getAt(i)!.dateExp,
          cvv: (_boxD.getAt(i)!.cvv.isEmpty) ? ' ' : _boxD.getAt(i)!.cvv,
          pinAtm:
              (_boxD.getAt(i)!.pinAtm.isEmpty) ? ' ' : _boxD.getAt(i)!.pinAtm,
        ));
      }

      await _boxC.close();
      await _boxD.close();

      await delFile(File(appPath + '/sec_box_tmp.hive'));
      await delFile(File(appPath + '/sec_box_card_tmp.hive'));

      return true;
    } else {
      return false;
    }
  }

  Future<void> delFile(File sourceFile) async {
    try {
      await sourceFile.delete();
    } catch (e) {
      debugPrint('delFile Err');
    }
  }

  String _genMixPass(String usrKey, String mainKey) {
    int checkSum = _calculateChecksum(usrKey);
    debugPrint('checkSum $checkSum');

    while (checkSum >= (32 - usrKey.length)) {
      checkSum = checkSum ~/ 2;
    }
    if (checkSum < 0) {
      checkSum * -1;
    }
    debugPrint('offset $checkSum');
    int end = keyUsr.length + checkSum;
    debugPrint('end $end');
    String result = mainKey.replaceRange(checkSum, end, usrKey);
    debugPrint('result_genMixPass $checkSum');
    return result;
  }

  int _calculateChecksum(String input) {
    List<int> bytes = utf8.encode(input);
    int checksum = 0;

    for (int byte in bytes) {
      checksum += byte;
    }

    int result = checksum & 0xFF;
    return result;
    // return result.toRadixString(16).toUpperCase();
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
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

  Future<bool> dbFilesExistsNewDB() async {
    Directory? appDocDir = await getApplicationDocumentsDirectory();
    String appPath = appDocDir.path + '/sbox';
    if ((await Hive.boxExists(HiveBoxes.db_hive_tmp, path: appPath)) &&
        (await Hive.boxExists(HiveBoxes.db_hiveCard_tmp, path: appPath))) {
      debugPrint('dbFilesExists true');
      return true;
    } else {
      debugPrint('dbFilesExists false');
      return false;
    }
  }
}

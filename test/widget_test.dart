import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:test/test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sbox/provider/db_provider.dart';
import 'package:archive/archive.dart';
import 'dart:io';

void main() {
  group('DatabaseProvider', () {
    late DatabaseProvider provider;
    var bbb = DatabaseProvider();
    setUp(() {});

    WidgetsFlutterBinding.ensureInitialized();
    BuildContext context;

    test('Test zipPack function', () async {
      // create temporary file and directory for testing
      final tempdir = await getApplicationDocumentsDirectory();
      final filename = '${tempdir.path}/test.zip';
      final dir = await Directory('${tempdir.path}').create();
      await File('${dir.path}/test.txt').writeAsString('hello world');

      // create list of files to add to archive
      final fileList = ['test.txt'];

      debugPrint(dir.path);
      debugPrint(filename);
      debugPrint(fileList.toString());

      // call the zipPack function and check its return value

      expect(await bbb.zipPack(dir.path, filename, fileList), true);

      // expect(
      //     Provider.of<DatabaseProvider>.zipPack(dir.path, filename, fileList));

      // check that the zip file was created and has the correct contents
      final bytes = await File(filename).readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);
      expect(archive.numberOfFiles(), equals(1));
      expect(archive.files[0].name, equals('test.txt'));
      expect(archive.files[0].content, equals('hello world'.codeUnits));

      // clean up the temporary files and directory
      await File(filename).delete();
      await dir.delete(recursive: true);
    });
  });
}

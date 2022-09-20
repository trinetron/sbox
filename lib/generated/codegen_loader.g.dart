// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ru = {
  "Add": "Добавить",
  "Box_is_empty": "Сундучек пустой",
  "lLabel": "Название",
  "Note": "Записка",
  "form_is_invalid": "В форме есть ошибка",
  "Label_name_should_not_be_empty": "Название не указанно"
};
static const Map<String,dynamic> en = {
  "Add": "Add",
  "Box_is_empty": "Box is empty",
  "lLabel": "Label",
  "Note": "Note",
  "form_is_invalid": "form is invalid",
  "Label_name_should_not_be_empty": "Label name should not be empty"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": ru, "en": en};
}

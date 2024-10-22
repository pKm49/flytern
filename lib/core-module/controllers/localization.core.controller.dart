import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:get/get.dart';
import 'package:flytern/core-module/models/translation.core.model.dart';

class CoreTranslationController extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {};

  static Future<void> initLanguages() async {
    final _keys = await readJson();
    Get.clearTranslations();
    Get.addTranslations(_keys);
  }

  static Future<Map<String, Map<String, String>>> readJson() async {
    final res = await rootBundle.loadString(ASSETS_TRANSLATIONS);
    List<dynamic> data = jsonDecode(res);
    final listData = data.map((j) => Translation.fromJson(j)).toList();
    final keys = Map<String, Map<String, String>>();
    listData.forEach((value) {
      final String translationKey = value.code!;
      keys.addAll({translationKey: value.texts!});
    });
    return keys;
  }

}

// Localizations.localeOf(context).languageCode.toString() to get current local
// or
// import 'package:intl/intl.dart';
//
// String locale = Intl.getCurrentLocale();
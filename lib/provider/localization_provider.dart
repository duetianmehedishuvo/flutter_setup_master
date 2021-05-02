import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial/util/app_constant.dart';

class LocalizationProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  LocalizationProvider({@required this.sharedPreferences}) {
    _loadCurrentLanguage();
  }

  Locale _locale = Locale('en', 'US');
  bool _isLtr = true;

  Locale get locale => _locale;

  bool get isLtr => _isLtr;

  saveLanguageStatus(bool status) async {
    await sharedPreferences.setBool(AppConstant.SELECT_LANGUAGE_STATUS, status);
    notifyListeners();
  }

  bool get getLanguageStatus => sharedPreferences.getBool(AppConstant.SELECT_LANGUAGE_STATUS) ?? true;

  void setLanguage(Locale locale) {
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    _saveLanguage(_locale);
    notifyListeners();
  }

  _loadCurrentLanguage() async {
    _locale = Locale(sharedPreferences.getString(AppConstant.LANGUAGE_CODE) ?? 'en', sharedPreferences.getString(AppConstant.COUNTRY_CODE) ?? 'US');
    _isLtr = _locale.languageCode == 'en';
    notifyListeners();
  }

  _saveLanguage(Locale locale) async {
    sharedPreferences.setString(AppConstant.LANGUAGE_CODE, locale.languageCode);
    sharedPreferences.setString(AppConstant.COUNTRY_CODE, locale.countryCode);
  }
}

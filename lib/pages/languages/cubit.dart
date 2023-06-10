import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

enum LanguageType { arabic, english }

class LanguageCubit extends Cubit<LanguageStates> {
  LanguageCubit() : super(LanguageInitialState());

  static LanguageCubit get(context) => BlocProvider.of(context);

  LanguageType? type;
  String? selectedLang;
  List<String> lang = [
    "English",
    "عربي",
  ];
  // List<VoidCallback> changeLang = [
  //   () {
  //     CacheHelper.saveLang("en");
  //     Get.updateLocale(const Locale('en'));
  //     navigateTo(page: NavBarView(), withHistory: false);
  //   },
  //   () {
  //     CacheHelper.saveLang("ar");
  //     Get.updateLocale(const Locale('ar'));
  //     navigateTo(page: NavBarView(), withHistory: false);
  //   },
  // ];

  void arabicType() {
    type = LanguageType.arabic;
    emit(ArabicState());
  }

  void englishType() {
    type = LanguageType.english;
    emit(EnglishState());
  }

  onChangeLang(value) {
    selectedLang = value;
    emit(ChangeLangState());
  }
}

class LanguageAppCubit extends Cubit<Locale> {
  LanguageAppCubit() : super(Locale('ar'));

  void changeLanguage(String languageCode) {
    emit(Locale(languageCode));
  }
}

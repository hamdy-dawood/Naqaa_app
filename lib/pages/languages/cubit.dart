import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/core/cache_helper.dart';

import 'states.dart';

enum LanguageType { arabic, english }

class LanguageCubit extends Cubit<LanguageStates> {
  LanguageCubit() : super(LanguageInitialState());

  static LanguageCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> dropDownKey = GlobalKey<FormState>();

  LanguageType? type;
  String? selectedLang;
  List<String> lang = [
    "English",
    "عربي",
  ];

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

String savedLang = CacheHelper.getLang();
Locale initialLocale = savedLang.isNotEmpty ? Locale(savedLang) : Locale("ar");

class LanguageAppCubit extends Cubit<Locale> {
  LanguageAppCubit() : super(initialLocale);

  void changeLanguage(String languageCode) {
    emit(Locale(languageCode));
  }
}

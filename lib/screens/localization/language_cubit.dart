import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'helpers/language_constants.dart';

import '../../main.dart';
import 'helpers/launguage.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState());

  setLocaleLanguageData(Locale locale){
      emit(state.copyWith(locale: locale));
  }

  void changeLanguage(Language? language,BuildContext context) async{
    if (language != null) {
      Locale locale = await setLocale(language.languageCode);
      emit(state.copyWith(locale: locale));
    }
  }


}

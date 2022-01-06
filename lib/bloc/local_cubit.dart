import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local class to manage the app language using the [cubit] to emit the events
class LocalCubit extends Cubit<Locale> {
  LocalCubit(Locale initialState) : super(initialState);

  /// insert the defult language first time open the app
  void changeStartLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('lang');
    if (langCode != null) {
      emit(Locale(langCode, ''));
    }
  }

  /// change the defult langaue and store to shared prefernce
  /// usine the [context] and the required [data]
  void changeLang(context, String data) async {
    emit(Locale(data, ''));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', data);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';

import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  String phoneNumber = "";
  bool isChecked = false;

  Future<void> login() async {
    emit(LoginLoadingState());
    Future.delayed(
      const Duration(seconds: 3),
      () {
        emit(LoginSuccessState());
      },
    );
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  onInputChanged(PhoneNumber number) {
    phoneNumber = number.phoneNumber!;
    emit(ChangeNumberState());
  }

  rememberCheckBox() {
    isChecked = !isChecked;
    emit(ChanceCheckBoxState());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:naqaa/core/cache_helper.dart';

import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  String phoneNumber = "";
  String initialPhoneNumber = "+97412345678";
  bool isChecked = false;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      Future.delayed(
        const Duration(seconds: 3),
        () {
          CacheHelper.saveUserID("3");
          emit(LoginSuccessState());
        },
      );
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

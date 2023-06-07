import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  String phoneNumber = "";
  bool isChecked = false;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      try {
        final response = await Dio().post(UrlsStrings.loginUrl,
            data: FormData.fromMap({
              "phone": phoneNumber,
            }));
        if (response.statusCode == 200) {
          emit(LoginSuccessState());
        } else {
          emit(LoginFailureState(msg: response.data["status"]));
        }
      } on DioError catch (e) {
        String errorMsg;
        if (e.type == DioErrorType.cancel) {
          errorMsg = 'Request was cancelled';
          emit(LoginFailureState(msg: errorMsg));
        } else if (e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.sendTimeout) {
          errorMsg = 'Connection timed out';
          emit(NetworkErrorState());
        } else if (e.type == DioErrorType.badResponse) {
          errorMsg = 'Invalid status code: ${e.response!.statusMessage}';
          emit(LoginFailureState(msg: errorMsg));
        } else {
          errorMsg = 'An unexpected error : ${e.error}';
          emit(NetworkErrorState());
        }
      } catch (e) {
        emit(LoginFailureState(msg: 'An unknown error: $e'));
      }
    }
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

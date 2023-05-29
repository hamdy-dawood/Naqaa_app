import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/pages/login/controllers.dart';

import 'model.dart';
import 'states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  bool securePass = true;
  String phoneNumber = "";
  String initialPhoneNumber = "+97412345678";
  final controllers = SignUpControllers();
  SignUpResp? signUpResp;

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      emit(SignUpLoadingState());
      try {
        final response = await Dio().post(UrlsStrings.signUpUrl,
            data: FormData.fromMap({
              "username": controllers.userNameController.text,
              "email": controllers.emailController.text,
              "phone": phoneNumber,
              "password": controllers.passwordController.text,
            }));
        if (response.statusCode == 200) {
          // CacheHelper.saveUserID("${response.data["userid"]}");
          // signUpResp = SignUpResp.fromJson(response.data);.

          emit(SignUpSuccessState());
          Map<String, dynamic> json = jsonDecode(response.data);
          signUpResp = json['data'];
          print(signUpResp!.userEmail);
        } else {
          emit(SignUpFailureState(msg: response.data["status"]));
        }
      } on DioError catch (e) {
        String errorMsg;
        if (e.type == DioErrorType.cancel) {
          errorMsg = 'Request was cancelled';
          emit(SignUpFailureState(msg: errorMsg));
        } else if (e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.sendTimeout) {
          errorMsg = 'Connection timed out';
          emit(NetworkErrorState());
        } else if (e.type == DioErrorType.badResponse) {
          errorMsg = 'Invalid status code: ${e.response!.statusMessage}';
          emit(SignUpFailureState(msg: errorMsg));
        } else {
          errorMsg = 'An unexpected error : ${e.error}';
          emit(NetworkErrorState());
        }
      } catch (e) {
        emit(SignUpFailureState(msg: 'An unknown error: $e'));
      }
    }
  }

  onInputChanged(PhoneNumber number) {
    phoneNumber = number.phoneNumber!;
    emit(ChangeNumberState());
  }

  passwordVisibility() {
    securePass = !securePass;
    emit(PasswordVisibilityState());
  }

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}

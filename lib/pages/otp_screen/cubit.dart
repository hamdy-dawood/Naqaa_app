import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'states.dart';

class OtpCubit extends Cubit<OtpStates> {
  OtpCubit() : super(OtpInitialState());

  static OtpCubit get(context) => BlocProvider.of(context);
  String randomNumber = '';
  final otpController = TextEditingController();

  void generateNumber() {
    randomNumber = (Random().nextInt(9000) + 1000).toString();
    emit(RandomNumberState());
    Fluttertoast.showToast(msg: "$randomNumber");
  }
}

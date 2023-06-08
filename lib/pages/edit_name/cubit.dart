import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/cache_helper.dart';

import 'states.dart';

class EditNameCubit extends Cubit<EditNameStates> {
  EditNameCubit() : super(EditNameInitialState());

  static EditNameCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  Future<void> editName() async {
    if (formKey.currentState!.validate()) {
      emit(EditNameLoadingState());
      try {
        final response = await Dio().post(UrlsStrings.editNameUrl,
            data: FormData.fromMap({
              "name": nameController.text,
              "userid": CacheHelper.getUserID(),
            }));
        if (response.statusCode == 200) {
          emit(EditNameSuccessState());
        } else {
          emit(EditNameFailureState(msg: response.data["status"]));
        }
      } on DioError catch (e) {
        String errorMsg;
        if (e.type == DioErrorType.cancel) {
          errorMsg = 'Request was cancelled';
          emit(EditNameFailureState(msg: errorMsg));
        } else if (e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.sendTimeout) {
          errorMsg = 'Connection timed out';
          emit(NetworkErrorState());
        } else if (e.type == DioErrorType.badResponse) {
          errorMsg = 'Invalid status code: ${e.response!.statusMessage}';
          emit(EditNameFailureState(msg: errorMsg));
        } else {
          errorMsg = 'An unexpected error : ${e.error}';
          emit(NetworkErrorState());
        }
      } catch (e) {
        emit(EditNameFailureState(msg: 'An unknown error: $e'));
      }
    }
  }
}

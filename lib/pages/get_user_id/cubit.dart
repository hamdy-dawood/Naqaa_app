import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/cache_helper.dart';

import 'states.dart';

class GetUserIDCubit extends Cubit<GetUserIDStates> {
  GetUserIDCubit() : super(GetUserIDInitialState());

  static GetUserIDCubit get(context) => BlocProvider.of(context);

  Future<void> getUserID({required String phone}) async {
    emit(GetUserIDLoadingState());
    try {
      final response = await Dio().post(UrlsStrings.getUserIdUrl,
          data: FormData.fromMap({
            "phone": phone,
          }));
      Map<String, dynamic> jsonData = jsonDecode(response.data);
      if (response.statusCode == 200) {
        emit(GetUserIDSuccessState());
        final userID = jsonData['data']['user_id'];
        CacheHelper.saveUserID("${userID}");
      } else {
        emit(GetUserIDFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(GetUserIDFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(NetworkErrorState());
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Invalid status code: ${e.response!.statusMessage}';
        emit(GetUserIDFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error : ${e.error}';
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(GetUserIDFailureState(msg: 'An unknown error: $e'));
    }
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/cache_helper.dart';

import 'model.dart';
import 'states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final dio = Dio();

  List<ProfileDataResp> profileData = [];

  Future<void> getProfileData() async {
    emit(ProfileLoadingState());
    try {
      final response = await dio.post(UrlsStrings.profileDateUrl,
          data: FormData.fromMap({
            "userid": CacheHelper.getUserID(),
          }));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.data);
        List<dynamic> data = json['data'];
        profileData =
            data.map((item) => ProfileDataResp.fromJson(item)).toList();
        emit(ProfileSuccessState());
      } else {
        emit(ProfileFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(ProfileFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(NetworkErrorState());
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(ProfileFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(ProfileFailureState(msg: 'An unknown error : $e'));
    }
  }
}

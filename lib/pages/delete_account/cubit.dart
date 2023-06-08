import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/cache_helper.dart';

import 'states.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountStates> {
  DeleteAccountCubit() : super(DeleteAccountInitialState());

  static DeleteAccountCubit get(context) => BlocProvider.of(context);

  final dio = Dio();

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoadingState());
    try {
      final response = await dio.post(UrlsStrings.deleteAccUrl,
          data: FormData.fromMap({
            "userid": CacheHelper.getUserID(),
          }));
      if (response.statusCode == 200) {
        emit(DeleteAccountSuccessState());
      } else {
        emit(DeleteAccountFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(DeleteAccountFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(DeleteNetworkErrorState());
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(DeleteAccountFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(DeleteNetworkErrorState());
      }
    } catch (e) {
      emit(DeleteAccountFailureState(msg: 'An unknown error : $e'));
    }
  }
}

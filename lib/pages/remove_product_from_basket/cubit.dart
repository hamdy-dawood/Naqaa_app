import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';

import 'states.dart';

class RemoveProductBasketCubit extends Cubit<RemoveProductBasketStates> {
  RemoveProductBasketCubit() : super(RemoveProductBasketInitialState());

  static RemoveProductBasketCubit get(context) => BlocProvider.of(context);

  final dio = Dio();

  Future<void> removeProduct({required String basketID}) async {
    emit(RemoveProductBasketLoadingState());
    try {
      final response = await dio.post(UrlsStrings.removeProductBasketUrl,
          data: FormData.fromMap({
            "basketid": basketID,
          }));
      if (response.statusCode == 200) {
        emit(RemoveProductBasketSuccessState());
      } else {
        emit(RemoveProductBasketFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(RemoveProductBasketFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(RemoveProductBasketFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(RemoveProductBasketFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(RemoveProductBasketFailureState(msg: errorMsg));
      }
    } catch (e) {
      emit(RemoveProductBasketFailureState(msg: 'An unknown error : $e'));
    }
  }
}

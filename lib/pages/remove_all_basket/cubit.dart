import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';

import 'states.dart';

class RemoveAllBasketCubit extends Cubit<RemoveAllBasketStates> {
  RemoveAllBasketCubit() : super(RemoveAllBasketInitialState());

  static RemoveAllBasketCubit get(context) => BlocProvider.of(context);

  final dio = Dio();

  Future<void> removeAllBasket() async {
    emit(RemoveAllBasketLoadingState());
    try {
      final response = await dio.post(UrlsStrings.removeAllBasketUrl,
          data: FormData.fromMap({
            "userid": "1",
          }));
      if (response.statusCode == 200) {
        emit(RemoveAllBasketSuccessState());
      } else {
        emit(RemoveAllBasketFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(RemoveAllBasketFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(RemoveAllBasketFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(RemoveAllBasketFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(RemoveAllBasketFailureState(msg: errorMsg));
      }
    } catch (e) {
      emit(RemoveAllBasketFailureState(msg: 'An unknown error : $e'));
    }
  }
}

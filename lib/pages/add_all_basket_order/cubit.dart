import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/cache_helper.dart';

import 'states.dart';

class AddAllBasketOrderCubit extends Cubit<AddAllBasketOrderStates> {
  AddAllBasketOrderCubit() : super(AddAllBasketOrderInitialState());

  static AddAllBasketOrderCubit get(context) => BlocProvider.of(context);
  final dio = Dio();

  Future<void> addAllBasketOrder({
    required String orderAddressType,
    required String lat,
    required String long,
  }) async {
    emit(AddAllBasketOrderLoadingState());
    try {
      final response = await dio.post(UrlsStrings.addAllBasketOrdersUrl,
          data: FormData.fromMap({
            "userid": CacheHelper.getUserID(),
            "orderAddressType": orderAddressType,
            "lat": lat,
            "long": long,
          }));
      if (response.statusCode == 200) {
        emit(AddAllBasketOrderSuccessState());
      } else {
        emit(AddAllBasketOrderFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(AddAllBasketOrderFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(AddAllBasketOrderFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(AddAllBasketOrderFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(AddAllBasketOrderFailureState(msg: errorMsg));
      }
    } catch (e) {
      emit(AddAllBasketOrderFailureState(msg: 'An unknown error : $e'));
    }
  }
}

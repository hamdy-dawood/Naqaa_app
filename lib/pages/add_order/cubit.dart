import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/cache_helper.dart';

import 'states.dart';

class AddOrderCubit extends Cubit<AddOrderStates> {
  AddOrderCubit() : super(AddOrderInitialState());

  static AddOrderCubit get(context) => BlocProvider.of(context);
  final dio = Dio();

  Future<void> addOrder({
    required String productID,
    required String quantity,
    required String basketId,
    required String orderAddressType,
    required String lat,
    required String long,
  }) async {
    emit(AddOrderLoadingState());
    try {
      final response = await dio.post(UrlsStrings.addOrdersUrl,
          data: FormData.fromMap({
            "userid": CacheHelper.getUserID(),
            "productid": productID,
            "quantity": quantity,
            "basketid": basketId,
            "orderAddressType": orderAddressType,
            "lat": lat,
            "long": long,
          }));
      if (response.statusCode == 200) {
        emit(AddOrderSuccessState());
      } else {
        emit(AddOrderFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(AddOrderFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(AddOrderFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(AddOrderFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(AddOrderFailureState(msg: errorMsg));
      }
    } catch (e) {
      emit(AddOrderFailureState(msg: 'An unknown error : $e'));
    }
  }
}

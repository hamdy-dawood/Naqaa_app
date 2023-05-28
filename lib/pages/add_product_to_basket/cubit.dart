import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';

import 'states.dart';

class AddProductBasketCubit extends Cubit<AddProductBasketStates> {
  AddProductBasketCubit() : super(AddProductBasketInitialState());

  static AddProductBasketCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  final quantityController = TextEditingController();

  Future<void> addProduct({required String productID}) async {
    emit(AddProductBasketLoadingState());
    try {
      final response = await dio.post(UrlsStrings.addProductBasketUrl,
          data: FormData.fromMap({
            "productid": productID,
            "userid": "1",
            "quantity": quantityController.text,
          }));
      if (response.statusCode == 200) {
        emit(AddProductBasketSuccessState());
      } else {
        emit(AddProductBasketFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(AddProductBasketFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(AddProductBasketFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(AddProductBasketFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(AddProductBasketFailureState(msg: errorMsg));
      }
    } catch (e) {
      emit(AddProductBasketFailureState(msg: 'An unknown error : $e'));
    }
  }
}

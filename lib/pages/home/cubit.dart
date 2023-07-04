import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';

import 'model.dart';

part 'states.dart';

class AllProductsCubit extends Cubit<AllProductsStates> {
  AllProductsCubit() : super(AllProductsInitialState());

  static AllProductsCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  List<AllProductsResp> products = [];

  Future<void> getAllProducts() async {
    emit(AllProductsLoadingState());
    try {
      final response = await dio.get(UrlsStrings.allProductsUrl);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.data);
        List<dynamic> data = json['data'];
        products = data.map((item) => AllProductsResp.fromJson(item)).toList();
        emit(AllProductsSuccessState());
      } else {
        emit(AllProductsFailedState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(AllProductsFailedState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(NetworkErrorState());
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(AllProductsFailedState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(AllProductsFailedState(msg: 'An unknown error : $e'));
    }
  }
}

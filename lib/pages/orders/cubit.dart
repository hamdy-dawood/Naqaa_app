import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/cache_helper.dart';

import 'model.dart';
import 'states.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersInitialState());

  static OrdersCubit get(context) => BlocProvider.of(context);
  final dio = Dio();
  List<OrdersResp> orders = [];

  Future<void> getOrders() async {
    emit(OrdersLoadingState());
    try {
      final response = await dio.post(UrlsStrings.ordersUrl,
          data: FormData.fromMap({
            "userid": CacheHelper.getUserID(),
          }));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.data);
        List<dynamic> data = json['data'];
        orders = data.map((item) => OrdersResp.fromJson(item)).toList();
        if (orders.isEmpty) {
          emit(OrdersSuccessWithNoDataState());
        } else {
          emit(OrdersSuccessState());
        }
      } else {
        emit(OrdersFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(OrdersFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(NetworkErrorState());
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(OrdersFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(OrdersFailureState(msg: 'An unknown error : $e'));
      print(e);
    }
  }
}
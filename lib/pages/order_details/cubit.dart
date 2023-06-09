import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';

import 'model.dart';
import 'states.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsStates> {
  OrderDetailsCubit() : super(OrderDetailsInitialState());

  static OrderDetailsCubit get(context) => BlocProvider.of(context);
  final dio = Dio();
  List<OrderDetailsResp> orderDetails = [];

  Future<void> getOrderDetails({required String ID}) async {
    emit(OrderDetailsLoadingState());
    try {
      final response = await dio.post(UrlsStrings.ordersUrl,
          data: FormData.fromMap({
            "ticket": ID,
          }));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.data);
        List<dynamic> data = json['data'];
        orderDetails =
            data.map((item) => OrderDetailsResp.fromJson(item)).toList();
        emit(OrderDetailsSuccessState());
      } else {
        emit(OrderDetailsFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(OrderDetailsFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(NetworkErrorState());
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(OrderDetailsFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(OrderDetailsFailureState(msg: 'An unknown error : $e'));
      print(e);
    }
  }
}

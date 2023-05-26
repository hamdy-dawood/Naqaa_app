import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';

import 'model.dart';
import 'states.dart';

class BasketCubit extends Cubit<BasketStates> {
  BasketCubit() : super(BasketInitialState());

  static BasketCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  List<BasketsResp> baskets = [];

  Future<void> getBaskets() async {
    emit(BasketLoadingState());
    try {
      final response = await dio.post(UrlsStrings.basketsUrl,
          data: FormData.fromMap({
            "userid": "1",
          }));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.data);
        List<dynamic> data = json['data'];
        baskets = data.map((item) => BasketsResp.fromJson(item)).toList();
        emit(BasketSuccessState());
      } else {
        emit(BasketFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(BasketFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(NetworkErrorState());
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(BasketFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(BasketFailureState(msg: 'An unknown error : $e'));
      print(e);
    }
  }
}

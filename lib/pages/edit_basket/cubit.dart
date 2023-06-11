import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/constants/strings.dart';

import 'states.dart';

class EditBasketCubit extends Cubit<EditBasketStates> {
  EditBasketCubit() : super(EditBasketInitialState());

  static EditBasketCubit get(context) => BlocProvider.of(context);

  final dio = Dio();

  Future<void> editQuantity(
      {required String ID, required String Quantity}) async {
    emit(EditBasketLoadingState());
    try {
      final response = await dio.post(UrlsStrings.editQuantityUrl,
          data: FormData.fromMap({
            "quantity": Quantity,
            "id": ID,
          }));
      if (response.statusCode == 200) {
        emit(EditBasketSuccessState());
      } else {
        emit(EditBasketFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(EditBasketFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(EditBasketFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(EditBasketFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(EditBasketFailureState(msg: errorMsg));
      }
    } catch (e) {
      emit(EditBasketFailureState(msg: 'An unknown error : $e'));
    }
  }
}

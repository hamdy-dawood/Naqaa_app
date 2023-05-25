import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class BasketCubit extends Cubit<BasketStates> {
  BasketCubit() : super(BasketInitialState());

  static BasketCubit get(context) => BlocProvider.of(context);
}

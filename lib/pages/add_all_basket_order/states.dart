abstract class AddAllBasketOrderStates {}

class AddAllBasketOrderInitialState extends AddAllBasketOrderStates {}

class AddAllBasketOrderLoadingState extends AddAllBasketOrderStates {}

class AddAllBasketOrderSuccessState extends AddAllBasketOrderStates {}

class AddAllBasketOrderFailureState extends AddAllBasketOrderStates {
  final String msg;

  AddAllBasketOrderFailureState({required this.msg});
}

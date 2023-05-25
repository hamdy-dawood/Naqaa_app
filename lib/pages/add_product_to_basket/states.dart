abstract class AddProductBasketStates {}

class AddProductBasketInitialState extends AddProductBasketStates {}

class AddProductBasketLoadingState extends AddProductBasketStates {}

class AddProductBasketSuccessState extends AddProductBasketStates {}

class AddProductBasketFailureState extends AddProductBasketStates {
  final String msg;

  AddProductBasketFailureState({required this.msg});
}

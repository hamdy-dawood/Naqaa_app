abstract class RemoveProductBasketStates {}

class RemoveProductBasketInitialState extends RemoveProductBasketStates {}

class RemoveProductBasketLoadingState extends RemoveProductBasketStates {}

class RemoveProductBasketSuccessState extends RemoveProductBasketStates {}

class RemoveProductBasketFailureState extends RemoveProductBasketStates {
  final String msg;

  RemoveProductBasketFailureState({required this.msg});
}

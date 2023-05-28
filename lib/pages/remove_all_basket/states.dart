abstract class RemoveAllBasketStates {}

class RemoveAllBasketInitialState extends RemoveAllBasketStates {}

class RemoveAllBasketLoadingState extends RemoveAllBasketStates {}

class RemoveAllBasketSuccessState extends RemoveAllBasketStates {}

class RemoveAllBasketFailureState extends RemoveAllBasketStates {
  final String msg;

  RemoveAllBasketFailureState({required this.msg});
}

abstract class BasketStates {}

class BasketInitialState extends BasketStates {}

class BasketLoadingState extends BasketStates {}

class BasketSuccessState extends BasketStates {}

class NetworkErrorState extends BasketStates {}

class BasketFailureState extends BasketStates {
  final String msg;

  BasketFailureState({required this.msg});
}

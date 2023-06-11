abstract class EditBasketStates {}

class EditBasketInitialState extends EditBasketStates {}

class EditBasketLoadingState extends EditBasketStates {}

class EditBasketSuccessState extends EditBasketStates {}

class EditBasketFailureState extends EditBasketStates {
  final String msg;

  EditBasketFailureState({required this.msg});
}

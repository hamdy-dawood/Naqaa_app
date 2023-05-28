abstract class AddOrderStates {}

class AddOrderInitialState extends AddOrderStates {}

class AddOrderLoadingState extends AddOrderStates {}

class AddOrderSuccessState extends AddOrderStates {}

class AddOrderFailureState extends AddOrderStates {
  final String msg;

  AddOrderFailureState({required this.msg});
}

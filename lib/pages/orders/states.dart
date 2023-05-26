abstract class OrdersStates {}

class OrdersInitialState extends OrdersStates {}

class OrdersLoadingState extends OrdersStates {}

class OrdersSuccessState extends OrdersStates {}

class OrdersSuccessWithNoDataState extends OrdersStates {}

class NetworkErrorState extends OrdersStates {}

class OrdersFailureState extends OrdersStates {
  final String msg;

  OrdersFailureState({required this.msg});
}

abstract class OrdersStates {}

class OrdersInitialState extends OrdersStates {}

class OrdersLoadingState extends OrdersStates {}

class OrdersSuccessState extends OrdersStates {}

class OrdersNetworkErrorState extends OrdersStates {}

class OrdersSuccessWithNoDataState extends OrdersStates {}

class OrdersFailureState extends OrdersStates {
  final String msg;

  OrdersFailureState({required this.msg});
}

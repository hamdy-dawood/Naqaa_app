abstract class OrderDetailsStates {}

class OrderDetailsInitialState extends OrderDetailsStates {}

class OrderDetailsLoadingState extends OrderDetailsStates {}

class OrderDetailsSuccessState extends OrderDetailsStates {}

class NetworkErrorState extends OrderDetailsStates {}

class OrderDetailsFailureState extends OrderDetailsStates {
  final String msg;

  OrderDetailsFailureState({required this.msg});
}

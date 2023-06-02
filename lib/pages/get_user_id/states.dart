abstract class GetUserIDStates {}

class GetUserIDInitialState extends GetUserIDStates {}

class GetUserIDLoadingState extends GetUserIDStates {}

class GetUserIDSuccessState extends GetUserIDStates {}

class GetUserIDFailureState extends GetUserIDStates {
  final String msg;

  GetUserIDFailureState({required this.msg});
}

class NetworkErrorState extends GetUserIDStates {}

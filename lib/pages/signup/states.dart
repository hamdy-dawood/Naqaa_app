abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {}

class SignUpFailureState extends SignUpStates {
  final String msg;

  SignUpFailureState({required this.msg});
}

class PasswordVisibilityState extends SignUpStates {}

class NetworkErrorState extends SignUpStates {}

class ChangeNumberState extends SignUpStates {}

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {}

class NetworkErrorState extends ProfileStates {}

class ProfileFailureState extends ProfileStates {
  final String msg;

  ProfileFailureState({required this.msg});
}

abstract class EditNameStates {}

class EditNameInitialState extends EditNameStates {}

class EditNameLoadingState extends EditNameStates {}

class EditNameSuccessState extends EditNameStates {}

class NetworkErrorState extends EditNameStates {}

class EditNameFailureState extends EditNameStates {
  final String msg;

  EditNameFailureState({required this.msg});
}

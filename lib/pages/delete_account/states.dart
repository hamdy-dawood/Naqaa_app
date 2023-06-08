abstract class DeleteAccountStates {}

class DeleteAccountInitialState extends DeleteAccountStates {}

class DeleteAccountLoadingState extends DeleteAccountStates {}

class DeleteAccountSuccessState extends DeleteAccountStates {}

class DeleteNetworkErrorState extends DeleteAccountStates {}

class DeleteAccountFailureState extends DeleteAccountStates {
  final String msg;

  DeleteAccountFailureState({required this.msg});
}

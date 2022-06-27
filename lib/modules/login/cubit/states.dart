
abstract class LogInStates {}

class InitialLogInStates extends LogInStates{}


class ChangePasswordVisibilityLogInState extends LogInStates{}

class LoadingLogInState extends LogInStates{}

class SuccessLogInState extends LogInStates{
  late final String uId;
  SuccessLogInState({required this.uId});
}

class ErrorLogInState extends LogInStates{
  final error;
  ErrorLogInState( this.error);
}

class GoogleLoadingLogInState extends LogInStates{}


class GoogleLoginSuccessState extends LogInStates{
  GoogleLoginSuccessState(String uid);
}


class GoogleLoginErrorState extends LogInStates{
  final error;
  GoogleLoginErrorState(this.error);
}
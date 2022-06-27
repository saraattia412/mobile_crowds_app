

abstract class SignUpStates {}

class InitialSignUpStates extends SignUpStates{}


class ChangePasswordVisibilitySignUpState extends SignUpStates{}

class LoadingSignUpStates extends SignUpStates{}


class SuccessCreateUserSignUpState extends SignUpStates{}


class CreateUserErrorSignUpState extends SignUpStates{
  final error;
  CreateUserErrorSignUpState( this.error);
}


class ErrorSignUpStates extends SignUpStates{
  final error;
  ErrorSignUpStates( this.error);
}


class GoogleLoadingSignUpStates extends SignUpStates{}


class GoogleSignUpSuccessState extends SignUpStates{
  GoogleSignUpSuccessState(uid);
}


class GoogleSignUpErrorState extends SignUpStates{
  final error;
  GoogleSignUpErrorState(this.error);
}
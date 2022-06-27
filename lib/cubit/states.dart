
abstract class CrowdStates{}

class InitialState extends CrowdStates{}

class GetUsersLoadingState extends CrowdStates{}


class GetUsersSuccessState extends CrowdStates{}

class GetUsersErrorState extends CrowdStates{
   final String error;
  GetUsersErrorState({required this.error});

}

class UploadImageState extends CrowdStates{}


class AppChangeBottomCheetState extends CrowdStates{}

class AppChangeDateScreen extends CrowdStates{}
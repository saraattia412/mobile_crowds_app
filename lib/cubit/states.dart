

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

class NewsGetItemLoadingState extends CrowdStates{}

class SuccessSaveDataState extends CrowdStates{}

class ErrorSaveDataState extends CrowdStates{
  ErrorSaveDataState(String string);
}

class GetSaveLoadingState extends CrowdStates{}


class GetSaveSuccessState extends CrowdStates{}

class GetSaveErrorState extends CrowdStates{
  late final String error;
  GetSaveErrorState( {required String error});
}

class GetUrlImageResultState extends CrowdStates{}

class ErrorGetUrlImageResultState extends CrowdStates{}


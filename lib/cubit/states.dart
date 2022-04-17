import 'package:shop_app/models/changeFave_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class AppHomeLoadingState extends AppStates {}

class AppGetHomeSuccessState extends AppStates {}

class AppGetHomeErrorState extends AppStates {
  final String error;
  AppGetHomeErrorState(this.error);
}

class AppGetCategoriesSuccessState extends AppStates {}

class AppGetCategoriesErrorState extends AppStates {
  final String error;
  AppGetCategoriesErrorState(this.error);
}

class AppChangeFavoritesState extends AppStates {}

class AppChangeFavoritesSuccessState extends AppStates {
  ChangeFavoriteModel? favoriteModel;
  AppChangeFavoritesSuccessState(this.favoriteModel);
}

class AppChangeFavoritesErrorState extends AppStates {
  final String error;
  AppChangeFavoritesErrorState(this.error);
}

class AppGetFavoritesLoadingState extends AppStates {}

class AppGetFavoritesSuccessState extends AppStates {}

class AppGetFavoritesErrorState extends AppStates {
  final String error;
  AppGetFavoritesErrorState(this.error);
}

class AppGetUserDataLoadingState extends AppStates {}

class AppGetUserDataSuccessState extends AppStates {}

class AppGetUserDataErrorState extends AppStates {
  final String error;
  AppGetUserDataErrorState(this.error);
}

class AppUpdateUserDataLoadingState extends AppStates {}

class AppUpdateUserDataSuccessState extends AppStates {}

class AppUpdateUserDataErrorState extends AppStates {
  final String error;
  AppUpdateUserDataErrorState(this.error);
}

class AppLogoutLoadingState extends AppStates {}

class AppLogoutSuccessState extends AppStates {}

class AppLogoutErrorState extends AppStates {
  final String error;
  AppLogoutErrorState(this.error);
}

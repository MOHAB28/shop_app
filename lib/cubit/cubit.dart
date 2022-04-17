import 'package:flutter/material.dart';
import 'package:shop_app/helpers/cache_helper.dart';
import 'package:shop_app/models/changeFave_model.dart';
import 'package:shop_app/models/fav_model.dart';
import 'package:shop_app/models/login_model.dart';
import '../screens/categories_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/products_screen.dart';
import '../screens/settings_screen.dart';

import './states.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../helpers/dio_helper.dart';
import '../constance/login.dart';
import '../models/products_model.dart';
import '../models/cat_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  HomeModel? products;
  Map<int?, bool?> favorties = {};

  var currentIndex = 0;
  List screens = <Widget>[
    HomeScreen(),
    CatScreen(),
    FavScreen(),
    SettingsScreen(),
  ];
  void changeBottomNavState(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  void getHomeData() {
    DioHelpers.getData(
      url: Home,
      token: token,
    ).then((value) {
      if (value.data != null) {
        products = HomeModel.formJson(value.data);
        products!.data!.products.forEach((element) {
          favorties.addAll({
            element.id: element.inFav,
          });
        });
        // print(favorties.toString());
        
        emit(AppGetHomeSuccessState());
        
      }
    }).catchError((error) {
      print('hi ${error.toString()}');
      AppGetHomeErrorState(error.toString());
    });
  }

  CategoriesModel? categoriesModel;

  void getCatData() {
    DioHelpers.getData(
      url: GET_CAT,
    ).then((value) {
      if (value.data != null) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        // print(categoriesModel!.status);
        
        emit(AppGetCategoriesSuccessState());
      }
    }).catchError((error) {
      print('hello ${error.toString()}');
      AppGetCategoriesErrorState(error.toString());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFav(int? id) {
    if (favorties[id] == false) {
      favorties[id] = true;
      emit(AppChangeFavoritesState());
    } else if (favorties[id] == true) {
      favorties[id] = false;
      emit(AppChangeFavoritesState());
    }
    DioHelpers.postData(
      url: FAVORITES,
      data: {
        'product_id': id,
      },
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (changeFavoriteModel!.status == false) {
        if (favorties[id] == true) {
          favorties[id] = false;
          emit(AppChangeFavoritesState());
        } else if (favorties[id] == false) {
          favorties[id] = true;
          emit(AppChangeFavoritesState());
        }
      } else {
        getFavorites();
      }
      emit(AppChangeFavoritesSuccessState(changeFavoriteModel));
    }).catchError((error) {
      if (favorties[id] == true) {
        favorties[id] = false;
        emit(AppChangeFavoritesState());
      } else if (favorties[id] == false) {
        favorties[id] = true;
        emit(AppChangeFavoritesState());
      }
      emit(AppChangeFavoritesErrorState(error));
    });
  }

  FavoriteModel? favoriteModel;
  void getFavorites() {
    emit(AppGetFavoritesLoadingState());
    DioHelpers.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      if (value.data != null) {
        favoriteModel = FavoriteModel.fromJson(value.data);
        if (favoriteModel != null) {
          emit(AppGetFavoritesSuccessState());
        } else {
          print('there is an error ${value.data}');
        }
      }
    }).catchError((error) {
      print('hello from get fav${error.toString()}');
      emit(AppGetFavoritesErrorState(error.toString()));
    });
  }

  LoginModel? loginModel;
  void getUserData() {
    emit(AppGetUserDataLoadingState());
    DioHelpers.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print('User Name is ${loginModel!.data!.name}');
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      print('hello from get userData ${error.toString()}');
      emit(AppGetUserDataErrorState(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(AppUpdateUserDataLoadingState());
    DioHelpers.putData(
      url: UPDATE_PROFILE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      token: token,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(AppUpdateUserDataSuccessState());
    }).catchError((error) {
      emit(AppUpdateUserDataErrorState(error));
    });
  }

  Future<void> logout() async {
    emit(AppLogoutLoadingState());
    CacheHelper.removeData(key: 'token').then((value) {
      emit(AppLogoutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppLogoutErrorState(error.toString()));
    });
  }
}

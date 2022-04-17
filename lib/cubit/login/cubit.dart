import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constance/login.dart';
import 'package:shop_app/helpers/dio_helper.dart';
import 'package:shop_app/models/login_model.dart';
import './states.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialState());
  static AppLoginCubit get(context) => BlocProvider.of(context);
  late LoginModel loginModel;
  void login({
    required String email,
    required String password,

  }) {
    
    emit(AppLoginLoadingState());
    DioHelpers.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.message);
      print(loginModel.data!.name);
      
      emit(AppLoginSuccessState(loginModel));
    }).catchError((error) {
      print('hii from login cubit ${error.toString()}');
      emit(AppLoginErrorState(error.toString()));
    });
  }

  

  var isVisible = true;
  late IconData visibile = Icons.visibility_outlined;
  void changeVisibleState() {
    isVisible = !isVisible;
    visibile =
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppLoginVisibleState());
  }
}

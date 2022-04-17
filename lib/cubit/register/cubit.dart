import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constance/login.dart';
import 'package:shop_app/cubit/register/states.dart';
import 'package:shop_app/helpers/dio_helper.dart';
import 'package:shop_app/models/login_model.dart';

class AppRegisterCubit extends Cubit<AppRegisterStates> {
  AppRegisterCubit() : super(AppRegisterInitialState());
  static AppRegisterCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  void register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(AppRegisterLoadingState());
    DioHelpers.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.message);
      emit(AppRegisterSuccessState(loginModel!));
    }).catchError((error) {
      print('hii ${error.toString()}');
      emit(AppRegisterErrorState(error.toString()));
    });
  }

  var isVisible = true;
  late IconData visibile = Icons.visibility_outlined;
  void changeVisibleState() {
    isVisible = !isVisible;
    visibile =
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppRegisterVisibleState());
  }
}

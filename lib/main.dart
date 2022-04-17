import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './layout/shop_layout.dart';
import './screens/login.dart';
import './cubit/bloc_observer.dart';
import './helpers/cache_helper.dart';
import './constance/theme.dart';
import './screens/onboarding.dart';
import './cubit/cubit.dart';
import './cubit/states.dart';
import './helpers/dio_helper.dart';
import './constance/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelpers.init();
  await CacheHelper.init();

  bool? onBoarding = CacheHelper.getBoolean(key: 'onBoarding');
  token = CacheHelper.getString(key: 'token');
  Widget? widget;
  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoarding();
  }
  runApp(MyApp(
    startingWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startingWidget;
  MyApp({
    this.startingWidget,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getHomeData()
        ..getCatData()
        ..getFavorites()
        ..getUserData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightMode,
            home: startingWidget,
          );
        },
      ),
    );
  }
}

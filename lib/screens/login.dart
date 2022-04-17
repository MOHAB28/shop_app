import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constance/color.dart';
import 'package:shop_app/constance/login.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/helpers/cache_helper.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/screens/register.dart';
import '../cubit/login/states.dart';
import '../cubit/login/cubit.dart';

class LoginScreen extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  late var _emailController = TextEditingController();
  late var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginStates>(
        listener: (context, states) {
          if (states is AppLoginSuccessState) {
            AppCubit.get(context).getUserData();
            if (states.loginModel.status) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${states.loginModel.message}'),
                backgroundColor: Theme.of(context).primaryColor,
              ));
              CacheHelper.setString(
                key: 'token',
                value: states.loginModel.data!.token,
              ).then((value) {
                if (value) {
                  
                  token = states.loginModel.data!.token;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopLayout(),
                    ),
                  );
                }
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${states.loginModel.message}'),
                backgroundColor: Theme.of(context).errorColor,
              ));
            }
          }
        },
        builder: (context, states) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: _formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please, Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: AppLoginCubit.get(context).isVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                AppLoginCubit.get(context).changeVisibleState();
                              },
                              icon: Icon(
                                AppLoginCubit.get(context).visibile,
                              ),
                            ),
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter a password';
                            }
                            return null;
                          },
                          onFieldSubmitted: (val) {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              AppLoginCubit.get(context).login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        states is AppLoginLoadingState
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    AppLoginCubit.get(context).login(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  color: Theme.of(context).primaryColor,
                                  child: Center(
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            TextButton(
                             onPressed: (){
                               Navigator.pushReplacement(context, 
                               MaterialPageRoute(
                                 builder: (context) => RegisterScreen()
                               ),
                               );
                             },
                             child: Text(
                               'REGISTER',
                               style: TextStyle(
                                 color: defualtColor,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

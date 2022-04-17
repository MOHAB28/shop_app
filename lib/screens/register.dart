import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constance/color.dart';
import 'package:shop_app/constance/login.dart';
import 'package:shop_app/cubit/register/cubit.dart';
import 'package:shop_app/cubit/register/states.dart';
import 'package:shop_app/helpers/cache_helper.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/screens/login.dart';

class RegisterScreen extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  late var _emailController = TextEditingController();
  late var _passwordController = TextEditingController();
  late var _nameController = TextEditingController();
  late var _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit, AppRegisterStates>(
        listener: (context, states) {
          if (states is AppRegisterSuccessState) {
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
                          'REGISTER',
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
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Your name';
                            } else if (value.length <= 4) {
                              return 'The name must be greater than 4 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
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
                          textInputAction: TextInputAction.next,
                          controller: _passwordController,
                          obscureText: AppRegisterCubit.get(context).isVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                AppRegisterCubit.get(context)
                                    .changeVisibleState();
                              },
                              icon: Icon(
                                AppRegisterCubit.get(context).visibile,
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
                          
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _phoneController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Your phone number';
                            } else if (value.length != 11) {
                              return 'Please enter a real phone number';
                            }
                            return null;
                          },
                          onFieldSubmitted: (val) {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              AppRegisterCubit.get(context).register(
                                email: _emailController.text,
                                password: _passwordController.text,
                                name: _nameController.text,
                                phone: _phoneController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        states is AppRegisterLoadingState
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    AppRegisterCubit.get(context).register(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      name: _nameController.text,
                                      phone: _phoneController.text,
                                    );
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  color: Theme.of(context).primaryColor,
                                  child: Center(
                                    child: Text(
                                      'REGISTER',
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
                                 builder: (context) => LoginScreen()
                               ),
                               );
                             },
                             child: Text(
                               'LOGIN',
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

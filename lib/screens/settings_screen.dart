import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constance/color.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/screens/login.dart';

class SettingsScreen extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();

  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context).loginModel;
        _nameController.text = cubit!.data!.name!;
        _emailController.text = cubit.data!.email!;
        _phoneController.text = cubit.data!.phone!;
        print(cubit.data!.name!);
        return AppCubit.get(context).loginModel != null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (state is AppUpdateUserDataLoadingState)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: LinearProgressIndicator(),
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
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
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
                              return 'Please enter Your email';
                            } else if (!value.contains('@')) {
                              return 'Please Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
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
                            } else if (value.length < 11) {
                              return 'The name must be 11 numbers';
                            }
                            return null;
                          },
                        ),
                        SettingsButton(
                          title: 'Update',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              AppCubit.get(context).updateUserData(
                                email: _emailController.text,
                                name: _nameController.text,
                                phone: _phoneController.text,
                              );
                            }
                          },
                        ),
                        SettingsButton(
                          title: 'Logout',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              AppCubit.get(context).logout().then((value) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ));
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    required this.onPressed,
    required this.title,
  });
  final Function() onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 60,
        margin: const EdgeInsets.only(
          top: 20.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: defualtColor,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

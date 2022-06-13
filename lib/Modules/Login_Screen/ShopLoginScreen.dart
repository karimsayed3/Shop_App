import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Layout/Shop_App/Shop_Layout.dart';
import 'package:untitled3/Modules/Shop_App/Login_Screen/Cubit/LoginCubit.dart';
import 'package:untitled3/Modules/Shop_App/Login_Screen/Cubit/LoginStates.dart';
import 'package:untitled3/Modules/Shop_App/Register_Screen/ShopRegisterScreen.dart';
import 'package:untitled3/components.dart';
import 'package:untitled3/remote/dio/casheHelper.dart';


class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if (state is ShopLoginSuccessState) {
              if (state.loginModel.status == true) {
                cacheHelper.saveData(
                  key: 'token',
                  value: '${state.loginModel.data.token}',
                ).then((value) {
                  token = state.loginModel.data.token;
                  toast(
                    msg: '${state.loginModel.message}',
                    state: ToastState.SUCCESS,
                  );
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ShopLayout()),
                      (route) => false);
                });
              } else {
                toast(
                  msg: '${state.loginModel.message}',
                  state: ToastState.ERROR,
                );
                print(state.loginModel.message);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Login Screen'),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Login now and enjoy our Offers',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: Colors.blueGrey),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          defaultFormField(
                            conntroller: usernameController,
                            type: TextInputType.text,
                            label: 'enter username',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Email Addresses';
                              }
                              return null;
                            },
                            prefix: Icons.email,
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          defaultFormField(
                              conntroller: passwordController,
                              type: TextInputType.visiblePassword,
                              isPassword: ShopLoginCubit.get(context).isShow,
                              label: 'password',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password is too short';
                                }
                                return null;
                              },
                              prefix: Icons.lock_outline,
                              suffix: ShopLoginCubit.get(context).suffix,
                              suffixPressed: () {
                                ShopLoginCubit.get(context).changeVisibility();
                              }),
                          SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) => defaultButton(
                              press: () {
                                if (formKey.currentState.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: usernameController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'login',
                              radius: 10.0,
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\`t have account?',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              defaultTextButton(
                                text: 'Register Now',
                                function: () {
                                  Navegato(context, ShopRegisterScreen());
                                },
                              )
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
        ));
  }
}

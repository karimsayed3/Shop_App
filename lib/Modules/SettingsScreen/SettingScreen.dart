import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Layout/Shop_App/cubit/Shop_Layout_Cubit.dart';
import 'package:untitled3/Layout/Shop_App/states/Shop_Layout_States.dart';

import '../../../components.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context).model;
        usernameController.text = cubit.data.name;
        phoneController.text = cubit.data.phone;
        emailController.text = cubit.data.email;
        // if(state is ShopRegisterSuccessState){
        //   usernameController.text = state.RegisterModel.data.name;
        //   phoneController.text = state.RegisterModel.data.phone;
        //   emailController.text = state.RegisterModel.data.email;
        // }
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).model != null,
          builder: (context) => SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(state is ShopUpdateUserLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20.0,
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
                        height: 20.0,
                      ),
                      defaultFormField(
                        conntroller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Email',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Email Addresses';
                          }
                          return null;
                        },
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        conntroller: phoneController,
                        type: TextInputType.phone,
                        label: 'Phone',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Telephone number';
                          }
                          return null;
                        },
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) =>defaultButton(
                          press: () {
                            if (formKey.currentState.validate()) {
                              ShopLayoutCubit.get(context)
                                  .updateUserDate(
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  name: usernameController.text);
                            }
                          },
                          text: 'Update',
                          radius: 10.0,
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),

                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        press: () {
                          SignOut(context);
                        },
                        text: 'Sign Out',
                        radius: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

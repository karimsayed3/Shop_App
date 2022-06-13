import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Modules/Shop_App/Register_Screen/Cubit/RegisterStates.dart';
import 'package:untitled3/models/Shop_App/Login_Model.dart';
import 'package:untitled3/remote/dio/dio.helper.dart';
import 'package:untitled3/remote/end_points.dart';



class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterrInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel model;

  void Register({
    @required String email,
    @required String phone,
    @required String name,
    @required String password,
  }) {
    emit(ShopRegisterrLoadingState());
    Diohelper.postData(
      url: REGISTER,
      query: {
        'name':name,
        'phone':phone,
        'email':email,
        'password':password
      }
    ).then((value) {
      print(value.data);
      model = ShopLoginModel?.fromJson(value.data);
      emit(ShopRegisterrSuccessState(model));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterrErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility_off_outlined;
  bool isShow = true;
  void changeVisibility(){
    isShow = !isShow;
    suffix = isShow?   Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterrChangeVisibilityState());
  }
}

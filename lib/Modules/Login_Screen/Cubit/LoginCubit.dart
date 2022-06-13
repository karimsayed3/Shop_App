
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Modules/Shop_App/Login_Screen/Cubit/LoginStates.dart';
import 'package:untitled3/models/Shop_App/Login_Model.dart';
import 'package:untitled3/remote/dio/dio.helper.dart';
import 'package:untitled3/remote/end_points.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

   ShopLoginModel model;

  void userLogin(
  {
  @required String email,
    @required String password,
}
      ){
    emit(ShopLoginLoadingState());
    Diohelper.postData(
        url: Login,
        data:{
          'email':email,
          'password':password,
        },
        ).then((value) {
          print(value.data);
          model=ShopLoginModel?.fromJson(value.data);
          emit(ShopLoginSuccessState(model));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
    }

    IconData suffix = Icons.visibility_off_outlined;
    bool isShow = true;
  void changeVisibility(){
    isShow = !isShow;
    suffix = isShow?   Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginChangeVisibilityState());
  }

  }

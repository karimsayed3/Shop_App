import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Layout/Shop_App/states/Shop_Layout_States.dart';
import 'package:untitled3/Modules/Shop_App/CategoriesScreen/CategoriesScreen.dart';
import 'package:untitled3/Modules/Shop_App/FavouriteScreen/FavouriteScreen.dart';
import 'package:untitled3/Modules/Shop_App/ProductScreen/ProductScreen.dart';
import 'package:untitled3/Modules/Shop_App/SettingsScreen/SettingScreen.dart';
import 'package:untitled3/models/Shop_App/Categories_Model.dart';
import 'package:untitled3/models/Shop_App/Favourite_Model.dart';
import 'package:untitled3/models/Shop_App/Favourite_model_data.dart';
import 'package:untitled3/models/Shop_App/Home_Model.dart';
import 'package:untitled3/models/Shop_App/Login_Model.dart';
import 'package:untitled3/remote/dio/dio.helper.dart';
import 'package:untitled3/remote/end_points.dart';

import '../../../components.dart';


class ShopLayoutCubit extends Cubit<ShopLayoutStates>{
  ShopLayoutCubit() : super(ShopLayoutInitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> pages = [
    ProductScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;

  void changePage(index){
    currentIndex = index;
    emit(ShopLayoutChangeNaveBarState());
  }

  HomeModel homeModel;

 dynamic favourite = {};

  void getHomeData(){
    emit(ShopLayoutLoadingState());
    Diohelper.getdata(url: HOME,token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel!.data!.products[0]['image']);
      homeModel.data.products.forEach((element) {
        favourite.addAll(
          {
          element['id'] : element['in_favorites']
          }
        );
      });
      // print(favourite.toString());

      emit(ShopLayoutSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopLayoutErrorState(error.toString()));
    });
  }

  CategoryModel categoryModel;

  void getCategoryData(){
    Diohelper.getdata(url: CATEGORY).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      // print(categoryModel!.data!.data[0]['id']);
      emit(ShopCategorySuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopCategoryErrorState(error.toString()));
    });
  }

  ChangeFavouriteModel changeFavouriteModel;

  void changeFavourite(int product_id)
  {
    favourite[product_id] = !favourite[product_id];
    emit(ShopChangeSuccessState());

    Diohelper.postData(url: FAVOURITE,token:token,data: {
      'product_id' : product_id
    }).then((value) {
      changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
      print(value.data);


      if(!changeFavouriteModel.status){
        favourite[product_id] = !favourite[product_id];
      }else{
        favouritePageData();
      }
      emit(ShopFavouriteSuccessState(changeFavouriteModel));
    }).catchError((onError){
      emit(ShopFavouriteErrorState());
      favourite[product_id] = !favourite[product_id];
    });
  }


  FavouritesModel favouriteModel;
  void favouritePageData()
  {
    emit(ShopFavouriteModelLoadingState());
    Diohelper.getdata(
      url : FAVOURITE,
      token : token,
    ).then((value) {
      favouriteModel = FavouritesModel.fromJson(value.data);
      // print(favouriteModel!.data!.data[1]['product']['name']);
      emit(ShopFavouriteModelSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(ShopFavouriteModelErrorState());
    });
  }

  ShopLoginModel model;

  void userRegister()
  {
    emit(ShopRegisterLoadingState());
    Diohelper.getdata(
      url: PROFILE,
      token: token,
    ).then((value) {
      model = ShopLoginModel.fromJson(value.data);
      print(model.data.name);
      emit(ShopRegisterSuccessState(model));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }


   Future<void> updateUserDate(
  {
  @required String name,
  @required String email,
  @required String phone,
}
      )async
   {
    emit(ShopUpdateUserLoadingState());
    Diohelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value) {
      model = ShopLoginModel.fromJson(value.data);
      print(model.data.name);
      emit(ShopUpdateUserSuccessState(model));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateUserErrorState(error.toString()));
    });
  }


}
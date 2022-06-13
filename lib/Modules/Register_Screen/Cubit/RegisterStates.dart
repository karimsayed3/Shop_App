

import 'package:untitled3/models/Shop_App/Login_Model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterrInitialState extends ShopRegisterStates{}

class ShopRegisterrLoadingState extends ShopRegisterStates{}
class ShopRegisterrSuccessState extends ShopRegisterStates{
  final ShopLoginModel RegisterModel;

  ShopRegisterrSuccessState(this.RegisterModel);

}
class ShopRegisterrErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterrErrorState(this.error);

}

class ShopRegisterrChangeVisibilityState extends ShopRegisterStates{}


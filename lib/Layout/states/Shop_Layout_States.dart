

import 'package:untitled3/models/Shop_App/Favourite_Model.dart';
import 'package:untitled3/models/Shop_App/Login_Model.dart';

abstract class ShopLayoutStates{}
class ShopLayoutInitialState extends ShopLayoutStates{}

class ShopLayoutChangeNaveBarState extends ShopLayoutStates{}
class ShopLayoutLoadingState extends ShopLayoutStates{}
class ShopLayoutSuccessState extends ShopLayoutStates{}
class ShopLayoutErrorState extends ShopLayoutStates{
  final String error;

  ShopLayoutErrorState(this.error);
}
class ShopCategorySuccessState extends ShopLayoutStates{}
class ShopCategoryErrorState extends ShopLayoutStates{
  final String error;

  ShopCategoryErrorState(this.error);
}
class ShopFavouriteSuccessState extends ShopLayoutStates{
  final ChangeFavouriteModel model;

  ShopFavouriteSuccessState(this.model);

}
class ShopChangeSuccessState extends ShopLayoutStates{
}
class ShopFavouriteErrorState extends ShopLayoutStates{
}

class ShopFavouriteModelSuccessState extends ShopLayoutStates{
}
class ShopFavouriteModelLoadingState extends ShopLayoutStates{
}
class ShopFavouriteModelErrorState extends ShopLayoutStates{
}
class ShopRegisterLoadingState extends ShopLayoutStates{}
class ShopRegisterSuccessState extends ShopLayoutStates{
  final ShopLoginModel RegisterModel;

  ShopRegisterSuccessState(this.RegisterModel);
}
class ShopRegisterErrorState extends ShopLayoutStates{
  final String error;
  ShopRegisterErrorState(this.error);

}
class ShopUpdateUserLoadingState extends ShopLayoutStates{}
class ShopUpdateUserSuccessState extends ShopLayoutStates{
  final ShopLoginModel RegisterModel;
  ShopUpdateUserSuccessState(this.RegisterModel);

}
class ShopUpdateUserErrorState extends ShopLayoutStates{
  final String error;
  ShopUpdateUserErrorState(this.error);

}

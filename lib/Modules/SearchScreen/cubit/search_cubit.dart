import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Modules/Shop_App/SearchScreen/cubit/search_states.dart';
import 'package:untitled3/models/Shop_App/Search_Model.dart';
import 'package:untitled3/remote/dio/dio.helper.dart';
import 'package:untitled3/remote/end_points.dart';


import '../../../../components.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchmodel;

  void search({@required String text}){
    emit(SearchLoadingState());
    Diohelper.postData(url: SEARCH,token: token,data: {'text':text}).then((value) {

      searchmodel = SearchModel.fromJson(value.data);
      print(searchmodel.data.currentPage);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
    });
  }

}
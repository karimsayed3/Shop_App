import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Modules/Shop_App/FavouriteScreen/FavouriteScreen.dart';
import 'package:untitled3/Modules/Shop_App/SearchScreen/cubit/search_cubit.dart';
import 'package:untitled3/Modules/Shop_App/SearchScreen/cubit/search_states.dart';
import 'package:untitled3/components.dart';

class SearchScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            // var model = SearchCubit.get(context).searchmodel.data.data;
            return Scaffold(
                appBar: AppBar(),
                body: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        defaultFormField(
                          conntroller: searchController,
                          type: TextInputType.text,
                          label: 'search',
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please Enter what you want to search';
                            }
                            return null;
                          },
                          prefix: Icons.search,
                          onSubmit: (String text){
                            SearchCubit.get(context).search(text: text);
                          }
                        ),
                        SizedBox(height: 10.0,),
                        if(state is SearchLoadingState)
                          LinearProgressIndicator(),
                        SizedBox(height: 5.0,),
                        if(state is SearchSuccessState)
                          Expanded(
                          child: ListView.separated(
                            itemBuilder: (context,index)=> favouriteItemBuilder(SearchCubit.get(context).searchmodel.data.data[index],context,isOldPrice: false),
                            separatorBuilder: (context,index)=>Container(
                              height: 2.0,
                              width: double.infinity,
                              color: Colors.black,
                            ),
                            itemCount: SearchCubit.get(context).searchmodel.data.data.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            );
          },
        ));
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Layout/Shop_App/cubit/Shop_Layout_Cubit.dart';
import 'package:untitled3/Layout/Shop_App/states/Shop_Layout_States.dart';

class FavouriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          var model = ShopLayoutCubit.get(context).favouriteModel.data.data;
          return  ConditionalBuilder(
            condition: state is! ShopFavouriteModelLoadingState,
            builder: (context) =>ListView.separated(
              itemBuilder: (context,index)=>favouriteItemBuilder(model[index]['product'],context),
              separatorBuilder: (context,index)=>Container(
                height: 2.0,
                width: double.infinity,
                color: Colors.black,
              ),
              itemCount: model.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
    );
  }

}

Widget favouriteItemBuilder(model,context,{bool isOldPrice = true}){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model['image']),
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
              ),
              if (model['discount'] != 0 && isOldPrice)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'Discount',
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model['name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.1,
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Text(
                      '${model['price']}',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model['discount'] != 0 && isOldPrice)
                      Text(
                        '${model['old_price']}',
                        style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopLayoutCubit.get(context).changeFavourite(model['id']);
                        ShopLayoutCubit.get(context).favouritePageData();
                      },
                      icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopLayoutCubit.get(context).favourite[model['id']] ? Colors.blue : Colors.grey,
                          child: Icon(
                            Icons.favorite_border_outlined,
                            size: 20.0,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

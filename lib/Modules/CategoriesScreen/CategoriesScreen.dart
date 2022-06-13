import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Layout/Shop_App/cubit/Shop_Layout_Cubit.dart';
import 'package:untitled3/Layout/Shop_App/states/Shop_Layout_States.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return Scaffold(
          body: ListView.separated(
            itemBuilder: (context, index) =>
                builditem(cubit.categoryModel.data.data[index]),
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 10.0,
            ),
            itemCount: cubit.categoryModel.data.data.length,
          ),
        );
      },
    );
  }

  Widget builditem(category) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
          children: [
            Image(
              image: NetworkImage(category['image']),
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
                category['name'],
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward)
              ],
        ),
  );
}

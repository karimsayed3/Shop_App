import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:untitled3/Layout/Shop_App/cubit/Shop_Layout_Cubit.dart';
import 'package:untitled3/Layout/Shop_App/states/Shop_Layout_States.dart';


import '../../../components.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if(state is ShopFavouriteSuccessState){
          if(!state.model.status){
            toast(
              msg: "${state.model.message}",
              state: ToastState.ERROR
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoryModel != null,
            builder: (context) =>
                ProductItemBuilder(cubit.homeModel, cubit.categoryModel,context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget ProductItemBuilder(model, category,context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners.map<Widget>((e) {
                return Image(
                  image: NetworkImage('${e['image']}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }).toList(),
              options: CarouselOptions(
                viewportFraction: 1.0,
                height: 200.0,
                initialPage: 0,
                pauseAutoPlayInFiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Categories',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 150.0,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    buildCategoryItem(category.data.data[index]),
                separatorBuilder: (context, index) => Container(
                  width: 10.0,
                ),
                itemCount: category.data.data.length,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'New Products',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.49,
                children: List.generate(
                  model.data.products.length,
                  (index) => buildGridProduct(model.data.products[index],context),
                ),
              ),
            )
          ],
        ),
      );

  Widget buildGridProduct(model,context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model['image']),
                  width: double.infinity,
                  height: 160.0,
                ),
                if (model['discount'] != 0)
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
            Padding(
              padding: const EdgeInsets.all(12.0),
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
                      if (model['discount'] != 0)
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
      );

  Widget buildCategoryItem(category) =>
      Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image(
            image: NetworkImage(category['image']),
            height: 150.0,
            width: 150.0,
            fit: BoxFit.cover,
          ),
          Container(
            width: 150.0,
            color: Colors.black.withOpacity(.7),
            child: Text(
              category['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}

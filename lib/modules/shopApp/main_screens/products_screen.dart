// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/layout/shope_home/cubit/cubit.dart';
import 'package:shop/layout/shope_home/cubit/states.dart';
import 'package:shop/model/shop_models/home/home_model.dart';
import 'package:shop/share/styles/icons_broken.dart';

// ignore: use_key_in_widget_constructors
class ProductsScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).product!=null && ShopCubit.get(context).categories!=null,
            builder: (BuildContext context) =>Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CarouselSlider(
                      items: ShopCubit.get(context).product!.data!.banners!
                          .map(
                            (e) => Image(
                          image: NetworkImage('${e!.image}'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                          .toList(),
                      options: CarouselOptions(
                        height: 170,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(seconds: 3),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(height: 10,),
                    GridView.count(
                      crossAxisCount: 2,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                      childAspectRatio: 1/1.7,
                      children: List.generate(
                          ShopCubit.get(context).product!.data!.products!.length,
                              (index) => GridItemBuilder(ShopCubit.get(context).product!.data!.products![index], context, index)),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),
          )
        );
      },
    );
  }

}
Widget GridItemBuilder(Products? model,context,index)=>Container(
  padding: EdgeInsetsDirectional.all(10),
  child:   Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(image: NetworkImage('${model!.image}'),height: 120,),
          ),
          if(model.discount!=0)
            Container(
              height: 14,
            width: 69,
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text('Discount ${model!.discount}%',style: TextStyle(color: Colors.white,fontSize: 8,wordSpacing: .1),),
            ),
          ),
        ],
      ),
      SizedBox(height: 14,),
      Text('${model!.name}',maxLines: 2,style:Theme.of(context).textTheme.headline1!.copyWith(height: 1,fontSize: 14,),overflow: TextOverflow.ellipsis,),
      SizedBox(height: 5,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${model!.price}\$',
            maxLines: 2,
            style:Theme.of(context).textTheme.headline1!.copyWith(fontSize: 12,),),
          if(model.discount!=0)
            SizedBox(width: 5,),
          if(model.discount!=0)
            Text(
                '${model!.old_price}\$',
                maxLines: 2,
                style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 10,decoration: TextDecoration.lineThrough,)
            ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Row(
          children: [
            IconButton(
              onPressed: (){
                ShopCubit.get(context).ChangeCart(model!.id);
              },
              icon: Icon(IconBroken.Buy),
              padding: EdgeInsetsDirectional.zero,
              color:ShopCubit.get(context).inCart[model!.id]==true?Colors.blue:Colors.grey ,),
            Spacer(),
            IconButton(
              onPressed: (){
                ShopCubit.get(context).ChangeFavorite(model!.id);
              },
              icon: Icon(
                IconBroken.Heart,
                color: ShopCubit.get(context).isFavorite[model!.id]==true?Colors.red:Colors.grey,
              ),
              padding: EdgeInsetsDirectional.zero,
            ),
          ],
        ),
      )
    ],
  ),
);
Widget CarouseltemBuilder(HomeModel? model,context,index)=>CarouselSlider(
  items: model!.data!.banners!
      .map(
        (e) => Image(
      image: NetworkImage('${e!.image}'),
      fit: BoxFit.cover,
      width: double.infinity,
    ),
  )
      .toList(),
  options: CarouselOptions(
    height: 200,
    viewportFraction: 1.0,
    enlargeCenterPage: false,
    initialPage: 0,
    enableInfiniteScroll: true,
    reverse: false,
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 3),
    autoPlayAnimationDuration: Duration(seconds: 1),
    autoPlayCurve: Curves.fastOutSlowIn,
    scrollDirection: Axis.horizontal,
  ),
);
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shope_home/cubit/cubit.dart';
import 'package:shop/layout/shope_home/cubit/states.dart';
import 'package:shop/share/styles/icons_broken.dart';

import '../../../model/shop_models/favorites/favorites_model.dart';

// ignore: use_key_in_widget_constructors
class FavoriteScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body:ConditionalBuilder(
            condition: ShopCubit.get(context).favoritesProducts != null,
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: 110,
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Total Favorites : ',style: TextStyle(color: Colors.white,fontSize: 8),),
                        SizedBox(width: 1,),
                        Text('${ShopCubit.get(context).favoritesProducts!.data!.total}',style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white,fontSize: 8,height: 0),),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => FavoritesProductsItemBuilder(ShopCubit.get(context).favoritesProducts!.data!.data![index].product,context,index),
                      separatorBuilder: (context, index) => Container(height: 1,width: double.infinity,color: Colors.grey,),
                      itemCount: ShopCubit.get(context).favoritesProducts!.data!.data!.length
                  ),
                ),
              ],
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

}
Widget FavoritesProductsItemBuilder(FavoriteProductsModel? model,context,index)=>InkWell(
  onTap: () {
  },
  child:   Padding(
    padding: const EdgeInsets.only(bottom: 25,top: 10,left: 10,right: 10),
    child:   Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 100,
            width: 100,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration:BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(10)
            ),
            child: Image(image: NetworkImage('${model!.image}'),)
        ),
        SizedBox(width: 15,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0,left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model.name}',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 17,fontWeight: FontWeight.bold,height: 1.2),maxLines: 2,overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10,),
                Text('${model.description}',style: Theme.of(context).textTheme.caption!.copyWith(height: 1,fontSize: 10,overflow: TextOverflow.ellipsis,color: Colors.grey),maxLines: 2,),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('${model.price} \$',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 12,fontWeight: FontWeight.bold)),
                    SizedBox(width: 5,),
                    if(model!.discount!=0)
                      Text('${model.discount}%',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 10,decoration: TextDecoration.lineThrough),),
                  ],
                ),
              ],
            ),
          ),
        ),

      ],
    ),
  ),
);
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shope_home/cubit/cubit.dart';
import 'package:shop/layout/shope_home/cubit/states.dart';
import 'package:shop/model/shop_models/search/search_model.dart';
import 'package:shop/share/styles/icons_broken.dart';

// ignore: use_key_in_widget_constructors
class SearchScreen extends StatelessWidget{
var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  onTap: () {
                  },
                  onChanged: (value) {
                    ShopCubit.get(context).Search(searchController.text);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'search',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: IconButton(
                            iconSize: 20,
                            onPressed: () {

                            },
                            icon: Icon(IconBroken.Search)),
                      )
                  ),
                ),
                SizedBox(height: 15,),
                Expanded(
                  child: ConditionalBuilder(
                    condition: ShopCubit.get(context).search != null,
                    builder: (context) =>  ListView.separated(
                        itemBuilder: (context, index) => SearchProductsItemBuilder(ShopCubit.get(context).search!.data!.data![index], context,index),
                        separatorBuilder: (context, index) => SizedBox(height: 7,),
                        itemCount: ShopCubit.get(context).search!.data!.data!.length
                    ),
                    fallback: (context) => Center(child: Text('Search...')),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
Widget SearchProductsItemBuilder(SearchProductsDataModel? model,context,index)=>InkWell(
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
                Text('${model!.name}',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 17,fontWeight: FontWeight.bold,height: 1.2),maxLines: 2,overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10,),
                Text('${model!.description}',style: Theme.of(context).textTheme.caption!.copyWith(height: 1,fontSize: 10,overflow: TextOverflow.ellipsis,color: Colors.grey),maxLines: 2,),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('${model!.price} \$',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 12,fontWeight: FontWeight.bold)),
                    SizedBox(width: 5,),
                    if(model!.discount != 0)
                      Text('Discount ${model!.discount}%',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 8,decoration: TextDecoration.underline),),
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
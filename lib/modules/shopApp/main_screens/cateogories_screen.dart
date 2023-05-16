// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shope_home/cubit/cubit.dart';
import 'package:shop/layout/shope_home/cubit/states.dart';
import 'package:shop/model/shop_models/categories_model/catigories_model.dart';
import 'package:shop/share/styles/icons_broken.dart';

// ignore: use_key_in_widget_constructors
class CategoriesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).categories!=null,
            builder: (BuildContext context) => ListView.separated(
                itemBuilder: (context, index) =>CategoriesItemBuilder(ShopCubit.get(context).categories!.data!.data[index],index) ,
                separatorBuilder: (context, index) => Container(height: 1,width: double.infinity,color: Colors.grey,),
                itemCount: ShopCubit.get(context).categories!.data!.data.length
            ),
            fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),
          )
        );
      },
    );
  }

}
Widget? CategoriesItemBuilder (DataModel? categories,index)=>InkWell(
  onTap: () {

  },
  child:   Padding(

    padding: const EdgeInsets.only(bottom: 25,top: 10,left: 10,right: 10),

    child:   Row(

      mainAxisAlignment: MainAxisAlignment.center,

      crossAxisAlignment: CrossAxisAlignment.center,

      children: [

        Container(



            height: 100,



            width: 100,



            clipBehavior: Clip.antiAliasWithSaveLayer,



            decoration:BoxDecoration(



              borderRadius: BorderRadiusDirectional.circular(10)



            ),



            child: Image(image: NetworkImage('${categories!.image}'),fit: BoxFit.cover,)



        ),



        SizedBox(width: 15,),



        Text('${categories.name}',style: TextStyle(color:textColor[index],fontSize: 17,fontWeight: FontWeight.bold)),



        Spacer(),



        Icon(IconBroken.Arrow___Right_2,size: 25,),











      ],



    ),

  ),
);
List<MaterialColor> textColor=[
  Colors.blueGrey,
  Colors.green,
  Colors.blue,
  Colors.lime,
  Colors.brown,
];

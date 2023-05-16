// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/layout/shope_home/cubit/cubit.dart';
import 'package:shop/layout/shope_home/cubit/states.dart';
import 'package:shop/modules/shopApp/main_screens/cateogories_screen.dart';
import 'package:shop/modules/shopApp/main_screens/favorite_screen.dart';
import 'package:shop/modules/shopApp/main_screens/products_screen.dart';
import 'package:shop/modules/shopApp/main_screens/search_screen.dart';
import 'package:shop/modules/shopApp/main_screens/settings.dart';
import 'package:shop/share/styles/icons_broken.dart';

import '../../modules/shopApp/main_screens/cart_screen.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class ShopHome extends StatelessWidget{
List<Widget> shopScreens=[
  CategoriesScreen(),
  ProductsScreen(),
  SearchScreen(),
  FavoriteScreen(),
  CartScreen()
];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: .2,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Sallaty',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 25,
                      color: Colors.orange
                  )),
                  SizedBox(width: 8,),
                  Icon(Icons.shopping_basket,color: Colors.grey,)
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen(),));
                }, icon: Icon(IconBroken.Setting),),
              )
            ],
          ),
          body:shopScreens[ShopCubit.get(context).CurrentIndex] ,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: BottomNavigationBar(
              currentIndex: ShopCubit.get(context).CurrentIndex,
                onTap: (index){
                ShopCubit.get(context).changeBottomNave(index);
                },
                items:
                [
                  BottomNavigationBarItem(icon: Icon(IconBroken.Category),label:'Categories' ),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Buy),label:'Products'),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Search),label:'Search'),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Heart),label:'Favorites'),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Bag),label:'My Cart'),
                ]
            ),
          ),
        );
      },
    );
  }

}
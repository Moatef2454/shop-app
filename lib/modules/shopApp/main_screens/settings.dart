// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shope_home/cubit/cubit.dart';
import 'package:shop/layout/shope_home/cubit/states.dart';
import 'package:shop/modules/shopApp/login_and_register_screens/login_cubit/cubit.dart';
import 'package:shop/share/network/cubit/app_cubit/cubit.dart';
import 'package:shop/share/styles/icons_broken.dart';

// ignore: use_key_in_widget_constructors
class SettingScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopCubit()..GetProfile()..GetSettings(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              leading:IconButton(onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left)
              ),
              title:ConditionalBuilder(
                condition:ShopCubit.get(context).profile != null ,
                builder: (context) => Text(
                  '${ShopCubit.get(context).profile!.data!.name}'
                  ,style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20,fontWeight: FontWeight.w100),),
                fallback: (BuildContext context)=>Center(child: LinearProgressIndicator(color: Colors.blue,)),
              ),
            ),
            body: ConditionalBuilder(
              condition:ShopCubit.get(context).profile!=null&&ShopCubit.get(context).setting!=null,
              builder: (context) =>  SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18,left: 10,right: 10,bottom: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('Light Mode',style: TextStyle(fontSize: 17),),
                            Spacer(),
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).ChangeAppMode();
                              },
                              icon: AppCubit.get(context).LightModeIcon,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 8.0,bottom: 8,left: 8,right: 8),
                        child: Row(
                          children: [
                            Text('Email : ',style: TextStyle(fontSize: 17),),
                            SizedBox(width: 5,),
                            Text('${ShopCubit.get(context).profile!.data!.email}',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w300),),
                            Spacer(),
                            IconButton(
                              onPressed: (){

                              },
                              icon: Icon(IconBroken.Message),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 8.0,bottom: 8,left: 8,right: 8),
                        child: Row(
                          children: [
                            Text('Phone : ',style: TextStyle(fontSize: 17),),
                            SizedBox(width: 5,),
                            Text('${ShopCubit.get(context).profile!.data!.phone}',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w300),),
                            Spacer(),
                            IconButton(
                              onPressed: (){

                              },
                              icon: Icon(IconBroken.Call),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('Our Terms ',style: TextStyle(fontSize: 17),),
                            Spacer(),
                            IconButton(
                              onPressed: (){
                                ShopCubit.get(context).ReadTerm();
                              },
                              icon: Icon(IconBroken.Arrow___Down_2),
                            )
                          ],
                        ),
                      ),
                      ConditionalBuilder(
                        condition: ShopCubit.get(context).term==true,
                        builder: (context) => Container(
                          padding: EdgeInsetsDirectional.all(8),
                          child: Text('${ShopCubit.get(context).setting!.data!.terms}',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w300),),
                        ),
                        fallback: (context) =>Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('About Us ',style: TextStyle(fontSize: 17),),
                            Spacer(),
                            IconButton(
                              onPressed: (){
                                ShopCubit.get(context).ReadAbout();
                              },
                              icon: Icon(IconBroken.Arrow___Down_2),
                            )
                          ],
                        ),
                      ),
                      ConditionalBuilder(
                        condition: ShopCubit.get(context).about==true,
                        builder: (context) => Container(
                          padding: EdgeInsetsDirectional.all(8),
                          child: Text('${ShopCubit.get(context).setting!.data!.about}',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w300),),
                        ),
                        fallback: (context) =>Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('Log Out',style: TextStyle(fontSize: 17),),
                            Spacer(),
                            IconButton(
                              onPressed: (){
                                ShopCubit.get(context).LogOut(context);
                              },
                              icon: Icon(IconBroken.Logout),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }

}
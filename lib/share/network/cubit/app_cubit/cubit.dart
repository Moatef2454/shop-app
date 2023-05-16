// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/shopApp/login_and_register_screens/login_cubit/states.dart';
import 'package:shop/share/network/cubit/app_cubit/states.dart';
import 'package:shop/share/network/local/cash_helper/cash_helper.dart';
import 'package:shop/share/network/remote/dio_helper/dio_helper.dart';
import 'package:shop/share/styles/icons_broken.dart';

import '../../../../model/shop_models/user_model/user_model.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit():super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  bool isDark=false;
  Widget LightModeIcon=Icon(Icons.light_mode_sharp,color:Colors.white,);
  void ChangeAppMode({bool? fromShared}){
    emit(AppInitialState());
    if(fromShared!=null){
      isDark=fromShared;
      if(!isDark)
        LightModeIcon=Icon(Icons.nightlight_outlined);
      if(isDark)
        LightModeIcon=Icon(Icons.light_mode);
      emit(LightModeSuccessStatea());
    }
    else{
      isDark= !isDark;
      if(!isDark)
        LightModeIcon=Icon(Icons.nightlight_outlined);
      if(isDark)
        LightModeIcon=Icon(Icons.light_mode);
      CashHelper.saveData(key: 'isDrak', value: isDark)
          .then((value) {
            emit(LightModeSuccessStatea());
      })
          .catchError((error){
            print(error.toString());
            emit(LightModeErrorStateb());
      });
    }
  }

}
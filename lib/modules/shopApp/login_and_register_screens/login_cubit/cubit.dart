// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/shopApp/login_and_register_screens/login_cubit/states.dart';
import 'package:shop/share/network/local/cash_helper/cash_helper.dart';
import 'package:shop/share/network/remote/dio_helper/dio_helper.dart';
import 'package:shop/share/styles/icons_broken.dart';

import '../../../../model/shop_models/user_model/user_model.dart';

class LoginCubit extends Cubit<AppLoginState>{
  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  bool isProtect=false;
  Widget suffix=Icon(Icons.visibility_outlined);

  void onSecure(){
    isProtect = !isProtect;
    suffix=isProtect?Icon(Icons.visibility_outlined):Icon(IconBroken.Hide);
    emit(PasswordState());
  }
  UserModel? loginModel;
  UserModel? registerModel;
  // ignore: non_constant_identifier_names
  void UserLogin({required String email,required String password}){
    emit(LoginLoadingState());
    DioHelper.postData(url: 'login',  data: {
      'email':email,
      'password':password
    }).then((value) {
      print(value.data);
      loginModel=UserModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error));
    });
  }
  // ignore: non_constant_identifier_names
  void UserRegister({required String email,required String password,required String name,required String phone}){
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: 'register',
        data: {
          'name':name,
          'email':email,
          'phone':phone,
          'password':password
        }
    )
        .then((value) {
          registerModel=UserModel.fromJson(value.data);
          emit(RegisterSuccessState(registerModel));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error));
    });
  }


}
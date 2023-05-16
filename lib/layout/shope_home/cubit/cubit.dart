// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shope_home/cubit/states.dart';
import 'package:shop/model/shop_models/cart/cart_broduct_model.dart';
import 'package:shop/model/shop_models/cart/in_cart_model.dart';
import 'package:shop/model/shop_models/categories_model/catigories_model.dart';
import 'package:shop/model/shop_models/favorites/change_favorites_model.dart';
import 'package:shop/model/shop_models/favorites/favorites_model.dart';
import 'package:shop/model/shop_models/home/home_model.dart';
import 'package:shop/model/shop_models/profile/profile_model.dart';
import 'package:shop/model/shop_models/search/search_model.dart';
import 'package:shop/model/shop_models/setting/setting_model.dart';
import 'package:shop/modules/shopApp/login_and_register_screens/login_screen.dart';
import 'package:shop/share/componantes/componantes.dart';
import 'package:shop/share/network/remote/dio_helper/dio_helper.dart';

import '../../../share/network/local/cash_helper/cash_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int CurrentIndex=0;
  void changeBottomNave(int index){
    CurrentIndex = index;
    if(index == 0)
       GetCategories();
    if(index==1)
      GetProducts();
    if(index==3)
      GetFavorites();
    if(index==4)
      GetCart();
    emit(BottomNaveState());
  }
   CategoriesModel? categories;
  void GetCategories (){
    emit(CategoriesLoadingState());
    DioHelper.getData(url: 'categories',lang: 'en')
        .then((value){
          categories=CategoriesModel.fromJson(value.data);
          emit(CategoriesSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(CategoriesErrorState(error));
    });
  }
  HomeModel? product;
  Map<int?,bool?> isFavorite={};
  Map<int?,bool?> inCart={};
  void GetProducts(){
    emit(ProductsLoadingState());
    DioHelper.getData(url: 'home',token: Token)
        .then((value) {
          product = HomeModel.fromJson(value.data);
          product!.data!.products!.forEach((element) {
            isFavorite.addAll({
              element.id!:element!.in_favorites

            });
            inCart!.addAll({
              element.id:element.in_cart
            });
            emit(FavoritesIconStatea());
          });
          emit(ProductsSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(ProductsErrorState(error));
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;
  void ChangeFavorite(int? id){
    isFavorite[id]=isFavorite==true?false:true;
    emit(FavoritesIconState());
    DioHelper.postData(
      token:  Token,
        url: 'favorites',
        data: {
          'product_id':id,
          'token':Token
        })
        .then((value) {
          changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
          print(value.data);
          emit(FavoritesSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(FavoritesErrorState(error));
    });
  }
  FavoritesModel? favoritesProducts;
  void GetFavorites(){
    emit(GetFavoritesLoadingState());
    DioHelper.getData(url: 'favorites',token: Token)
        .then((value) {
          favoritesProducts=FavoritesModel.fromJson(value.data);
          emit(GetFavoritesSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(GetFavoritesErrorState(error));
    });
  }
  SearchModel? search;
  void Search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: 'products/search',
        data: {
          'text':text
        }
        ).then((value) {
          search=SearchModel.fromJson(value.data);
          emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
          emit(SearchErrorState(error));
    });
  }
  CartModel? isInCart;
  void ChangeCart(int? id){
    inCart[id]=inCart[id]==true?false:true;
    DioHelper.postData(
      token: Token,
        url: 'carts', data: {
      'product_id':id,
      'token': Token,
    })
        .then((value) {
          isInCart=CartModel.fromJson(value.data);
          print(value.data);
          emit(CartsSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(CartsErrorState(error));
    });
  }
  InCartModel? cart;
  void GetCart(){
    emit(GetCartsLoadingState());
    DioHelper.getData(url: 'carts',token: Token,)
        .then((value) {
          cart=InCartModel.fromJson(value.data);
          emit(GetCartsSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(GetCartsErrorState(error));
    });
  }
  ProfileModel? profile;
  void GetProfile(){
    DioHelper.getData(url: 'profile',token: Token)
        .then((value) {
          profile=ProfileModel.fromJson(value.data);
          emit(GetProfileSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(GetProfileErrorState(error));
    });
  }
  void LogOut(context){
    DioHelper.postData(
        token: Token,
        url: 'logout',
        data: {
          "fcm_token":Token
        }
    ).then((value) {
      CashHelper.clearData(key: 'token');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);
      emit(LogOutSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(LogOutErrorState(error));
    });
  }
  SettingModel? setting;
  void GetSettings(){
    DioHelper.getData(url: 'settings',token: Token)
        .then((value) {
          setting=SettingModel.fromJson(value.data);
          emit(SearchSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(SettingErrorState(error));
    });
  }
  bool term=false;
  void ReadTerm(){
    term = !term ;
    GetSettings();
    emit(TermSuccessState());
  }
  bool about=false;
  void ReadAbout(){
    about = !about ;
    GetSettings();
    emit(AboutSuccessState());
  }
}
abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class BottomNaveState extends ShopStates{}
class CategoriesLoadingState extends ShopStates{}
class CategoriesSuccessState extends ShopStates{}
class CategoriesErrorState extends ShopStates{
  final error;

  CategoriesErrorState(this.error);
}
class ProductsLoadingState extends ShopStates{}
class ProductsSuccessState extends ShopStates{}
class ProductsErrorState extends ShopStates{
  final error;

  ProductsErrorState(this.error);
}
class FavoritesSuccessState extends ShopStates{}
class FavoritesErrorState extends ShopStates{
  final error;

  FavoritesErrorState(this.error);
}
class FavoritesIconState extends ShopStates{}
class FavoritesIconStatea extends ShopStates{}
class GetFavoritesLoadingState extends ShopStates{}
class GetFavoritesSuccessState extends ShopStates{}
class GetFavoritesErrorState extends ShopStates{
  final error;

  GetFavoritesErrorState(this.error);
}
class SearchLoadingState extends ShopStates{}
class SearchSuccessState extends ShopStates{}
class SearchErrorState extends ShopStates{
  final error;

  SearchErrorState(this.error);
}
class LightModeSuccessStatec extends ShopStates{}
class LightModeErrorStated extends ShopStates{}
class CartsSuccessState extends ShopStates{}
class CartsErrorState extends ShopStates{
  final error;

  CartsErrorState(this.error);
}
class GetCartsLoadingState extends ShopStates{}
class GetCartsSuccessState extends ShopStates{}
class GetCartsErrorState extends ShopStates{
  final error;

  GetCartsErrorState(this.error);
}
class GetProfileSuccessState extends ShopStates{}
class GetProfileErrorState extends ShopStates{
  final error;

  GetProfileErrorState(this.error);
}
class LogOutSuccessState extends ShopStates{}
class LogOutErrorState extends ShopStates{
  final error;

  LogOutErrorState(this.error);
}
class SettingSuccessState extends ShopStates{}
class SettingErrorState extends ShopStates{
  final error;

  SettingErrorState(this.error);
}
class TermSuccessState extends ShopStates{}
class AboutSuccessState extends ShopStates{}






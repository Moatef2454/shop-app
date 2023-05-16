class FavoritesModel{
  bool? status;
  String? message;
  FavoritesDataModel? data;
  FavoritesModel({this.status,this.message,this.data});
  FavoritesModel.fromJson(Map<String,dynamic>?json){
    status=json!['status'];
    message=json!['message'];
    data=FavoritesDataModel.fromJson(json['data']);
  }
}
class FavoritesDataModel{
  int? total;
  List<FavoritesDataInfoModel> data=[];
  FavoritesDataModel.fromJson(Map<String,dynamic>? json){
    total=json!['total'];
    json!['data'].forEach((element) {
      data.add(FavoritesDataInfoModel.fromJson(element));
    });
  }
}
class FavoritesDataInfoModel{
  int? id;
  FavoriteProductsModel? product;
  FavoritesDataInfoModel({this.id,this.product});
  FavoritesDataInfoModel.fromJson(Map<String,dynamic>? json){
    id=json!['id'];
    product=FavoriteProductsModel.fromJson(json['product']);
  }
}
class FavoriteProductsModel{
  int? id;
  num? price;
  num? old_price;
  num? discount;
  String? image;
  String? name;
  String? description;
  FavoriteProductsModel({this.name,this.image,this.id,this.description,this.discount,this.old_price,this.price});
  FavoriteProductsModel.fromJson(Map<String,dynamic>?json){
    id=json!['id'];
    price=json!['price'];
    old_price=json!['old_price'];
    discount=json!['discount'];
    image=json!['image'];
    name=json!['name'];
    description=json!['description'];
  }
}
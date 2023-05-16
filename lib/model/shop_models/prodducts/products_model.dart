class ProductsModel{
  String? status;
  String? message;
  ProductsDataModel? data;
  ProductsModel.fromJson(Map<String,dynamic>? json){
    status=json!['status'];
    message=json!['message'];
    data=ProductsDataModel.fromJson(json!['data']);
  }
}
class ProductsDataModel{
  num? current_page;
  bool? in_cart;
  bool? in_favorites;
  List<ProductsDataInfoModel>? data;
  ProductsDataModel.fromJson(Map<String,dynamic>?json){
    current_page=json!['current_page'];
    in_cart=json!['in_cart'];
    in_favorites=json!['in_favorites'];
   json!['data'].forEach((element) {
     data!.add(ProductsDataInfoModel.fromJson(element));
    });
  }
}
class ProductsDataInfoModel{
  int? id;
  num? price;
  num? old_price;
  num? discount;
  String? image;
  String? name;
  String? description;
  ProductsDataInfoModel({this.name,this.image,this.id,this.description,this.discount,this.old_price,this.price});
  ProductsDataInfoModel.fromJson(Map<String,dynamic>?json){
    id=json!['id'];
    price=json!['price'];
    old_price=json!['old_price'];
    discount=json!['discount'];
    image=json!['image'];
    name=json!['name'];
    description=json!['description'];
  }
}
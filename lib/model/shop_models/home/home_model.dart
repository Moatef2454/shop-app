class HomeModel{
  bool? status;
  String? message;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String,dynamic>?json){
    status=json!['status'];
    message = json!['message'];
    data=HomeDataModel.fromJson(json['data']);
  }
  Map<String,dynamic> toMap(){
    return
      {
        'status':status,
        'message':message,
        'data':data,
      };
  }
}
class HomeDataModel{
List <Products>? products=[];
List <Banners>? banners=[];
HomeDataModel.fromJson(Map<String,dynamic>json){
  json['products'].forEach((element) {
    products!.add(Products.fromJson(element));
  });
  json['banners'].forEach((element) {
    banners!.add(Banners.fromJson(element));
  });

}
Map<String,dynamic> toMap(){
  return
    {
      'banners':banners,
      'products':products,
    };
}
}
class Products
{
  int? id;
  num? price;
  num? old_price;
  num? discount;
  String? image;
  String? name;
  String? description;
  bool? in_favorites;
  bool? in_cart;
  Products({this.name,this.image,this.id,this.description,this.discount,this.old_price,this.price,this.in_favorites,this.in_cart});
  Products.fromJson(Map<String,dynamic>?json){
    id=json!['id'];
    price=json!['price'];
    old_price=json!['old_price'];
    discount=json!['discount'];
    image=json!['image'];
    name=json!['name'];
    description=json!['description'];
    in_favorites=json!['in_favorites'];
    in_cart=json!['in_cart'];
  }
  Map<String,dynamic> toMap(){
    return
      {
    'id':id,
    'price':price,
    'old_price':old_price,
    'discount':discount,
    'image':image,
    'name':name,
    'description':description,
        'in_favorites':in_favorites,
        'in_cart':in_cart,
      };
  }
}
class Banners
{
  int? id;
  String? image;
  Banners({this.image,this.id});
  Banners.fromJson(Map<String,dynamic>?json){
    id=json!['id'];
    image=json!['image'];

  }
  Map<String,dynamic> toMap(){
    return
      {
        'id':id,
        'image':image,
      };
  }
}
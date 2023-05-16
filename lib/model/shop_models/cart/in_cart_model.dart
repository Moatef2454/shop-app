class CartModel{
  bool? status;
  String? message;
  CartDataModel? data;
  CartModel({this.status,this.data,this.message});
  CartModel.fromJson(Map<String,dynamic>?json){
    status=json!['status'];
    message=json!['message'];
    data=json!['data'];
  }
  Map<String,dynamic> toMap(){
    return{
      'status':status,
      'message':message,
      'data':data
    };
  }
}
class CartDataModel{
  int? id;
  int? quantity;
  CartProductModel? product;
  CartDataModel({this.id,this.quantity,this.product});
  CartDataModel.fromJson(Map<String,dynamic>?json){
    id=json!['id'];
    quantity=json!['quantity'];
    product=json!['product'];
  }
  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'quantity':quantity,
      'product':product
    };
  }
}
class CartProductModel{
  int? id;
  num? price;
  num? old_price;
  num? discount;
  String? image;
  String? name;
  String? description;
  CartProductModel({this.name,this.image,this.id,this.description,this.discount,this.old_price,this.price});
  CartProductModel.fromJson(Map<String,dynamic>?json){
    id=json!['id'];
    price=json!['price'];
    old_price=json!['old_price'];
    discount=json!['discount'];
    image=json!['image'];
    name=json!['name'];
    description=json!['description'];
  }
}
class InCartModel{
  bool? status;
  String? message;
  InCartDataModel? data;
  InCartModel({this.status,this.data,this.message});
  InCartModel.fromJson(Map<String,dynamic>?json){
    status=json!['status'];
    message=json!['message'];
    data=InCartDataModel.fromJson(json['data']);
  }
  Map<String,dynamic> toMap(){
    return{
      'status':status,
      'message':message,
      'data':data
    };
  }
}
class InCartDataModel{
  int? id;
  int? quantity;
  num? total;
  List <InCartItemModel>? cart_items=[];
  InCartDataModel({this.id,this.quantity,this.cart_items,this.total});
  InCartDataModel.fromJson(Map<String,dynamic>?json){
    id=json!['id'];
    quantity=json!['quantity'];
    total=json!['total'];
    json!['cart_items']
        .forEach((element) {
      cart_items!.add( InCartItemModel.fromJson(element));
    });
  }
  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'quantity':quantity,
      'cart_items':cart_items,
      'total':total
    };
  }
}
class InCartItemModel{
  int? id;
  int? quantity;
  InCartProductModel? product;

  InCartItemModel({this.id,this.quantity,this.product});
  InCartItemModel.fromJson(Map<String,dynamic>?json){
    id=json!['id'];
    quantity=json!['quantity'];
    product=InCartProductModel.fromJson(json['product']);
  }
}
class InCartProductModel{
  int? id;
  num? price;
  num? old_price;
  num? discount;
  String? image;
  String? name;
  String? description;
  InCartProductModel({this.name,this.image,this.id,this.description,this.discount,this.old_price,this.price});
  InCartProductModel.fromJson(Map<String,dynamic>?json){
    id=json!['id'];
    price=json!['price'];
    old_price=json!['old_price'];
    discount=json!['discount'];
    image=json!['image'];
    name=json!['name'];
    description=json!['description'];
  }
}
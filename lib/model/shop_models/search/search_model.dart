class SearchModel{
  bool? status;
  String? message;
  SearchDataModel? data;
  SearchModel.fromJson(Map<String,dynamic>? json){
    status=json!['status'];
    message=json!['message'];
    data=SearchDataModel.fromJson(json['data']);
  }

}
class SearchDataModel{
List<SearchProductsDataModel>? data=[];
SearchDataModel({this.data});
SearchDataModel.fromJson(Map<String,dynamic>? json){
  json!['data'].forEach((element) {
    data!.add(SearchProductsDataModel.fromJson(element));
  });
}
}
class SearchProductsDataModel{
  int? id;
  num? price;
  num? old_price;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? in_favorites;
  SearchProductsDataModel({this.name,this.image,this.id,this.description,this.discount,this.old_price,this.price,this.in_favorites});
  SearchProductsDataModel.fromJson(Map<String,dynamic>?json){
    id=json!['id'];
    price=json!['price'];
    old_price=json!['old_price'];
    discount=json!['discount'];
    image=json!['image'];
    name=json!['name'];
    description=json!['description'];
    in_favorites=json!['in_favorites'];
  }
}
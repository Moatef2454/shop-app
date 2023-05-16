class ProfileModel{
  bool? status;
  String? message;
  ProfileDataModel? data;
ProfileModel({this.data,this.message,this.status});
ProfileModel.fromJson(Map<String,dynamic>? json){
  status=json!['status'];
  message=json!['message'];
  data=ProfileDataModel.fromJson(json['data']);
}
}
class ProfileDataModel{
  int? id;
  String? name;
  String? image;
  String? email;
  String? phone;
  ProfileDataModel({this.id,this.name,this.image,this.phone,this.email});
  ProfileDataModel.fromJson(Map<String,dynamic>? json){
    id=json!['id'];
    name=json!['name'];
    email=json!['email'];
    image=json!['image'];
    phone =json!['phone'];
  }
}
class UserModel {
  bool? status;
  String? message;
  DataModel? data;
  UserModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?DataModel.fromJson(json['data']):null;
  }
}
class DataModel{
  String? name;
  String? email;
  String? password;
  String? token;
  DataModel({this.name,this.email,this.password,this.token});
  DataModel.fromJson(Map<String,dynamic>json){
    name= json['name'];
    email= json['email'];
    password= json['password'];
    token= json['token'];
  }
  Map<String,dynamic> toMap(){
    return{
      'name': name,
      'email':email,
      'password':password,
      "token":token
  };
  }
}
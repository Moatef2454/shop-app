class SettingModel{
  bool? status;
  String? message;
  SettingDataModel? data;
  SettingModel({this.data,this.message,this.status});
  SettingModel.fromJson(Map<String,dynamic>? json){
    status=json!['status'];
    message=json!['message'];
    data=SettingDataModel.fromJson(json['data']);
  }
}
class SettingDataModel{
  String? about;
  String? terms;

  SettingDataModel({this.about,this.terms});
  SettingDataModel.fromJson(Map<String,dynamic>? json){
    about=json!['about'];
    terms=json!['terms'];
  }
}
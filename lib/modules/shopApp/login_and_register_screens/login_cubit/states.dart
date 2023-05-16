import 'package:shop/model/shop_models/user_model/user_model.dart';

abstract class AppLoginState{}
class LoginInitialState extends AppLoginState{}
class PasswordState extends AppLoginState{}
class LoginLoadingState extends AppLoginState{}
class LoginSuccessState extends AppLoginState{
  final UserModel? loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends AppLoginState{
  // ignore: prefer_typing_uninitialized_variables
  final error;
  LoginErrorState(this.error);
}
class RegisterLoadingState extends AppLoginState{}
class RegisterSuccessState extends AppLoginState{
  final UserModel? loginModel;
  RegisterSuccessState(this.loginModel);
}
class RegisterErrorState extends AppLoginState{
  // ignore: prefer_typing_uninitialized_variables
  final error;
 RegisterErrorState(this.error);
}
class LightModeSuccessState extends AppLoginState{}
class LightModeErrorState extends AppLoginState{}
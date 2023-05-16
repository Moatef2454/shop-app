import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  bool isPassword = false,
  required String? Function(String?)?  validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  void Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );
void ShowToast(
{
  required String message,
  required ToastState? state,
}
    )=>Fluttertoast.showToast(
    msg: message,
    backgroundColor: ToastColor(state),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,        
    timeInSecForIosWeb: 5,
    textColor: Colors.white,
    fontSize: 16.0,
);
enum ToastState {SUCCESS,ERROR,WARNING}
Color? ToastColor(ToastState? state){
  Color? color;
  switch(state)
  {
    case ToastState.SUCCESS:
      color=Colors.green;
      break;
      case ToastState.ERROR:
      color=Colors.red;
      break;
      case ToastState.WARNING:
      color=Colors.amberAccent;
      break;
  }
  return color;
}
String? Token;
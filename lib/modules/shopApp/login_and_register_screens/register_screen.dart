// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/shopApp/login_and_register_screens/login_screen.dart';
import 'package:shop/share/componantes/componantes.dart';

import '../../../share/styles/icons_broken.dart';
import 'login_cubit/cubit.dart';
import 'login_cubit/states.dart';

// ignore: use_key_in_widget_constructors
class RegisterScreen extends StatelessWidget{
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>LoginCubit(),
      child: BlocConsumer<LoginCubit,AppLoginState>(
          listener: (context, state) {
            if(state is RegisterSuccessState){
              if(state.loginModel!.status==true){
                ShowToast(message: state.loginModel!.message.toString(), state: ToastState.SUCCESS);
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
              }
              if(state.loginModel!.status==false){
                ShowToast(message: state.loginModel!.message.toString(), state: ToastState.ERROR);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(icon:Icon(IconBroken.Arrow___Left) , onPressed: () { Navigator.pop(context);},color: Colors.blue,),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50,right: 15,left: 15,bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Text('Register to ',style: TextStyle(color: Colors.blue,fontSize: 12),),
                        SizedBox(height: 7,),
                        Text('Sallaty',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 60,
                            color: Colors.orange
                        )),
                        SizedBox(height: 30,),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          validator: (value) {
                            if(value == '') {
                              return 'please enter your name ';
                            }
                            else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            labelText: 'name',
                            prefixIcon:Icon(IconBroken.Profile),
                          ),
                        ),
                        SizedBox(height: 25,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if(value == '') {
                              return 'please enter your e-mail';
                            }
                            else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            labelText: 'E-mail',
                            prefixIcon:Icon(IconBroken.Message),
                          ),
                        ),
                        SizedBox(height: 25,),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          validator: (value) {
                            if(value == '') {
                              return 'please enter your phone';
                            }
                            else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            labelText: 'phone number',
                            prefixIcon:Icon(IconBroken.Call),
                          ),
                        ),
                        SizedBox(height: 25,),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          validator: (value) {
                            if(value == '') {
                              return 'please enter your new password';
                            }
                            else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon:Icon(IconBroken.Password),
                            suffixIcon: Icon(Icons.remove_red_eye_outlined)
                          ),
                        ),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                            condition: state is RegisterLoadingState,
                            builder: (context) => Center(child: CircularProgressIndicator()),
                            fallback: (context) =>  Container(
                              width: 250,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.circular(10),
                                  color: Colors.blue
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate())
                                  {
                                  LoginCubit.get(context).UserRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }
                              },
                                color: Colors.blue,
                                elevation: 0,
                                child: Text('Register',style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontSize: 22,

                                  color: Colors.white,
                                ),),
                              ),
                            ),),

                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
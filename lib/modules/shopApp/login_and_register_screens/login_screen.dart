// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shope_home/home_layout.dart';
import 'package:shop/modules/shopApp/login_and_register_screens/login_cubit/cubit.dart';
import 'package:shop/modules/shopApp/login_and_register_screens/login_cubit/states.dart';
import 'package:shop/modules/shopApp/login_and_register_screens/register_screen.dart';
import 'package:shop/share/network/local/cash_helper/cash_helper.dart';
import '../../../share/componantes/componantes.dart';
import '../../../share/styles/icons_broken.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatelessWidget{
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return BlocProvider(
     create: (BuildContext context) =>LoginCubit()..onSecure(),
     child: BlocConsumer<LoginCubit,AppLoginState>(
       listener: (context, state) {
         if(state is LoginSuccessState) {
          if (state.loginModel!.status == true) {
            CashHelper.saveData(key: 'token', value: state.loginModel!.data!.token)
                .then((value) {
              ShowToast(
                  message: state.loginModel!.message.toString(),
                  state: ToastState.SUCCESS);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShopHome(),));
              print(state.loginModel!.message);
              print(state.loginModel!.data!.token);
            }
            );

          }
          if(state.loginModel!.status==false) {
            ShowToast(
                message: state.loginModel!.message.toString(),
                state: ToastState.ERROR);
            print(state.loginModel!.message);

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
                 padding: const EdgeInsets.only(top: 80,right: 15,left: 15,bottom: 15),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment:MainAxisAlignment.center,
                   children: [
                     Text('login into',style: TextStyle(color: Colors.blue),),
                     SizedBox(height: 7,),
                     Text('Sallaty',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                       fontSize: 60,
                       color: Colors.orange
                     )),
                     SizedBox(height: 30,),
                     TextFormField(
                       keyboardType: TextInputType.emailAddress,
                       controller: emailController,
                       validator: (value) {
                         if(value == '') {
                           return 'this can\'t be empty';
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
                       keyboardType: TextInputType.visiblePassword,
                       controller: passwordController,
                       obscureText: LoginCubit.get(context).isProtect,
                       validator: (value) {
                         if(value == '') {
                           return 'this can\'t be empty';
                         }
                         else{
                           return null;
                         }
                       },
                       decoration: InputDecoration(
                         border:OutlineInputBorder(),
                         labelText: 'Password',
                         prefixIcon:Icon(IconBroken.Password),
                         suffixIcon:IconButton(onPressed: () {
                           return LoginCubit.get(context).onSecure();
                         },
                           icon: LoginCubit.get(context).suffix ,
                         ),

                       ),
                     ),
                     SizedBox(height: 30,),
                     ConditionalBuilder(
                       condition: state is LoginLoadingState,
                       builder: (BuildContext context) =>Center(child: CircularProgressIndicator()),
                       fallback: (BuildContext context) =>Container(
                         height: 60,
                         width: 250,
                         clipBehavior: Clip.antiAliasWithSaveLayer,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadiusDirectional.circular(10),
                             color: Colors.blue
                         ),
                         child: MaterialButton(onPressed: () {
                           if(formKey.currentState!.validate()) {
                              LoginCubit.get(context).UserLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                           child: Text('Login',style: Theme.of(context).textTheme.bodyText2!.copyWith(
                             fontSize: 22,

                             color: Colors.white,
                           ),),
                           color: Colors.blue,
                           elevation: 0,
                         ),
                       ),),
                     SizedBox(height: 10,),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text('Not have an account |',style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),),
                         TextButton(onPressed:  () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                         }, child: Text('register',style: TextStyle(fontSize: 12),),)
                       ],
                     )
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
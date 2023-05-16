// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/layout/shope_home/cubit/cubit.dart';
import 'package:shop/layout/shope_home/cubit/states.dart';
import 'package:shop/modules/shopApp/login_and_register_screens/login_cubit/cubit.dart';
import 'package:shop/modules/shopApp/login_and_register_screens/login_screen.dart';
import 'package:shop/modules/shopApp/onBoarding/on_boarding_screen.dart';
import 'package:shop/share/bloc_observer/bloc_obsorver.dart';
import 'package:shop/share/componantes/componantes.dart';
import 'package:shop/share/network/cubit/app_cubit/cubit.dart';
import 'package:shop/share/network/cubit/app_cubit/states.dart';
import 'package:shop/share/network/local/cash_helper/cash_helper.dart';
import 'package:shop/share/network/remote/dio_helper/dio_helper.dart';

import 'layout/shope_home/home_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  DioHelper.init();
  await CashHelper.int();
  bool onBoard = CashHelper.getData(key: 'onBoarding')!=null?CashHelper.getData(key: 'onBoarding'):false;
  bool isDark = CashHelper.getData(key: 'isDrak')!=null?CashHelper.getData(key: 'isDrak'):true;
  Token=CashHelper.getData(key: 'token');
  Widget? startWidget;
  print('token : ${Token}');
    if(onBoard)
      {
        if(Token!=null){
          startWidget=ShopHome();
        }
        else{
          startWidget = LoginScreen();
        }
      }
    if(onBoard==false){
      startWidget=Onboard();
    }

  runApp( MyApp(onBoard: onBoard,startWidget:startWidget ,isDark: isDark,));
}

class MyApp extends StatelessWidget {
  final bool onBoard;
  final Widget? startWidget;
  final bool? isDark;

  const MyApp({super.key, required this.onBoard,required this.startWidget,this.isDark});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..GetCategories()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => AppCubit()..ChangeAppMode(fromShared:isDark)),
      ],
      child: BlocConsumer<AppCubit,AppState>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.orangeAccent,
                    enableFeedback:true,
                  landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                  type: BottomNavigationBarType.shifting,
                  selectedIconTheme: IconThemeData(size: 30),
                  unselectedIconTheme: IconThemeData(size: 20),
                    elevation: 0
                ),
                primarySwatch: Colors.blue,
                textTheme:  TextTheme(
                    bodyText1: TextStyle(
                        fontFamily: 'ShortBaby'
                    ),
                    bodyText2: TextStyle(
                        fontFamily: 'freedom'
                    ),
                    headline1: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

                ),
                appBarTheme: AppBarTheme(
                    color: Colors.white,
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.black.withOpacity(.5))),
                scaffoldBackgroundColor: Colors.white
              // fontFamily: 'ShortBaby'
            ),
            darkTheme: ThemeData(
                primarySwatch: Colors.orange,
                appBarTheme: AppBarTheme(
                    color: HexColor('333739'),
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.white70),
                    titleTextStyle: TextStyle(color: Colors.white70,fontSize: 20)
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: HexColor('333739'),
                    unselectedItemColor: Colors.grey,
                    selectedItemColor: Colors.orangeAccent,
                    enableFeedback:true,
                    landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                    type: BottomNavigationBarType.shifting,
                    selectedIconTheme: IconThemeData(size: 30),
                    unselectedIconTheme: IconThemeData(size: 20),
                    elevation: 0
                ),
                scaffoldBackgroundColor: HexColor('333739'),
              textTheme:  TextTheme(
                  bodyText1: TextStyle(
                      fontFamily: 'ShortBaby',
                  ),
                  bodyText2: TextStyle(
                      fontFamily: 'freedom',
                    color: Colors.white,
                  ),
                  headline1: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)
              ),

            ),
            themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home: startWidget,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

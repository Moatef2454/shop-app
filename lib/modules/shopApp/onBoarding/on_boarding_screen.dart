// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/modules/shopApp/login_and_register_screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../model/shop_models/page_view_model.dart';
import '../../../share/network/local/cash_helper/cash_helper.dart';

class Onboard extends StatefulWidget{
  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  var boardController = PageController();
  List<PageViewModel> board=[
    PageViewModel(
      image: 'https://media.istockphoto.com/id/1207408589/vector/family-shopping-concept-father-with-bag-with-food-big-trolley-basket-and-bag-with-food.jpg?s=612x612&w=0&k=20&c=DNamyecxurIi76iditl_5mhKf1RCYXKK2ve8W8DVrAI=',
      title: 'Sallaty ',
      body: 'hello in our shop app, enter your journey ',
    ),
    PageViewModel(
      image: 'https://media.istockphoto.com/id/1347255675/vector/family-people-run-with-bags-supermarket-trolley-balloons-for-shopping-on-black-friday.jpg?s=612x612&w=0&k=20&c=Ls0i3381rpmutKyPLKcZVdGOE7jMtPnlMnsOc0VJQwQ=',
      title: 'Sallaty ',
      body: 'In your journey you will fiend many offers',
    ),
    PageViewModel(
      image: 'https://media.istockphoto.com/id/1265330653/vector/happy-family-shopping-together-character-vector-design.jpg?s=612x612&w=0&k=20&c=-tyCCdFRuUg7DWz3HmDTc-YGAJ67rGFEWcIDjpTINvM=',
      title: 'Sallaty ',
      body: 'Every one in your family can fiend his interest ',
    ),
  ];
  bool isLast = false;

  void submit() {
    CashHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value)
    {
      if (value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      }});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
          }, child: Text('Skip'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == 2) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (BuildContext context, int index) =>pageItemBuilder(context,board[index]),
                itemCount: board.length,
              ),
            ),
            SizedBox(height: 100,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: board.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.orange,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast)
                    {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),

                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
Widget? pageItemBuilder (context, PageViewModel? model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Expanded(
        child:
        Image(image: NetworkImage('${model!.image}'),)
    ),
    Text('${model!.title}',style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20,color: Colors.orange)),
    SizedBox(height:10),
    Text('${model!.body}',style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15,color: Colors.blue))
  ],
);
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/Modules/Shop_App/Login_Screen/ShopLoginScreen.dart';
import 'package:untitled3/remote/dio/casheHelper.dart';



class pagemodule{
  final String image;
  final String title;
  final String body;

  pagemodule(this.body,this.image,this.title);
}
class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  bool isLast= false;
  var controler = PageController();
  List<pagemodule> list =[
    pagemodule("Buy What you need from where you are!","assets/images/onboarding_1.jpg","Buy Online"),
    pagemodule("You Will Be Happy By everything","assets/images/onboarding_2.jpg","Be Happy"),
    pagemodule("You Will Admire With All Products","assets/images/onboarding_3.jpg","Be Careful"),
  ];

  void submit()
  {
    cacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context)=>ShopLoginScreen()),
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submit,
              child: Text(
                'SKIP',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.amber,
                ),
              ),)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controler,
              itemBuilder: (context, index) => pageItem(list[index]),
              itemCount: list.length,
              onPageChanged: (index){
                setState(() {
                  currentIndex = index;
                });
                  if(index == list.length -1){
                    setState(() {
                      isLast = true;
                    });
                  }
                  else{
                    setState(() {
                      isLast = false;
                    });
                  }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                DotsIndicator(
                  dotsCount: list.length,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  position: currentIndex.toDouble(),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }else{
                      controler.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                },
                child: Icon(Icons.arrow_forward),)
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  Widget pageItem(list) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(
                image: AssetImage(
                  '${list.image}',
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              '${list.title}',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '${list.body}',
            ),
            SizedBox(
              height: 60.0,
            ),
          ],
        ),
      );
}

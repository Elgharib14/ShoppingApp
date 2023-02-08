import 'package:flutter/material.dart';
import 'package:shoppingapp/data_layer/chachhelper/shardpref.dart';
import 'package:shoppingapp/preseitation_layer/loginScreen.dart';
import 'package:shoppingapp/preseitation_layer/navebarscreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../modells/onbrdingmodell.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  var boardcontroller = PageController();
  bool isLast = false;
  List<onBordingModel> screens =[
    onBordingModel(
      'assets/1.jpg', 
      'On Boarding Title 1', 
      'On Boarding Title 1'
      ),
    onBordingModel(
      'assets/2.jpg', 
      'On Boarding Title 2', 
      'On Boarding Title 2'
      ),
    onBordingModel(
      'assets/3.PNG', 
      'On Boarding Title 3', 
      'On Boarding Title 3'
      ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){
              shardpref.SaveData(key: 'onBoarding', value: true).then((value){
                if(value){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                }
              });
               
            },
            child: const Text('skip',
             style: TextStyle(
            color: Colors.blue,
            fontSize: 25
            ),
            )
            )
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
         
          children: [
            
           Expanded(
             child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: boardcontroller,
              onPageChanged: (int index) {
                if(index == screens.length - 1){
                  print('last');
                  setState((){
                   isLast = true; 
                  });
                
                }else{
                  print('No last');
                 setState((){
                    isLast = false;
                  });
                }
              },
              itemBuilder:(context, index) => buildOnBordingItme(screens[index]),
              itemCount: screens.length,
               ),
           ),
            Row(
              children: [
               SmoothPageIndicator(
                effect:ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  expansionFactor: 4,
                  activeDotColor: Colors.blue,
                  spacing: 5,
                ) ,
                controller: boardcontroller,
                count: screens.length,
               ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: (){
                    if(isLast){
                      shardpref.SaveData(key: 'onBoarding', value: true).then((value){
                      if(value){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                      }
                    });
                    }else{
                      boardcontroller.nextPage(
                      duration:Duration(milliseconds: 750) , 
                      curve: Curves.fastOutSlowIn
                    );
                    }
                   
                  },
                  child: Icon(Icons.arrow_forward_ios_rounded,size: 35,),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget buildOnBordingItme(onBordingModel model){
  return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
              child: 
              Image(image:AssetImage("${model.image}"),
              fit: BoxFit.fill,
              )
              ),
              SizedBox(height: 30,),
            Text('${model.text1}',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
            SizedBox(height: 30,),
             Text('${model.text2}',style: TextStyle(
              fontSize: 25,
              color: Colors.grey
            ),),
    ],
  );
}
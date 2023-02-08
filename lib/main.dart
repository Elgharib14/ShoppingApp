import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/business_layer/cubit/shop_cubit.dart';
import 'package:shoppingapp/data_layer/chachhelper/shardpref.dart';
import 'package:shoppingapp/data_layer/diohelper/diohelper.dart';
import 'package:shoppingapp/preseitation_layer/loginScreen.dart';
import 'package:shoppingapp/preseitation_layer/navebarscreen.dart';
import 'package:shoppingapp/preseitation_layer/onbordingscreen.dart';

import 'data_layer/customshard/endpoint.dart';

Widget? widget;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   await shardpref.init();
  await DioHelper.init();
  bool? onBoarding= shardpref.getData(key:'onBoarding' );
   tokens = shardpref.getData(key:'token' );
  
  if(onBoarding != null){
    print(onBoarding);
    if(tokens != null){ widget = NaveBarScreen(); print(tokens);}
   
    else widget = LoginScreen();
  }else{
    widget = OnBordingScreen();
  }
  runApp( MyApp(widget,));
 
}

class MyApp extends StatelessWidget {
  final Widget? startwidget;
  

  MyApp( this.startwidget,);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategoryData()..getfaverot()..getcart()..getProfile(),
        )
      ],
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
        home:startwidget
      ),
    );
  }
}


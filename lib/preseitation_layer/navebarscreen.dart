import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/business_layer/cubit/shop_cubit.dart';
import 'package:shoppingapp/business_layer/cubit/shop_state.dart';
import 'package:shoppingapp/preseitation_layer/cartscreen.dart';
import 'package:shoppingapp/preseitation_layer/homescreen.dart';
import 'package:shoppingapp/preseitation_layer/profilescreen.dart';
import 'package:shoppingapp/preseitation_layer/searchscreen.dart';

import 'favoritescreen.dart';

class NaveBarScreen extends StatelessWidget {
  
  List<String> title =[
    'Home',
    'Favorite',
    'cart',
    'profile',
  ];
  List<Widget> Screens = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0.0,
            title: Text(title[cubit.currentIndex],style: TextStyle(
              fontSize: 25,
              color: Colors.black
            ),),
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context) => SearchScreen()));
                }, 
                icon: Icon(Icons.search),
                color: Colors.black,
                ),
            ],
          ),

          body: Screens[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor:Colors.blue,
            elevation: 0.0,
            currentIndex:cubit.currentIndex ,
            onTap: (index){
              cubit.Chanescreen(index);
            },
    
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
              ),
               BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite'
              ),
               BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'cart'
              ),
               BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'profile'
              ),
              
            ],
          ),
        );
      },
    );
  }
}
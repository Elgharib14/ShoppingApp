import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingapp/business_layer/cubit/shop_cubit.dart';
import 'package:shoppingapp/business_layer/cubit/shop_state.dart';
import 'package:shoppingapp/data_layer/chachhelper/shardpref.dart';
import 'package:shoppingapp/modells/catogerymodell.dart';
import 'package:shoppingapp/modells/homemodell.dart';
import 'package:shoppingapp/preseitation_layer/loginScreen.dart';
import '../data_layer/customshard/customes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if(state is ChangeFaverotSucess){
           if(state.changefavModell.status!){
            Fluttertoast.showToast(
              msg: state.changefavModell.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
           }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModell != null && ShopCubit.get(context).catogryModell != null, 
          builder: (context) =>HomeCustom(
            ShopCubit.get(context).homeModell,
            ShopCubit.get(context).catogryModell,
            context
            ) , 
          fallback: (context) =>Center(child: CircularProgressIndicator()) ,
          );
      },
    );
  }

  Widget HomeCustom(HomeModell? modell ,CatogryModell? catogryModell,cotext){
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         CarouselSlider(
                      items:modell!.data!.banners!.map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        fit: BoxFit.fill,
                      )).toList(),
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayAnimationDuration: Duration(seconds: 3),
                        autoPlayInterval:  Duration(seconds: 5),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      )
                      ),
                      SizedBox(height: 10,),
                      Text('Categories',style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 160,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder:(context, index) => catogerycustoum(
                          image:"${catogryModell.data!.data![index].image}" ,
                          text: '${catogryModell.data!.data![index].name}',
                          ), 
                        separatorBuilder: (context, index) => SizedBox(width: 10,), 
                        itemCount: catogryModell!.data!.data!.length
                        ),
                      ),
                       SizedBox(height: 10,),
                      Text('New Products',style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 20,),
                      Container(
                        color: Colors.white,
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 2,
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 1.0,
                          childAspectRatio: 1/1.7,
                          children: List.generate(modell.data!.products!.length,
                           (index) => productCard(modell.data!.products![index],cotext,index)
                           ),
                        ),
                      )
      ],
    ),
  );
  
}

  Widget productCard(Products modell,context,index){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: Alignment.topLeft,
        children: [
          Image(
          image: NetworkImage(modell.image!),
          width: double.infinity,
          height: 260,
          fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            if(modell.discount != 0)
            Container(
              height: 20,
              color: Colors.blue,
              child: Text('Discount',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Spacer(),
            Column(
              children: [
                InkWell(
                  onTap: (){
                    ShopCubit.get(context).ChangeFaverot(modell.id!);
                  },
                  child: CircleAvatar(
                    backgroundColor: ShopCubit.get(context).faverots[modell.id]! ?Colors.blue :Colors.grey.withOpacity(0.4),
                    child: Icon(Icons.favorite_border,color: Colors.white,),
                  ),
                ),
                SizedBox(height: 10,),
                 InkWell(
                  onTap: (){
                    ShopCubit.get(context).changecart(modell.id!);
                  },
                  child: CircleAvatar(
                    backgroundColor: ShopCubit.get(context).cart[modell.id]! ?Colors.blue :Colors.grey.withOpacity(0.4),
                    child: Icon(Icons.add_shopping_cart,color: Colors.white,),
                  ),
                ),
              ],
            )
            ],
            ),
          )
        ],
      ),
        Text(modell.name!,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
          fontSize: 17,
          height: 1.3
        ),),
        SizedBox(height: 10,),
         Row(
           children: [
            Text('price : ',
        style: TextStyle(
              
              fontSize: 17,
              height: 1.3
        ),),
             Text(' ${modell.price!}',
        style: TextStyle(
              color: Colors.blue,
              fontSize: 17,
              height: 1.3
        ),),
        SizedBox(width: 15,),
        Text(' ${modell.oldPrice}',
        style: TextStyle(
             color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              fontSize: 17,
              height: 1.3
        ),),
           ],
         )
        ],
  );
}
}




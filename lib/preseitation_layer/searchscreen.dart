import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/business_layer/cubit/shop_cubit.dart';
import 'package:shoppingapp/business_layer/cubit/shop_state.dart';

import '../modells/searchmodell.dart';

class SearchScreen extends StatelessWidget {
 
  var formkey = GlobalKey<FormState>();
  var searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
       
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black
            ),
            title: Text('Search',style: TextStyle(color: Colors.black),),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key:formkey ,
              child: Column(
                children: [
                  TextFormField(
                    controller: searchcontroller,
                    onChanged: (String text){
                      ShopCubit.get(context).getsearch(text);
                    },
                    decoration: InputDecoration(
                      suffix: Icon(Icons.search),
                      label: Text('Search'),
                     border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                     )
                    ),
                  ),
                  SizedBox(height: 10,),
                  if(state is SearchLoding)
                  LinearProgressIndicator(),
                  if(state is SearchSucess)
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return searchitem(ShopCubit.get(context).searchmodel!.data!.data![index], context,isoldprice: false);
                      }, 
                      separatorBuilder: (context, index) =>  Container(height: 1,width: double.infinity,color: Colors.blue,),
                       itemCount: ShopCubit.get(context).searchmodel!.data!.data!.length
                       ),
                  ),
                ],
              ),
            ),
          )
        );
      },
    );
  }
}
Widget searchitem(Product? model,context,{bool isoldprice = true}){
  return Container(
    height: 140,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
               Image(
                image: NetworkImage(model!.image!),
                width: 160,
                height: 160,
                fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                  if(model.discount != 0 && isoldprice)
                  Container(
                    height: 20,
                    color: Colors.blue,
                    child: Text('Discount',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                    ]
                  )
                  )
            ],
          ),
         SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.name!,
                            // overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 17,
                              height: 1.3
                            ),),
                            Spacer(),
                            Row(
                              children: [
                                 Text('price : ',
                              style: TextStyle(
                      
                      fontSize: 17,
                      height: 1.3
                              ),),
                     Text('${model.price!}',
                              style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      height: 1.3
                              ),),
                    //         if(model.oldPrice !=0 && isoldprice)
                    //           SizedBox(width: 15,),
                    //           Text('${model.oldPrice}',
                    //           style: TextStyle(
                    //  color: Colors.grey,
                    //   decoration: TextDecoration.lineThrough,
                    //   fontSize: 17,
                    //   height: 1.3
                    //           ),),
                              Spacer(),
                               InkWell(
                onTap: (){
                  ShopCubit.get(context).ChangeFaverot(model.id!);
                },
                child: CircleAvatar(
                  backgroundColor: ShopCubit.get(context).faverots[model.id]! ?Colors.blue :Colors.grey.withOpacity(0.4),
                  child: Icon(Icons.favorite_border,color: Colors.white,),
                ),
              )
                              ],
                            )
                      ],
                    ),
                  ),
        ],
      ),
    ),
  );
}

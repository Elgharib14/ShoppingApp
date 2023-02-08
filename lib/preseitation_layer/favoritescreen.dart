import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingapp/business_layer/cubit/shop_cubit.dart';
import 'package:shoppingapp/business_layer/cubit/shop_state.dart';
import 'package:shoppingapp/modells/getfavmodell.dart';

class FavoriteScreen extends StatelessWidget {
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
          condition: state is! GetFaverotLoding, 
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => faverotproduct(ShopCubit.get(context).getfavModel!.data!.data![index],context), 
          separatorBuilder: (context, index) => Container(height: 1,width: double.infinity,color: Colors.blue,), 
          itemCount: ShopCubit.get(context).getfavModel!.data!.data!.length
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
          );
      },
    );
  }
}

Widget faverotproduct(favData model,context){
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
                image: NetworkImage(model.product!.image!),
                width: 160,
                height: 160,
                fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                  if(model.product!.discount != 0)
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
                        Text(model.product!.name!,
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
                     Text('${model.product!.price!}',
                              style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      height: 1.3
                              ),),
                              SizedBox(width: 15,),
                              Text('${model.product!.oldPrice}',
                              style: TextStyle(
                     color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 17,
                      height: 1.3
                              ),),
                              Spacer(),
                               InkWell(
                onTap: (){
                  ShopCubit.get(context).ChangeFaverot(model.product!.id!);
                },
                child: CircleAvatar(
                  backgroundColor: ShopCubit.get(context).faverots[model.product!.id]! ?Colors.blue :Colors.grey.withOpacity(0.4),
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
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/business_layer/cubit/shop_cubit.dart';
import 'package:shoppingapp/business_layer/cubit/shop_state.dart';
import 'package:shoppingapp/data_layer/chachhelper/shardpref.dart';
import 'package:shoppingapp/data_layer/customshard/customes.dart';
import 'package:shoppingapp/data_layer/customshard/endpoint.dart';

import '../main.dart';
import 'loginScreen.dart';

class ProfileScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
       if(state is GetProfileSucess){
        namecontroller.text = state.profileModell.data!.name!;
        phonecontroller.text = state.profileModell.data!.phone!;
        emailcontroller.text = state.profileModell.data!.email!;
       }
      },
      builder: (context, state) {
        var modell = ShopCubit.get(context).profileModell;

        namecontroller.text = modell!.data!.name!;
        phonecontroller.text = modell.data!.phone!;
        emailcontroller.text = modell.data!.email!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).profileModell != null, 
          builder: (context) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key:formkey ,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is UpdateProfileLoding)
                  LinearProgressIndicator(),
                   SizedBox(height: 20,),
                  customtextform(
                    controller: namecontroller,
                    lable: 'Name', 
                    suffix: Icon(Icons.person),
                    ispssword: false
                  ),
                  SizedBox(height: 20,),
                   customtextform(
                    controller: emailcontroller,
                    lable: 'Email', 
                    suffix: Icon(Icons.email),
                    ispssword: false
                  ),
                   SizedBox(height: 20,),
                   customtextform(
                    
                    controller: phonecontroller,
                    lable: 'Phone', 
                    suffix: Icon(Icons.phone),
                    ispssword: false
                  ),
                   SizedBox(height: 20,),
                  defultButton(
                          onTap: (){
                            if(formkey.currentState!.validate()){
                              ShopCubit.get(context).UpdateProfile(
                                name: namecontroller.text, 
                                email: emailcontroller.text, 
                                phone: phonecontroller.text
                            );
                            }
                           
                          },
                          text: 'Update'
                        ),
                   SizedBox(height: 20,),
                  defultButton(
                          onTap: (){
                            shardpref.removeData(key: 'token').then((value) {
                              if(value){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LoginScreen(),));
                              }
                            }).then((value){
                              print(value);
                            });
                          },
                          text: 'signout'
                        )
                ],
              ),
            ),
          ),
        ), 
          fallback: (context) => Center(child: CircularProgressIndicator(),),
          );
         
      },
    );
  }
}

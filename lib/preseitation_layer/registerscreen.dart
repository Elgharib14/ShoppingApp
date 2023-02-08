import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingapp/business_layer/cubit/shop_cubit.dart';
import 'package:shoppingapp/business_layer/cubit/shop_state.dart';
import 'package:shoppingapp/data_layer/chachhelper/shardpref.dart';

import '../data_layer/customshard/customes.dart';
import '../data_layer/customshard/endpoint.dart';
import 'navebarscreen.dart';

class RegisterScreen extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if(state is RegisterSucessState){
          if(state.registermodel.status!){
            print(state.registermodel.status);
            Fluttertoast.showToast(
              msg: state.registermodel.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
           shardpref.SaveData(key: 'token', value: state.registermodel.data!.token).then((value){
             tokens = state.registermodel.data!.token!;
            Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                  builder: (context) => NaveBarScreen(),
                   ));
          });
          }else{
            print(state.registermodel.status);
            Fluttertoast.showToast(
              msg: state.registermodel.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              'Register',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    customtextform(
                      ispssword: false,
                      controller: emailcontroller,
                      lable: 'Email',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    customtextform(
                      ispssword: ShopCubit.get(context).ispassword,
                      controller: passwordcontroller,
                      lable: 'Passeord',
                      prefix: Icons.lock_outline,
                      suffix: IconButton(
                          onPressed: () {
                            ShopCubit.get(context).ChangePasswordVisibility();
                          },
                          icon: Icon(ShopCubit.get(context).suffix)),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    customtextform(
                      ispssword: false,
                      controller: namecontroller,
                      lable: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    customtextform(
                      ispssword: false,
                      controller: phonecontroller,
                      lable: 'Phone',
                      prefix: Icons.phone_android,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is! RegisterLodingState, 
                      builder: (context) => defultButton(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          ShopCubit.get(context).RegisterUser(
                            email: emailcontroller.text, 
                            password: passwordcontroller.text, 
                            name: namecontroller.text, 
                            phone: phonecontroller.text
                            );
                        }
                      },
                      text: 'register'.toUpperCase(),
                    ), 
                      fallback: (context) => Center(child: CircularProgressIndicator()),
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

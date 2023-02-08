import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingapp/business_layer/cubit/shop_cubit.dart';
import 'package:shoppingapp/business_layer/cubit/shop_state.dart';
import 'package:shoppingapp/data_layer/chachhelper/shardpref.dart';
import 'package:shoppingapp/data_layer/customshard/customes.dart';
import 'package:shoppingapp/data_layer/customshard/endpoint.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/preseitation_layer/navebarscreen.dart';
import 'package:shoppingapp/preseitation_layer/registerscreen.dart';

class LoginScreen extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if(state is LoginSucessState){
          if(state.loginModell.status!){
            Fluttertoast.showToast(
              msg: state.loginModell.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          shardpref.SaveData(key: 'token', value: state.loginModell.data!.token).then((value){
            tokens = state.loginModell.data!.token!;
            Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                  builder: (context) => MyApp(NaveBarScreen(),),
                   ));
          });
          
          }else{
            Fluttertoast.showToast(
              msg: state.loginModell.message!,
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
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Login and Shopping New Products',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                    ispssword:ShopCubit.get(context).ispassword ,
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
                    height: 30,
                  ),
                  ConditionalBuilder(
                    condition: state is! LoginLodingState, 
                    builder: (context) => defultButton(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        ShopCubit.get(context).LoginUser(
                          email: emailcontroller.text, 
                          password: passwordcontroller.text
                          );

                          
                      }
                      
                    },
                    text: 'login'.toUpperCase(),
                  ), 
                    fallback: (context) => Center(child: CircularProgressIndicator()),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ?',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ));
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

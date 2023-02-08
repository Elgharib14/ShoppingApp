import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/business_layer/cubit/shop_state.dart';
import 'package:shoppingapp/data_layer/diohelper/diohelper.dart';
import 'package:shoppingapp/modells/catogerymodell.dart';
import 'package:shoppingapp/modells/favemodell.dart';
import 'package:shoppingapp/modells/homemodell.dart';
import 'package:shoppingapp/modells/loginmodell.dart';

import '../../data_layer/customshard/endpoint.dart';
import '../../modells/getcartmodell.dart';
import '../../modells/changecartmodell.dart';
import '../../modells/getfavmodell.dart';
import '../../modells/profilemodell.dart';
import '../../modells/searchmodell.dart';


class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  
static ShopCubit get(context) => BlocProvider.of(context);


LoginModell? loginModell;
void LoginUser({
  required String email,
  required String password,
}){
  emit(LoginLodingState());
  DioHelper.postData(
    url: Login,
    data: {
      'email': email ,
      'password':password ,
    }
  ).then((value){
    loginModell = LoginModell.fromJson(value.data);
    // print(value.data);
    emit(LoginSucessState(loginModell!));
  }).catchError((Error){
    print('1111111');
    print(Error.toString());
    emit(LoginErrorState());
  });
}

LoginModell? registermodel;
void RegisterUser({
  required String email,
  required String password,
  required String name,
  required String phone,
}){
  emit(RegisterLodingState());
  DioHelper.postData(
    url: Register,
    data: {
      'email': email ,
      'password':password ,
      'phone': phone ,
      'name':name ,
    }
  ).then((value){
    registermodel = LoginModell.fromJson(value.data);
    
    emit(RegisterSucessState(registermodel!));
  }).catchError((Error){
    print(Error.toString());
    print('222222');
    emit(RegisterErrorState());
  });
}


IconData suffix =Icons.visibility_outlined;
bool ispassword = true;
void ChangePasswordVisibility(){
  ispassword = !ispassword;
  suffix = ispassword? Icons.visibility_off_outlined : Icons.visibility_outlined;
  emit(ChangepasswordState());
}


int currentIndex = 0;
void Chanescreen(index){
  currentIndex = index;
  emit(ChangeScreenState());
}


Map<int , bool> faverots ={};
Map<int , bool> cart ={};
HomeModell? homeModell;
void getHomeData(){
  DioHelper.getdata(
    url: Home,
    token: tokens
  ).then((value){
    homeModell = HomeModell.fromJson(value.data);
    homeModell!.data!.products!.forEach((element) {
      faverots.addAll({
        element.id! : element.inFavorites! 
      });
    },);
    homeModell!.data!.products!.forEach((element) {
      cart.addAll({
        element.id! : element.inCart! 
      });
    },);
    // print(cart.toString());
    emit(GetHomeDataSucess());
  }).catchError((Error){
    print('1111111');
    print(Error.toString());
    emit(GetHomeDataError());
  });
}

CatogryModell ? catogryModell;
void getCategoryData(){
  DioHelper.getdata(
    url: Catogry,
    token: tokens,
    ).then((value){
      catogryModell = CatogryModell.fromJson(value.data);
      // print(value.data);
    }).catchError((Error){
      print('22222222');
      print(Error.toString());
    });
}
ChangefavModell? modell;
void ChangeFaverot(dynamic productid){
  faverots[productid] = !faverots[productid]! ;
  emit(ChangeFaverotstate());
  DioHelper.postData(
    url: Faverots,
    token: tokens,
    data: {
      'product_id':productid
    }
    ).then((value){
      modell = ChangefavModell.fromJson(value.data);
      // print(value.data);

      if(!modell!.status!){
        faverots[productid] = !faverots[productid]! ;
      }else{
        getfaverot();
      }

      emit(ChangeFaverotSucess(modell!));
    }).catchError((Error){
      faverots[productid] = !faverots[productid]! ;
      print(Error.toString());
      emit(ChangeFaverotError());
    });
}

GetfavModel? getfavModel;
void getfaverot(){
  emit(GetFaverotLoding());
  DioHelper.getdata(
    url:Faverots,
    token: tokens
    ).then((value){
      getfavModel = GetfavModel.fromJson(value.data);
      // print(value.data);
      emit(GetfaverotSucess());
    }).catchError((Error){
      print('333333');
      print(Error.toString());
      emit(GetFaverotError());
    });
}

ChangecartModell? changecartModell;
void changecart(dynamic productid){
  cart[productid] = !cart[productid]!;
  emit(ChangecartState());
  DioHelper.postData(
    url: Carts,
    token: tokens,
    data: {
      'product_id':productid
    }
    ).then((value){
      changecartModell = ChangecartModell.fromJson(value.data);
      print(value.data);
      if(!changecartModell!.status!){
        cart[productid] = !cart[productid]!;
      } else{
        getcart();
      }
      emit(ChangeCartSucess(changecartModell!));
    }).catchError((Error){
      cart[productid] = !cart[productid]!;
      print('00000000');
      print(Error.toString());
      emit(ChangeCartError());
    });
}
GetCartModell ? getCartModell;
void getcart(){
  emit(GetCartLoding());
  DioHelper.getdata(
    url: Carts,
    token: tokens
    ).then((value){
      getCartModell = GetCartModell.fromJson(value.data);
      // print(value.data);
      emit(GetCartSucess());
    }).catchError((Error){
      print('4444444');
      emit(GetCartError());
      print(Error.toString());
    });
}

SearchModel? searchmodel;
void getsearch(String text){
  emit(SearchLoding());
  DioHelper.postData(
    url: Search,
    data: {
      'text':text
    }
    ).then((value){
      searchmodel = SearchModel.fromJson(value.data);
      print(value.data);
      emit(SearchSucess());
    }).catchError((Error){
      emit(SearchError());
      print(Error.toString());
    });
}


ProfileModell ? profileModell;
void getProfile(){
  emit(GetProfileLoding());
  DioHelper.getdata(
    url: Profile,
    token: tokens
    ).then((value){
      profileModell = ProfileModell.fromJson(value.data);
      print(value.data);
      emit(GetProfileSucess(profileModell!));
    }).catchError((Error){
      emit(GetProfileError());
      print('555555');
      print(Error.toString());
    });
}


void UpdateProfile({
  required String name,
  required String email,
  required String phone,
  
}){
  emit(UpdateProfileLoding());
  DioHelper.puttData(
    url: updateProfile,
    token: tokens,
    data: {
      'name':name ,
      'phone': phone,
      'email': email,
    }
    ).then((value){
      profileModell = ProfileModell.fromJson(value.data);
      print(value.data);
      emit(UpdateProfileSucess(profileModell!));
    }).catchError((Error){
      emit(UpdateProfileError());
      print('555555');
      print(Error.toString());
    });
}

}

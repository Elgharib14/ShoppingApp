import 'package:shoppingapp/modells/favemodell.dart';
import 'package:shoppingapp/modells/loginmodell.dart';
import 'package:shoppingapp/modells/profilemodell.dart';

import '../../modells/changecartmodell.dart';

abstract class ShopState {}

class ShopInitial extends ShopState {}

class LoginLodingState extends ShopState {}

class LoginSucessState extends ShopState {
  final LoginModell loginModell;

  LoginSucessState(this.loginModell);
}

class LoginErrorState extends ShopState {}

class ChangepasswordState extends ShopState {}

class RegisterLodingState extends ShopState {}

class RegisterSucessState extends ShopState {
  final LoginModell registermodel;

  RegisterSucessState(this.registermodel);
}

class RegisterErrorState extends ShopState {}

class ChangeScreenState extends ShopState {}

class GetHomeDataSucess extends ShopState {}

class GetHomeDataError extends ShopState {}

class ChangeFaverotSucess extends ShopState {
  final ChangefavModell changefavModell ;

  ChangeFaverotSucess(this.changefavModell);
}

class ChangeFaverotstate extends ShopState {}

class ChangeFaverotError extends ShopState {}

class GetfaverotSucess extends ShopState {}

class GetFaverotError extends ShopState {}

class GetFaverotLoding extends ShopState {}

class ChangecartState extends ShopState {
 
}

class ChangeCartError extends ShopState {}

class ChangeCartSucess extends ShopState {
   final ChangecartModell changecartModell;

  ChangeCartSucess(this.changecartModell);
}

class GetCartError extends ShopState {}

class GetCartLoding extends ShopState {}

class GetCartSucess extends ShopState {}

class SearchLoding extends ShopState {}

class SearchSucess extends ShopState {}

class SearchError extends ShopState {}

class GetProfileLoding extends ShopState {}

class GetProfileSucess extends ShopState {
  final ProfileModell profileModell;

  GetProfileSucess(this.profileModell);
}

class GetProfileError extends ShopState {}

class UpdateProfileLoding extends ShopState {}

class UpdateProfileSucess extends ShopState {
  final ProfileModell profileModell;

  UpdateProfileSucess(this.profileModell);
}

class UpdateProfileError extends ShopState {}
part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class SignInDetails extends SignInEvent {
  UserModel userModel;
  SignInDetails(this.userModel);
}

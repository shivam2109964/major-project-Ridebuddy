part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignUpDetails extends SignupEvent {
  UserModel userModel;
  SignUpDetails(this.userModel);
}

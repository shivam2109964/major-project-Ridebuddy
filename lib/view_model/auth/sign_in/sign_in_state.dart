part of 'sign_in_bloc.dart';

abstract class SignInState {}

final class SignInInitial extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInDoneState extends SignInState {}

class SignInErrorState extends SignInState {
  String message;
  SignInErrorState(this.message);
}

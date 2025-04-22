part of 'signup_bloc.dart';

abstract class SignupState {}

final class SignupInitial extends SignupState {}

class SignUpLoadingState extends SignupState {}

class SignUpDoneState extends SignupState {}

class SignUpError extends SignupState {
  String message;
  SignUpError(this.message);
}

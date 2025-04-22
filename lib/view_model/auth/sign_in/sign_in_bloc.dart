import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ridebuddy/model/userModel.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInDetails>(
      (event, emit) async {
        try {
          emit(SignInLoadingState());
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.userModel.email,
            password: event.userModel.password,
          );
          emit(SignInDoneState());
        } on FirebaseAuthException catch (e) {
          switch (e.code) {
            case "invalid-email":
              emit(
                SignInErrorState("The email address provided is not valid"),
              );
              break;
            case "user-not-found":
              emit(
                SignInErrorState("User not found"),
              );
              break;
            case "wrong-password":
              emit(
                SignInErrorState("Incorrect password."),
              );
              break;
            case "too-many-requests":
              emit(
                SignInErrorState(
                    "Due to unusual activity login failed try later"),
              );
              break;
            case "internal-error":
              emit(
                SignInErrorState("An unexpected database server error"),
              );
              break;

            default:
              emit(
                SignInErrorState(
                    "An unexpected error occurred: ${e.toString()}"),
              );
          }
        } catch (e) {
          emit(SignInErrorState("An error occurred: ${e.toString()}"));
        }
      },
    );
  }
}

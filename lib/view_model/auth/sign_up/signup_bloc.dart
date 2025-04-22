import 'package:bloc/bloc.dart';
import 'package:ridebuddy/model/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SignupBloc() : super(SignupInitial()) {
    on<SignUpDetails>(
      (event, emit) async {
        try {
          emit(SignUpLoadingState());
          await firebaseAuth.createUserWithEmailAndPassword(
            email: event.userModel.email,
            password: event.userModel.password,
          );
          emit(SignUpDoneState());
        } on FirebaseAuthException catch (e) {
          switch (e.code) {
            case "invalid-email":
              emit(
                SignUpError("Invalid email format."),
              );

            case "email-already-in-use":
              emit(
                SignUpError("This email is already in use."),
              );

            case "weak-password":
              emit(
                SignUpError("Your password is week."),
              );

            case "invalid-credential":
              emit(
                SignUpError("The credentials provided are invalid"),
              );

            case "network-request-failed":
              emit(
                SignUpError("Network error. Check your connection."),
              );

            case "unknown":
              emit(
                SignUpError("An unexpected error occurred"),
              );

            case "user-disabled":
              emit(
                SignUpError("The user's account has been disable by an admin"),
              );

            case "internal-error":
              emit(
                SignUpError("An internal database server issue occurred"),
              );

            default:
              emit(
                SignUpError("An error occurred: ${e.message}"),
              );
          }
        } catch (e) {
          emit(
            SignUpError("An unexpected error occurred ${e.toString()}"),
          );
        }
      },
    );
  }
}

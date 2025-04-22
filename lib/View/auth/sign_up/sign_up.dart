import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridebuddy/model/userModel.dart';
import 'package:ridebuddy/view/auth/sign_in/sign_in.dart';
import 'package:ridebuddy/screens/home_screen.dart';
import 'package:ridebuddy/view_model/auth/sign_up/signup_bloc.dart';

class SignUp extends StatefulWidget {
  static const String routeNamed = "/Sign-Up";
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmEditingController = TextEditingController();
  late UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: Text.rich(
          style: GoogleFonts.philosopher(
            fontWeight: FontWeight.w700,
          ),
          const TextSpan(
            children: [
              TextSpan(text: "Ride"),
              TextSpan(
                text: "Buddy",
                style: TextStyle(
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignUpLoadingState) {
            const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SignUpDoneState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          } else if (state is SignUpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<SignupBloc, SignupState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Sign Up",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: emailEditingController,
                          enabled: true,
                          decoration: InputDecoration(
                            enabled: true,
                            filled: true,
                            labelText: "Email",
                            labelStyle: GoogleFonts.poppins(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 30,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: passwordEditingController,
                          enabled: true,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabled: true,
                            filled: true,
                            labelText: "Password",
                            labelStyle: GoogleFonts.poppins(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 30,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: confirmEditingController,
                          enabled: true,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabled: true,
                            filled: true,
                            labelText: "Confirm Password",
                            labelStyle: GoogleFonts.poppins(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 30,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            String email = emailEditingController.text;
                            String password = passwordEditingController.text;
                            String confirmPassword =
                                confirmEditingController.text;
                            user = UserModel(email: email, password: password);
                            if (password == confirmPassword) {
                              BlocProvider.of<SignupBloc>(context).add(
                                SignUpDetails(user),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Passwords do NOT match"),
                                ),
                              );
                            }
                            emailEditingController.clear();
                            passwordEditingController.clear();
                            confirmEditingController.clear();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: const BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "or",
                          style: GoogleFonts.poppins(),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, SignIn.routeNamed);
                          },
                          child: Text.rich(
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                            const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Already have an ",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "account?",
                                  style: TextStyle(
                                    color: Colors.orange,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

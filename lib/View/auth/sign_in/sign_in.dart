import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridebuddy/model/userModel.dart';
import 'package:ridebuddy/screens/home_screen.dart';
import 'package:ridebuddy/view/auth/sign_up/sign_up.dart';
import 'package:ridebuddy/view_model/auth/sign_in/sign_in_bloc.dart';

class SignIn extends StatefulWidget {
  static const String routeNamed = '/Sign-page';
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Sign In",
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
                Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: Text(
                      "Forget Password ?",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocConsumer<SignInBloc, SignInState>(
                  listener: (context, state) {
                    if (state is SignInLoadingState) {
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SignInDoneState) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                    } else if (state is SignInErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return BlocBuilder<SignInBloc, SignInState>(
                      builder: (context, state) {
                        return MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            String email = emailEditingController.text;
                            String password = passwordEditingController.text;
                            user = UserModel(email: email, password: password);
                            BlocProvider.of<SignInBloc>(context).add(
                              SignInDetails(user),
                            );
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
                                "Sign In",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
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
                    Navigator.pushReplacementNamed(context, SignUp.routeNamed);
                  },
                  child: Text.rich(
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                    ),
                    const TextSpan(
                      children: [
                        TextSpan(
                          text: "Create ",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Account",
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
      ),
    );
  }
}

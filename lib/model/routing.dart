import 'package:flutter/material.dart';
import 'package:ridebuddy/view/auth/sign_in/sign_in.dart';
import 'package:ridebuddy/view/auth/sign_up/sign_up.dart';

import 'package:ridebuddy/view/welcome_page/welcome_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Welcome.routeName:
      return MaterialPageRoute(
        builder: (_) => const Welcome(),
      );
    case SignIn.routeNamed:
      return MaterialPageRoute(
        builder: (_) => const SignIn(),
      );
    case SignUp.routeNamed:
      return MaterialPageRoute(
        builder: (_) => const SignUp(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen does not exist"),
          ),
        ),
      );
  }
}

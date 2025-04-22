import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, MultiBlocProvider;
import 'package:ridebuddy/View/welcome_page/welcome_page.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ridebuddy/firebase_options.dart';
import 'package:ridebuddy/model/routing.dart';
import 'package:ridebuddy/view_model/auth/sign_in/sign_in_bloc.dart';
import 'package:ridebuddy/view_model/auth/sign_up/signup_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const Welcome(),
      ),
    );
  }
}

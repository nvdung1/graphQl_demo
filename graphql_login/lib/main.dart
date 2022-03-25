import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:graphql_login/home/home_state_notifier.dart';
import 'package:graphql_login/login/login_screen.dart';
import 'package:graphql_login/login/login_state_notifier.dart';
import 'package:graphql_login/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
      StateNotifierProvider(
        create: (_) => LoginStateNotifier(),
      ),
      StateNotifierProvider(
        create: (_) => HomeStateNotifier(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

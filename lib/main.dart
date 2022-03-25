import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:graphql_login/homepage.dart';
import 'package:graphql_login/login_page.dart';
import 'package:graphql_login/provider/provider.dart';
import 'package:graphql_login/states/login_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      StateNotifierProvider<HomeProvider, LoginState>(create: (_) =>HomeProvider())
    ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getScreen(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  context.watch<LoginState>() is LoginStateSuccess? const HomePage():LoginPage(),
    );
  }
  Future<void> getScreen(BuildContext context) async{
    await Provider.of<HomeProvider>(context,listen: false).isLogin();
  } 
 
}

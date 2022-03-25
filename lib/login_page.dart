
// ignore_for_file: must_be_immutable, avoid_print, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:graphql_login/provider/provider.dart';
import 'package:graphql_login/states/login_state.dart';
import 'package:provider/provider.dart';
import 'graphql/queries.dart';
import 'homepage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final Queries query = Queries();
  bool  isLoginFalse = false;
  bool showLoading= false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: SingleChildScrollView(
            child: showLoading? const Center(child: CircularProgressIndicator(),): loginWidget(context),
          ),
        ),
      ),
    );
  }
  Widget loginWidget(BuildContext context){

    return Column(
      children: [
        Center(
            child: Image.asset("assets/images/graphQl.png",)
        ),
        const SizedBox(height: 20.0),
        context.watch<LoginState>() is LoginStateFailure? warningBox():const SizedBox(height: 30.0) ,
        TextField(
          keyboardType: TextInputType.name,
          autofocus: false,
          controller: userNameController,
          decoration:  InputDecoration(
            hintText: "User Name",
            border:  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            hintStyle: const TextStyle(fontSize: 13, fontFamily: 'UTM',fontWeight: FontWeight.w400,color: Color.fromRGBO(51, 51, 51, 0.5)),
          ),
        ),
        const SizedBox(height: 20.0),
        TextField(
          keyboardType: TextInputType.text,
          // obscureText: true,
          autofocus: false,
          controller: passwordController,
          decoration:  InputDecoration(
            hintText: "Password",
            border:  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            hintStyle: const TextStyle(fontSize: 13, fontFamily: 'UTM',fontWeight: FontWeight.w400,color: Color.fromRGBO(51, 51, 51, 0.5)),
          ),
        ),
        const SizedBox(height: 50.0),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color.fromRGBO(51, 51, 51, 1)),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
              minimumSize: const Size(343,53)
          ),
          onPressed: () async{
            await context.read<HomeProvider>().fetchProfile(userNameController.text, passwordController.text).then((value){
              if( Provider.of<LoginState>(context,listen: false) is LoginStateSuccess){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                }
            });
          },
          child: const Text("ĐĂNG NHẬP",style: TextStyle(fontSize: 15, fontFamily: 'UTM', fontWeight: FontWeight.w400,color: Color.fromRGBO(51, 51, 51, 1))),
        ),
      ],
    );
  }
  Widget warningBox(){
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      margin:  const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: const Center(
        child:  Text("Tài khoản hoặc mật khẩu không chính xác"),
      ),
    );
    }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_login/models/user.dart';
import 'package:graphql_login/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'graphql/queries.dart';
import 'homepage.dart';
// TODO:(dungnv): install lint package and fix all warning
// source: https://pub.dev/packages/flutter_lints
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late User user;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Queries query = Queries();
   bool  isLoginFalse = false;
   bool showLoading= false;
   Future onSub() async{
     await context.read<UserProvider>().fetchProfile(userNameController.text.toString(), passwordController.text).then((value){
       if(Provider.of<UserProvider>(context,listen: false).isLogin){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
       }
       // // TODO:(dungnv): use provider instead of setState
       setState(() {
         isLoginFalse= !Provider.of<UserProvider>(context,listen: false).isLogin;
       });
     });
   }
  @override
  Widget build(BuildContext context) {
    // TODO:(dungnv): remove print or unncessary comment, use log instead if need
    //print(isLoginFalse);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: SingleChildScrollView(
            child: showLoading? const Center(child: CircularProgressIndicator(),): loginWidget(),
          ),
        ),
      ),
    );
  }
  Widget loginWidget(){
    return Column(
      children: [
        Center(
            child: Image.asset("assets/images/graphQl.png",)
        ),
        const SizedBox(height: 20.0),
        isLoginFalse? warningBox():const SizedBox(height: 30.0) ,

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
          keyboardType: TextInputType.name,
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
          onPressed: (){
              onSub();
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

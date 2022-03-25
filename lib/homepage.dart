import 'package:flutter/material.dart';
import 'package:graphql_login/login_page.dart';
import 'package:graphql_login/provider/provider.dart';
import 'package:graphql_login/states/login_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // User user = Provider.of<UserProvider>(context).user;
    // user.about ??= "about";
   fetchValue(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text("THÔNG TIN CÁ NHÂN",style: TextStyle(fontSize: 15, fontFamily: 'UTM', fontWeight: FontWeight.w700,color: Color(0xff333333))),
          actions: [
            IconButton(
                onPressed:()async{
                  await Provider.of<HomeProvider>(context,listen: false).destroySession().then((value) {
                    if( Provider.of<LoginState>(context,listen: false)  is  LoginStateInital){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  });
                  
                },
                icon: const Icon(Icons.logout,color: Colors.black,)
            )
          ],

      ),
      body: Column(
        children: const [
          // rowContent("User Name: ", user.name),
          // rowContent("User Id: ", user.id.toString()),
          // rowContent("About: ", user.about??" ")
          Center(child: Text("Login"),)
        ],
      ),
    );
  }
  Future fetchValue(BuildContext context) async{
    await Provider.of<HomeProvider>(context,listen: false).fetchBulletins();
  }
  Widget rowContent(String nameContent, String content){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox( width: 100,child: Text("$nameContent: ")),
        Flexible(child: Text(content)),
      ],
    );
  }
}

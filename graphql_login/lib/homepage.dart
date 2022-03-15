import 'package:flutter/material.dart';
import 'package:graphql_login/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    user.about ??= "about";

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text("THÔNG TIN CÁ NHÂN",style: TextStyle(fontSize: 15, fontFamily: 'UTM', fontWeight: FontWeight.w700,color: Color(0xff333333))),

      ),
      body: Column(
        children: [
          rowContent("User Name: ", user.name),
          rowContent("User Id: ", user.id.toString()),
          rowContent("About: ", user.about??" ")
        ],
      ),
    );
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

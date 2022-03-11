

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graphql_login/provider/user_provider.dart';
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
          title: const Text("THÔNG TIN CÁ NHÂN",style: TextStyle(fontSize: 15, fontFamily: 'UTM', fontWeight: FontWeight.w700,color: Color.fromRGBO(51, 51, 51, 1))),

      ),
      body: Column(
        children: [
          Row(
            
            children: [
              const SizedBox( width: 100,child: Text("User Name: ")),
              Text(user.name),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 100,child:  Text("User Id: ")),
              Text(user.id.toString()),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 100,child: Text("About: ")),
              Flexible(child: Text(user.about??" ")),
            ],
          ),
        ],
      ),

    );
  }
}

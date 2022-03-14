

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
          // TODO(dungnv): use hex color instead of RGB ti simplify and declare common color in a class
          title: const Text("THÔNG TIN CÁ NHÂN",style: TextStyle(fontSize: 15, fontFamily: 'UTM', fontWeight: FontWeight.w700,color: Color.fromRGBO(51, 51, 51, 1))),

      ),
      body: Column(
        children: [
          // TODO(dungnv): same code -> should reuse Row
          Row(
            // TODO(dungnv): clean code, remove unnecessary line
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

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_login/config/client.dart';
import 'package:graphql_login/graphql/queries.dart';
import 'package:graphql_login/models/user.dart';

class UserProvider with ChangeNotifier{
  final Queries query = Queries();
  bool isLogin= true;
  late User user;

  Future fetchProfile(String userName, String password) async {
    GraphQLClient _client = Config().graphQLClient();
    QueryResult result = await _client.query(QueryOptions( document: gql(query.queryUser(userName, password))));
    if (result.hasException) {
      isLogin= false;
    } else if (!result.hasException) {
      if(result.data == null){
        isLogin= false;
      }else{
        user =  User.fromJson(result.data);
        isLogin= true;
        }
    }
    notifyListeners();
  }
}
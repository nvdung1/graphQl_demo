import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_login/config/client.dart';
import 'package:graphql_login/graphql/queries.dart';
import 'package:graphql_login/models/user.dart';

class UserProvider with ChangeNotifier{
  // TODO(dungnv): should declare in order constant ->  final -> late -> var
  final Queries query = Queries();
  late bool isLogin;
  bool isLoading = false;
  late User user;
  // TODO(dungnv): should enter here
  Future fetchProfile(String userName, String password) async {
    GraphQLClient _client = Config().graphQLClient();
    QueryResult result = await _client.query(QueryOptions( document: gql(query.queryUser(userName, password))));
    // if(result.isLoading){
    //   isLoading=!isLoading;
    // }
    // TODO(dungnv): should enter here
    if (result.hasException) {
      isLogin= false;
    } else if (!result.hasException) {
      // TODO(dungnv): null safety data, avoid use force not null ! without check null
       user =  User.fromJson(result.data!);
       isLogin = true;
    }
    notifyListeners();
  }
}
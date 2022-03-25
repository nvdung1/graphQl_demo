// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_login/config/client.dart';
import 'package:graphql_login/graphql/queries.dart';
import 'package:graphql_login/models/storage_item.dart';
import 'package:graphql_login/services/storage_service.dart';

class UserProvider with ChangeNotifier{
  final Queries query = Queries();
  final StorageService _storageService = StorageService();
  
  bool isLogin= true;
  // late User user;
  final GraphQLClient _client = Config().graphQLClient();
  Future fetchProfile(String userName, String password) async {

    QueryResult result = await _client.query(QueryOptions( document: gql(query.mutationLogin(userName, password))));
    if (result.hasException) {
      isLogin= false;
    } else if (!result.hasException) {
      if(result.data == null){
        isLogin= false;
      }
      else if(result.data!["createSession"]["session"]["token"]== null){
        print(await _storageService.readSecureData('token'));
        isLogin= false;
      }
      else{
        String token = result.data!["createSession"]["session"]["token"];
        StorageItem storageItem =StorageItem("token", token);
         await _storageService.writeSecureData(storageItem);
        Config.setToken(token);
        isLogin= true;
        }
    }
    notifyListeners();
  }
  Future fetchBulletins() async{

    QueryResult result = await Config().graphQLClient().query(QueryOptions(document: gql(query.queryBulletins())));
    if(result.hasException){
       print(result.exception);
    }else{
      print(result.data);
    }
    notifyListeners();
  }
  Future destroySession() async{
    QueryResult result = await Config().graphQLClient().query(QueryOptions(document: gql(query.mutationDestroySession())));
    if(result.hasException){
      print(result.exception);
    }else{
      await _storageService.deleteSecureData('token');
      
    }
  }
}
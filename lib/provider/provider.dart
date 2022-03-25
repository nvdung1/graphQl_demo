import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_login/config/client.dart';
import 'package:graphql_login/graphql/queries.dart';
import 'package:graphql_login/models/storage_item.dart';
import 'package:graphql_login/services/storage_service.dart';
import 'package:graphql_login/states/login_state.dart';
import 'package:state_notifier/state_notifier.dart';

class HomeProvider extends StateNotifier<LoginState>{
  HomeProvider() : super(LoginStateInital());
  final Queries query = Queries();
  final StorageService _storageService = StorageService();
  final GraphQLClient _client = Config().graphQLClient();
  
  // late User user;
  Future<void> isLogin()async{
    if(( await _storageService.readSecureData('token')) == null) {
      state= LoginStateInital();
      print("state login: $state");
    }else{
      state =LoginStateSuccess();
      print( await _storageService.readSecureData('token'));
      // print(state);
    }
  }

  Future fetchProfile(String userName, String password) async {
    QueryResult result = await _client.query(QueryOptions( document: gql(query.mutationLogin(userName, password))));
    if (result.hasException) {
      state= LoginStateFailure();
    } else if (!result.hasException) {
      if(result.data == null){
        state= LoginStateFailure();
      }
      else if(result.data!["createSession"]["session"]["token"]== null){
         state = LoginStateFailure();
        // state= false;
        // print(state);
      }
      else{
        StorageItem storageItem =StorageItem("token", result.data!["createSession"]["session"]["token"]);
        await _storageService.writeSecureData(storageItem);
        Config.setToken(result.data!["createSession"]["session"]["token"]);
        state= LoginStateSuccess();
      }
    }
  }
  Future fetchBulletins() async{

    QueryResult result = await Config().graphQLClient().query(QueryOptions(document: gql(query.queryBulletins())));
    if(result.hasException){
      print(result.exception);
    }else{
      print(result.data);
    }
  }
  Future destroySession() async{
    QueryResult result = await Config().graphQLClient().query(QueryOptions(document: gql(query.mutationDestroySession())));
    if(result.hasException){
      print("lỗi: ${result.exception}");
    }else{
      await _storageService.deleteSecureData('token');
      state= LoginStateInital();
    }
  }
}
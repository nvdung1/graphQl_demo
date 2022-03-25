
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
class Config {
  static Link? link ;
  static HttpLink httpLink= HttpLink("https://kanri-owner-dev1.chintaidx.com/graphql");
  static void setToken(String token){
    AuthLink authLink = AuthLink(
      headerKey: 'Token', getToken: () async => token);
    Config.link  = authLink.concat(Config.httpLink);
  }
  static Link getLink() {
    return Config.link ?? Config.httpLink;
  }
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: getLink(),
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );
  GraphQLClient graphQLClient(){
    return GraphQLClient(
        link: getLink(),
        cache: GraphQLCache(store: InMemoryStore())
    );
  }


}
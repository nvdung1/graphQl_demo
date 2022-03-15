
import 'package:graphql_flutter/graphql_flutter.dart';
class Config{
  static final HttpLink httpLink= HttpLink("https://graphql.anilist.co");

  GraphQLClient graphQLClient(){
    return GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore())
    );
  }



}
import 'package:artemis/schema/graphql_query.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_login/config/keys_storage.dart';
import 'package:graphql_login/data/api/common_entity/network_resource_state.dart';

// return result from network and save to cache.
final networkOnlyPolicies = Policies(fetch: FetchPolicy.networkOnly);

GraphQLClient _buildClient({String? uri}) {
  final httpLink = HttpLink(uri!);
  final newAuthLink = AuthLink(
      headerKey: 'Token',
      getToken: () async {
        // Get token from storage
        const storage = FlutterSecureStorage();
        final value = await storage.read(key: KeysStorage.secureToken);
        return value;
      });

  final link = newAuthLink.concat(httpLink);

  return GraphQLClient(
      link: link,
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
          watchQuery: networkOnlyPolicies,
          query: networkOnlyPolicies,
          mutate: networkOnlyPolicies));
}

class GraphQLApiClient {
  GraphQLApiClient({required String uri}) : client = _buildClient(uri: uri);
  final GraphQLClient client;

  Future<NetworkResourceState<T>> query<T>(GraphQLQuery query) async {
    final result = await client.query(QueryOptions(
        document: query.document,
        variables: query.variables == null ? {} : query.variables!.toJson()));

    final data = query.parse(result.data as Map<String, dynamic>) as T;
    return NetworkResourceState<T>(data);
  }

  Future<QueryResult> mutationRaw(GraphQLQuery query) async {
    final result = await client.mutate(MutationOptions(
        document: query.document,
        variables: query.variables == null ? {} : query.variables!.toJson()));
    return result;
  }
}

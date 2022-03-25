import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_login/config/graphql_client.dart';
import 'package:graphql_login/config/keys_storage.dart';
import 'package:graphql_login/data/api/common_entity/network_resource_state.dart';
import 'package:graphql_login/generated/graphql_api.graphql.dart';
import 'package:graphql_login/login/login_state.dart';
import 'package:state_notifier/state_notifier.dart';

class LoginStateNotifier extends StateNotifier<LoginState> with LocatorMixin {
  final Future<void> Function()? onLoginSuccessful;
  final Future<void> Function()? onLoginFailed;

  LoginStateNotifier({this.onLoginSuccessful, this.onLoginFailed})
      : super(const LoginState());

  Future<void> login(String loginId, String password) async {
    state = state.copyWith(showLoadingIndicator: true);
    final result = await _callLoginApi(loginId, password);
    result.maybeWhen((data) async {
      String token = data?.createSession?.session.token ?? '';
      String userId = data?.createSession?.session.userId ?? '';

      await _saveSession(token, userId);

      print(token);

      onLoginSuccessful!();
    }, orElse: () {
      onLoginFailed!();
    });
  }

  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    final clientMutationId = await storage.read(key: KeysStorage.userId);

    final query = DestroySessionMutation(
      variables: DestroySessionArguments(clientMutationId: clientMutationId!),
    );

    await GraphQLApiClient(uri: KeysStorage.serverUri).mutationRaw(query);

    await _destroySession();
  }

  Future<NetworkResourceState<CreateSession$Mutation>> _callLoginApi(
      String loginId, String password) async {
    final graphQLApiClient = GraphQLApiClient(uri: KeysStorage.serverUri);

    final query = CreateSessionMutation(
      variables: CreateSessionArguments(
        loginId: loginId,
        password: password,
      ),
    );

    final result = await graphQLApiClient.mutationRaw(query);

    if (result.data == null) {
      return NetworkResourceState.error([]);
    }
    Map<String, dynamic>? dataResult;
    if (result.data is Map<String, dynamic>) {
      dataResult = result.data;
    }
    final data = query.parse(dataResult!);
    return NetworkResourceState(data);
  }

  Future<void> _saveSession(String token, String userId) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: KeysStorage.secureToken, value: token);
    await storage.write(key: KeysStorage.userId, value: userId);
  }

  Future<void> _destroySession() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: KeysStorage.secureToken);
    await storage.delete(key: KeysStorage.userId);
  }
}

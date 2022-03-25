import 'package:graphql_login/config/graphql_client.dart';
import 'package:graphql_login/data/api/common_entity/network_resource_state.dart';
import 'package:graphql_login/generated/graphql_api.graphql.dart';
import 'package:graphql_login/home/home_state.dart';
import 'package:state_notifier/state_notifier.dart';

class HomeStateNotifier extends StateNotifier<HomeState> with LocatorMixin {
  HomeStateNotifier() : super(const HomeState());

  @override
  void initState() {
    super.initState();

    _fetchHomeData();
  }

  Future<void> _fetchHomeData() async {
    final graphQLApiClient =
        GraphQLApiClient(uri: 'http://150.95.115.19:1629/graphql');

    state = state.copyWith(data: NetworkResourceState.loading());

    final result = await graphQLApiClient.query<Home$Query>(HomeQuery());

    print(result);

    state = state.copyWith(data: result);
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_login/data/api/common_entity/network_resource_state.dart';
import 'package:graphql_login/generated/graphql_api.graphql.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    NetworkResourceState<Home$Query>? data,
  }) = _HomeState;
}

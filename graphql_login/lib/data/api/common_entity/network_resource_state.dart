import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_resource_state.freezed.dart';

@freezed
abstract class NetworkResourceState<T> with _$NetworkResourceState<T> {
  factory NetworkResourceState(T? data) = _Data<T>;
  factory NetworkResourceState.loading() = _Loading<T>;
  factory NetworkResourceState.error(List<T>? errors) = _ErrorDetails<T>;
}

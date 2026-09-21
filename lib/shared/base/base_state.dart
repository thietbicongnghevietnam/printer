import 'package:smart_warehouse/shared/common/error_entity.dart';

abstract class BaseState with StateMixin {
  BaseState({
    required this.pageStatus,
    required this.processing,
    required this.errorEntity,
  });

  final PageStatus pageStatus;
  final bool processing;
  final ErrorEntity? errorEntity;
}

enum PageStatus { initial, loading, loaded, error, loadMore }

mixin StateMixin<S> {
  S get copyWith;
}

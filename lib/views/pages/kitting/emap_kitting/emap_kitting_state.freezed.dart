// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emap_kitting_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EmapKittingState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  EMapWidget? get floor => throw _privateConstructorUsedError;
  List<OrderBlock> get orderBlock => throw _privateConstructorUsedError;
  List<SuggestPath> get suggestPath => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EmapKittingStateCopyWith<EmapKittingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmapKittingStateCopyWith<$Res> {
  factory $EmapKittingStateCopyWith(
          EmapKittingState value, $Res Function(EmapKittingState) then) =
      _$EmapKittingStateCopyWithImpl<$Res, EmapKittingState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      EMapWidget? floor,
      List<OrderBlock> orderBlock,
      List<SuggestPath> suggestPath});
}

/// @nodoc
class _$EmapKittingStateCopyWithImpl<$Res, $Val extends EmapKittingState>
    implements $EmapKittingStateCopyWith<$Res> {
  _$EmapKittingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? floor = freezed,
    Object? orderBlock = null,
    Object? suggestPath = null,
  }) {
    return _then(_value.copyWith(
      pageStatus: null == pageStatus
          ? _value.pageStatus
          : pageStatus // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as bool,
      errorEntity: freezed == errorEntity
          ? _value.errorEntity
          : errorEntity // ignore: cast_nullable_to_non_nullable
              as ErrorEntity?,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as EMapWidget?,
      orderBlock: null == orderBlock
          ? _value.orderBlock
          : orderBlock // ignore: cast_nullable_to_non_nullable
              as List<OrderBlock>,
      suggestPath: null == suggestPath
          ? _value.suggestPath
          : suggestPath // ignore: cast_nullable_to_non_nullable
              as List<SuggestPath>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmapKittingStateImplCopyWith<$Res>
    implements $EmapKittingStateCopyWith<$Res> {
  factory _$$EmapKittingStateImplCopyWith(_$EmapKittingStateImpl value,
          $Res Function(_$EmapKittingStateImpl) then) =
      __$$EmapKittingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      EMapWidget? floor,
      List<OrderBlock> orderBlock,
      List<SuggestPath> suggestPath});
}

/// @nodoc
class __$$EmapKittingStateImplCopyWithImpl<$Res>
    extends _$EmapKittingStateCopyWithImpl<$Res, _$EmapKittingStateImpl>
    implements _$$EmapKittingStateImplCopyWith<$Res> {
  __$$EmapKittingStateImplCopyWithImpl(_$EmapKittingStateImpl _value,
      $Res Function(_$EmapKittingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? floor = freezed,
    Object? orderBlock = null,
    Object? suggestPath = null,
  }) {
    return _then(_$EmapKittingStateImpl(
      pageStatus: null == pageStatus
          ? _value.pageStatus
          : pageStatus // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as bool,
      errorEntity: freezed == errorEntity
          ? _value.errorEntity
          : errorEntity // ignore: cast_nullable_to_non_nullable
              as ErrorEntity?,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as EMapWidget?,
      orderBlock: null == orderBlock
          ? _value._orderBlock
          : orderBlock // ignore: cast_nullable_to_non_nullable
              as List<OrderBlock>,
      suggestPath: null == suggestPath
          ? _value._suggestPath
          : suggestPath // ignore: cast_nullable_to_non_nullable
              as List<SuggestPath>,
    ));
  }
}

/// @nodoc

class _$EmapKittingStateImpl implements _EmapKittingState {
  _$EmapKittingStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.errorEntity = null,
      this.floor = null,
      final List<OrderBlock> orderBlock = const [],
      final List<SuggestPath> suggestPath = const []})
      : _orderBlock = orderBlock,
        _suggestPath = suggestPath;

  @override
  @JsonKey()
  final PageStatus pageStatus;
  @override
  @JsonKey()
  final bool processing;
  @override
  @JsonKey()
  final ErrorEntity? errorEntity;
  @override
  @JsonKey()
  final EMapWidget? floor;
  final List<OrderBlock> _orderBlock;
  @override
  @JsonKey()
  List<OrderBlock> get orderBlock {
    if (_orderBlock is EqualUnmodifiableListView) return _orderBlock;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderBlock);
  }

  final List<SuggestPath> _suggestPath;
  @override
  @JsonKey()
  List<SuggestPath> get suggestPath {
    if (_suggestPath is EqualUnmodifiableListView) return _suggestPath;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestPath);
  }

  @override
  String toString() {
    return 'EmapKittingState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, floor: $floor, orderBlock: $orderBlock, suggestPath: $suggestPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmapKittingStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            const DeepCollectionEquality()
                .equals(other._orderBlock, _orderBlock) &&
            const DeepCollectionEquality()
                .equals(other._suggestPath, _suggestPath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      floor,
      const DeepCollectionEquality().hash(_orderBlock),
      const DeepCollectionEquality().hash(_suggestPath));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmapKittingStateImplCopyWith<_$EmapKittingStateImpl> get copyWith =>
      __$$EmapKittingStateImplCopyWithImpl<_$EmapKittingStateImpl>(
          this, _$identity);
}

abstract class _EmapKittingState implements EmapKittingState {
  factory _EmapKittingState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final EMapWidget? floor,
      final List<OrderBlock> orderBlock,
      final List<SuggestPath> suggestPath}) = _$EmapKittingStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  EMapWidget? get floor;
  @override
  List<OrderBlock> get orderBlock;
  @override
  List<SuggestPath> get suggestPath;
  @override
  @JsonKey(ignore: true)
  _$$EmapKittingStateImplCopyWith<_$EmapKittingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

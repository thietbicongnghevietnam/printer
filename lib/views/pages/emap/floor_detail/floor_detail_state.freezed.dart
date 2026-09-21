// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'floor_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FloorDetailState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  CustomReCardItem? get currentReCard => throw _privateConstructorUsedError;
  FloorMapResponseModel? get floorData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FloorDetailStateCopyWith<FloorDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FloorDetailStateCopyWith<$Res> {
  factory $FloorDetailStateCopyWith(
          FloorDetailState value, $Res Function(FloorDetailState) then) =
      _$FloorDetailStateCopyWithImpl<$Res, FloorDetailState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      CustomReCardItem? currentReCard,
      FloorMapResponseModel? floorData});
}

/// @nodoc
class _$FloorDetailStateCopyWithImpl<$Res, $Val extends FloorDetailState>
    implements $FloorDetailStateCopyWith<$Res> {
  _$FloorDetailStateCopyWithImpl(this._value, this._then);

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
    Object? currentReCard = freezed,
    Object? floorData = freezed,
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
      currentReCard: freezed == currentReCard
          ? _value.currentReCard
          : currentReCard // ignore: cast_nullable_to_non_nullable
              as CustomReCardItem?,
      floorData: freezed == floorData
          ? _value.floorData
          : floorData // ignore: cast_nullable_to_non_nullable
              as FloorMapResponseModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FloorDetailStateImplCopyWith<$Res>
    implements $FloorDetailStateCopyWith<$Res> {
  factory _$$FloorDetailStateImplCopyWith(_$FloorDetailStateImpl value,
          $Res Function(_$FloorDetailStateImpl) then) =
      __$$FloorDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      CustomReCardItem? currentReCard,
      FloorMapResponseModel? floorData});
}

/// @nodoc
class __$$FloorDetailStateImplCopyWithImpl<$Res>
    extends _$FloorDetailStateCopyWithImpl<$Res, _$FloorDetailStateImpl>
    implements _$$FloorDetailStateImplCopyWith<$Res> {
  __$$FloorDetailStateImplCopyWithImpl(_$FloorDetailStateImpl _value,
      $Res Function(_$FloorDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? currentReCard = freezed,
    Object? floorData = freezed,
  }) {
    return _then(_$FloorDetailStateImpl(
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
      currentReCard: freezed == currentReCard
          ? _value.currentReCard
          : currentReCard // ignore: cast_nullable_to_non_nullable
              as CustomReCardItem?,
      floorData: freezed == floorData
          ? _value.floorData
          : floorData // ignore: cast_nullable_to_non_nullable
              as FloorMapResponseModel?,
    ));
  }
}

/// @nodoc

class _$FloorDetailStateImpl implements _FloorDetailState {
  _$FloorDetailStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.errorEntity = null,
      this.currentReCard = null,
      this.floorData = null});

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
  final CustomReCardItem? currentReCard;
  @override
  @JsonKey()
  final FloorMapResponseModel? floorData;

  @override
  String toString() {
    return 'FloorDetailState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, currentReCard: $currentReCard, floorData: $floorData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FloorDetailStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.currentReCard, currentReCard) ||
                other.currentReCard == currentReCard) &&
            (identical(other.floorData, floorData) ||
                other.floorData == floorData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageStatus, processing,
      errorEntity, currentReCard, floorData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FloorDetailStateImplCopyWith<_$FloorDetailStateImpl> get copyWith =>
      __$$FloorDetailStateImplCopyWithImpl<_$FloorDetailStateImpl>(
          this, _$identity);
}

abstract class _FloorDetailState implements FloorDetailState {
  factory _FloorDetailState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final CustomReCardItem? currentReCard,
      final FloorMapResponseModel? floorData}) = _$FloorDetailStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  CustomReCardItem? get currentReCard;
  @override
  FloorMapResponseModel? get floorData;
  @override
  @JsonKey(ignore: true)
  _$$FloorDetailStateImplCopyWith<_$FloorDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

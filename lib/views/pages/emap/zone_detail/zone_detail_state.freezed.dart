// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zone_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ZoneDetailState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  CustomReCardItem? get currentReCard => throw _privateConstructorUsedError;
  ZoneFloorResponseModel? get zoneData => throw _privateConstructorUsedError;
  ZoneDetailResponseModel? get zoneDetailData =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ZoneDetailStateCopyWith<ZoneDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ZoneDetailStateCopyWith<$Res> {
  factory $ZoneDetailStateCopyWith(
          ZoneDetailState value, $Res Function(ZoneDetailState) then) =
      _$ZoneDetailStateCopyWithImpl<$Res, ZoneDetailState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      CustomReCardItem? currentReCard,
      ZoneFloorResponseModel? zoneData,
      ZoneDetailResponseModel? zoneDetailData});
}

/// @nodoc
class _$ZoneDetailStateCopyWithImpl<$Res, $Val extends ZoneDetailState>
    implements $ZoneDetailStateCopyWith<$Res> {
  _$ZoneDetailStateCopyWithImpl(this._value, this._then);

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
    Object? zoneData = freezed,
    Object? zoneDetailData = freezed,
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
      zoneData: freezed == zoneData
          ? _value.zoneData
          : zoneData // ignore: cast_nullable_to_non_nullable
              as ZoneFloorResponseModel?,
      zoneDetailData: freezed == zoneDetailData
          ? _value.zoneDetailData
          : zoneDetailData // ignore: cast_nullable_to_non_nullable
              as ZoneDetailResponseModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ZoneDetailStateImplCopyWith<$Res>
    implements $ZoneDetailStateCopyWith<$Res> {
  factory _$$ZoneDetailStateImplCopyWith(_$ZoneDetailStateImpl value,
          $Res Function(_$ZoneDetailStateImpl) then) =
      __$$ZoneDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      CustomReCardItem? currentReCard,
      ZoneFloorResponseModel? zoneData,
      ZoneDetailResponseModel? zoneDetailData});
}

/// @nodoc
class __$$ZoneDetailStateImplCopyWithImpl<$Res>
    extends _$ZoneDetailStateCopyWithImpl<$Res, _$ZoneDetailStateImpl>
    implements _$$ZoneDetailStateImplCopyWith<$Res> {
  __$$ZoneDetailStateImplCopyWithImpl(
      _$ZoneDetailStateImpl _value, $Res Function(_$ZoneDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? currentReCard = freezed,
    Object? zoneData = freezed,
    Object? zoneDetailData = freezed,
  }) {
    return _then(_$ZoneDetailStateImpl(
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
      zoneData: freezed == zoneData
          ? _value.zoneData
          : zoneData // ignore: cast_nullable_to_non_nullable
              as ZoneFloorResponseModel?,
      zoneDetailData: freezed == zoneDetailData
          ? _value.zoneDetailData
          : zoneDetailData // ignore: cast_nullable_to_non_nullable
              as ZoneDetailResponseModel?,
    ));
  }
}

/// @nodoc

class _$ZoneDetailStateImpl implements _ZoneDetailState {
  _$ZoneDetailStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.errorEntity = null,
      this.currentReCard = null,
      this.zoneData = null,
      this.zoneDetailData = null});

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
  final ZoneFloorResponseModel? zoneData;
  @override
  @JsonKey()
  final ZoneDetailResponseModel? zoneDetailData;

  @override
  String toString() {
    return 'ZoneDetailState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, currentReCard: $currentReCard, zoneData: $zoneData, zoneDetailData: $zoneDetailData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ZoneDetailStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.currentReCard, currentReCard) ||
                other.currentReCard == currentReCard) &&
            (identical(other.zoneData, zoneData) ||
                other.zoneData == zoneData) &&
            (identical(other.zoneDetailData, zoneDetailData) ||
                other.zoneDetailData == zoneDetailData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageStatus, processing,
      errorEntity, currentReCard, zoneData, zoneDetailData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ZoneDetailStateImplCopyWith<_$ZoneDetailStateImpl> get copyWith =>
      __$$ZoneDetailStateImplCopyWithImpl<_$ZoneDetailStateImpl>(
          this, _$identity);
}

abstract class _ZoneDetailState implements ZoneDetailState {
  factory _ZoneDetailState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final CustomReCardItem? currentReCard,
      final ZoneFloorResponseModel? zoneData,
      final ZoneDetailResponseModel? zoneDetailData}) = _$ZoneDetailStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  CustomReCardItem? get currentReCard;
  @override
  ZoneFloorResponseModel? get zoneData;
  @override
  ZoneDetailResponseModel? get zoneDetailData;
  @override
  @JsonKey(ignore: true)
  _$$ZoneDetailStateImplCopyWith<_$ZoneDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

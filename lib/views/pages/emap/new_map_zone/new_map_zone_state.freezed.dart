// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_map_zone_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NewMapZoneState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  CustomReCardItem? get currentReCard => throw _privateConstructorUsedError;
  EMapZone? get zoneMapData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewMapZoneStateCopyWith<NewMapZoneState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewMapZoneStateCopyWith<$Res> {
  factory $NewMapZoneStateCopyWith(
          NewMapZoneState value, $Res Function(NewMapZoneState) then) =
      _$NewMapZoneStateCopyWithImpl<$Res, NewMapZoneState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      CustomReCardItem? currentReCard,
      EMapZone? zoneMapData});
}

/// @nodoc
class _$NewMapZoneStateCopyWithImpl<$Res, $Val extends NewMapZoneState>
    implements $NewMapZoneStateCopyWith<$Res> {
  _$NewMapZoneStateCopyWithImpl(this._value, this._then);

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
    Object? zoneMapData = freezed,
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
      zoneMapData: freezed == zoneMapData
          ? _value.zoneMapData
          : zoneMapData // ignore: cast_nullable_to_non_nullable
              as EMapZone?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewMapZoneStateImplCopyWith<$Res>
    implements $NewMapZoneStateCopyWith<$Res> {
  factory _$$NewMapZoneStateImplCopyWith(_$NewMapZoneStateImpl value,
          $Res Function(_$NewMapZoneStateImpl) then) =
      __$$NewMapZoneStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      CustomReCardItem? currentReCard,
      EMapZone? zoneMapData});
}

/// @nodoc
class __$$NewMapZoneStateImplCopyWithImpl<$Res>
    extends _$NewMapZoneStateCopyWithImpl<$Res, _$NewMapZoneStateImpl>
    implements _$$NewMapZoneStateImplCopyWith<$Res> {
  __$$NewMapZoneStateImplCopyWithImpl(
      _$NewMapZoneStateImpl _value, $Res Function(_$NewMapZoneStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? currentReCard = freezed,
    Object? zoneMapData = freezed,
  }) {
    return _then(_$NewMapZoneStateImpl(
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
      zoneMapData: freezed == zoneMapData
          ? _value.zoneMapData
          : zoneMapData // ignore: cast_nullable_to_non_nullable
              as EMapZone?,
    ));
  }
}

/// @nodoc

class _$NewMapZoneStateImpl implements _NewMapZoneState {
  _$NewMapZoneStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.errorEntity = null,
      this.currentReCard = null,
      this.zoneMapData = null});

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
  final EMapZone? zoneMapData;

  @override
  String toString() {
    return 'NewMapZoneState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, currentReCard: $currentReCard, zoneMapData: $zoneMapData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewMapZoneStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.currentReCard, currentReCard) ||
                other.currentReCard == currentReCard) &&
            (identical(other.zoneMapData, zoneMapData) ||
                other.zoneMapData == zoneMapData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageStatus, processing,
      errorEntity, currentReCard, zoneMapData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewMapZoneStateImplCopyWith<_$NewMapZoneStateImpl> get copyWith =>
      __$$NewMapZoneStateImplCopyWithImpl<_$NewMapZoneStateImpl>(
          this, _$identity);
}

abstract class _NewMapZoneState implements NewMapZoneState {
  factory _NewMapZoneState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final CustomReCardItem? currentReCard,
      final EMapZone? zoneMapData}) = _$NewMapZoneStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  CustomReCardItem? get currentReCard;
  @override
  EMapZone? get zoneMapData;
  @override
  @JsonKey(ignore: true)
  _$$NewMapZoneStateImplCopyWith<_$NewMapZoneStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

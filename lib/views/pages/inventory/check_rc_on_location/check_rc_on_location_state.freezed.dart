// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_rc_on_location_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CheckRcOnLocationState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  List<ReceivingCard> get listReCard => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckRcOnLocationStateCopyWith<CheckRcOnLocationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckRcOnLocationStateCopyWith<$Res> {
  factory $CheckRcOnLocationStateCopyWith(CheckRcOnLocationState value,
          $Res Function(CheckRcOnLocationState) then) =
      _$CheckRcOnLocationStateCopyWithImpl<$Res, CheckRcOnLocationState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<ReceivingCard> listReCard});
}

/// @nodoc
class _$CheckRcOnLocationStateCopyWithImpl<$Res,
        $Val extends CheckRcOnLocationState>
    implements $CheckRcOnLocationStateCopyWith<$Res> {
  _$CheckRcOnLocationStateCopyWithImpl(this._value, this._then);

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
    Object? listReCard = null,
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
      listReCard: null == listReCard
          ? _value.listReCard
          : listReCard // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckRcOnLocationStateImplCopyWith<$Res>
    implements $CheckRcOnLocationStateCopyWith<$Res> {
  factory _$$CheckRcOnLocationStateImplCopyWith(
          _$CheckRcOnLocationStateImpl value,
          $Res Function(_$CheckRcOnLocationStateImpl) then) =
      __$$CheckRcOnLocationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<ReceivingCard> listReCard});
}

/// @nodoc
class __$$CheckRcOnLocationStateImplCopyWithImpl<$Res>
    extends _$CheckRcOnLocationStateCopyWithImpl<$Res,
        _$CheckRcOnLocationStateImpl>
    implements _$$CheckRcOnLocationStateImplCopyWith<$Res> {
  __$$CheckRcOnLocationStateImplCopyWithImpl(
      _$CheckRcOnLocationStateImpl _value,
      $Res Function(_$CheckRcOnLocationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? listReCard = null,
  }) {
    return _then(_$CheckRcOnLocationStateImpl(
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
      listReCard: null == listReCard
          ? _value._listReCard
          : listReCard // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>,
    ));
  }
}

/// @nodoc

class _$CheckRcOnLocationStateImpl implements _CheckRcOnLocationState {
  _$CheckRcOnLocationStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      final List<ReceivingCard> listReCard = const []})
      : _listReCard = listReCard;

  @override
  @JsonKey()
  final PageStatus pageStatus;
  @override
  @JsonKey()
  final bool processing;
  @override
  @JsonKey()
  final ErrorEntity? errorEntity;
  final List<ReceivingCard> _listReCard;
  @override
  @JsonKey()
  List<ReceivingCard> get listReCard {
    if (_listReCard is EqualUnmodifiableListView) return _listReCard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listReCard);
  }

  @override
  String toString() {
    return 'CheckRcOnLocationState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, listReCard: $listReCard)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckRcOnLocationStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            const DeepCollectionEquality()
                .equals(other._listReCard, _listReCard));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageStatus, processing,
      errorEntity, const DeepCollectionEquality().hash(_listReCard));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckRcOnLocationStateImplCopyWith<_$CheckRcOnLocationStateImpl>
      get copyWith => __$$CheckRcOnLocationStateImplCopyWithImpl<
          _$CheckRcOnLocationStateImpl>(this, _$identity);
}

abstract class _CheckRcOnLocationState implements CheckRcOnLocationState {
  factory _CheckRcOnLocationState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final List<ReceivingCard> listReCard}) = _$CheckRcOnLocationStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  List<ReceivingCard> get listReCard;
  @override
  @JsonKey(ignore: true)
  _$$CheckRcOnLocationStateImplCopyWith<_$CheckRcOnLocationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

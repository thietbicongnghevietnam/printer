// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_last_lot_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CheckLastLotState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  List<ReceivingCardByBlockResponseModel> get listReceivingCard =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckLastLotStateCopyWith<CheckLastLotState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckLastLotStateCopyWith<$Res> {
  factory $CheckLastLotStateCopyWith(
          CheckLastLotState value, $Res Function(CheckLastLotState) then) =
      _$CheckLastLotStateCopyWithImpl<$Res, CheckLastLotState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<ReceivingCardByBlockResponseModel> listReceivingCard});
}

/// @nodoc
class _$CheckLastLotStateCopyWithImpl<$Res, $Val extends CheckLastLotState>
    implements $CheckLastLotStateCopyWith<$Res> {
  _$CheckLastLotStateCopyWithImpl(this._value, this._then);

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
    Object? listReceivingCard = null,
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
      listReceivingCard: null == listReceivingCard
          ? _value.listReceivingCard
          : listReceivingCard // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardByBlockResponseModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckLastLotStateImplCopyWith<$Res>
    implements $CheckLastLotStateCopyWith<$Res> {
  factory _$$CheckLastLotStateImplCopyWith(_$CheckLastLotStateImpl value,
          $Res Function(_$CheckLastLotStateImpl) then) =
      __$$CheckLastLotStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<ReceivingCardByBlockResponseModel> listReceivingCard});
}

/// @nodoc
class __$$CheckLastLotStateImplCopyWithImpl<$Res>
    extends _$CheckLastLotStateCopyWithImpl<$Res, _$CheckLastLotStateImpl>
    implements _$$CheckLastLotStateImplCopyWith<$Res> {
  __$$CheckLastLotStateImplCopyWithImpl(_$CheckLastLotStateImpl _value,
      $Res Function(_$CheckLastLotStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? listReceivingCard = null,
  }) {
    return _then(_$CheckLastLotStateImpl(
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
      listReceivingCard: null == listReceivingCard
          ? _value._listReceivingCard
          : listReceivingCard // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardByBlockResponseModel>,
    ));
  }
}

/// @nodoc

class _$CheckLastLotStateImpl implements _CheckLastLotState {
  _$CheckLastLotStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.errorEntity = null,
      final List<ReceivingCardByBlockResponseModel> listReceivingCard =
          const []})
      : _listReceivingCard = listReceivingCard;

  @override
  @JsonKey()
  final PageStatus pageStatus;
  @override
  @JsonKey()
  final bool processing;
  @override
  @JsonKey()
  final ErrorEntity? errorEntity;
  final List<ReceivingCardByBlockResponseModel> _listReceivingCard;
  @override
  @JsonKey()
  List<ReceivingCardByBlockResponseModel> get listReceivingCard {
    if (_listReceivingCard is EqualUnmodifiableListView)
      return _listReceivingCard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listReceivingCard);
  }

  @override
  String toString() {
    return 'CheckLastLotState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, listReceivingCard: $listReceivingCard)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckLastLotStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            const DeepCollectionEquality()
                .equals(other._listReceivingCard, _listReceivingCard));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageStatus, processing,
      errorEntity, const DeepCollectionEquality().hash(_listReceivingCard));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckLastLotStateImplCopyWith<_$CheckLastLotStateImpl> get copyWith =>
      __$$CheckLastLotStateImplCopyWithImpl<_$CheckLastLotStateImpl>(
          this, _$identity);
}

abstract class _CheckLastLotState implements CheckLastLotState {
  factory _CheckLastLotState(
          {final PageStatus pageStatus,
          final bool processing,
          final ErrorEntity? errorEntity,
          final List<ReceivingCardByBlockResponseModel> listReceivingCard}) =
      _$CheckLastLotStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  List<ReceivingCardByBlockResponseModel> get listReceivingCard;
  @override
  @JsonKey(ignore: true)
  _$$CheckLastLotStateImplCopyWith<_$CheckLastLotStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

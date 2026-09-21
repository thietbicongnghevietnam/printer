// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_block_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CheckBlockDataState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  List<ReceivingCardByBlockResponseModel> get listReceivingCard =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckBlockDataStateCopyWith<CheckBlockDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckBlockDataStateCopyWith<$Res> {
  factory $CheckBlockDataStateCopyWith(
          CheckBlockDataState value, $Res Function(CheckBlockDataState) then) =
      _$CheckBlockDataStateCopyWithImpl<$Res, CheckBlockDataState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<ReceivingCardByBlockResponseModel> listReceivingCard});
}

/// @nodoc
class _$CheckBlockDataStateCopyWithImpl<$Res, $Val extends CheckBlockDataState>
    implements $CheckBlockDataStateCopyWith<$Res> {
  _$CheckBlockDataStateCopyWithImpl(this._value, this._then);

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
abstract class _$$CheckBlockDataStateImplCopyWith<$Res>
    implements $CheckBlockDataStateCopyWith<$Res> {
  factory _$$CheckBlockDataStateImplCopyWith(_$CheckBlockDataStateImpl value,
          $Res Function(_$CheckBlockDataStateImpl) then) =
      __$$CheckBlockDataStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<ReceivingCardByBlockResponseModel> listReceivingCard});
}

/// @nodoc
class __$$CheckBlockDataStateImplCopyWithImpl<$Res>
    extends _$CheckBlockDataStateCopyWithImpl<$Res, _$CheckBlockDataStateImpl>
    implements _$$CheckBlockDataStateImplCopyWith<$Res> {
  __$$CheckBlockDataStateImplCopyWithImpl(_$CheckBlockDataStateImpl _value,
      $Res Function(_$CheckBlockDataStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? listReceivingCard = null,
  }) {
    return _then(_$CheckBlockDataStateImpl(
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

class _$CheckBlockDataStateImpl implements _CheckBlockDataState {
  _$CheckBlockDataStateImpl(
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
    return 'CheckBlockDataState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, listReceivingCard: $listReceivingCard)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckBlockDataStateImpl &&
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
  _$$CheckBlockDataStateImplCopyWith<_$CheckBlockDataStateImpl> get copyWith =>
      __$$CheckBlockDataStateImplCopyWithImpl<_$CheckBlockDataStateImpl>(
          this, _$identity);
}

abstract class _CheckBlockDataState implements CheckBlockDataState {
  factory _CheckBlockDataState(
          {final PageStatus pageStatus,
          final bool processing,
          final ErrorEntity? errorEntity,
          final List<ReceivingCardByBlockResponseModel> listReceivingCard}) =
      _$CheckBlockDataStateImpl;

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
  _$$CheckBlockDataStateImplCopyWith<_$CheckBlockDataStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

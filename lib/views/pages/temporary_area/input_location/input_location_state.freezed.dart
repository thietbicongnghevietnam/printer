// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_location_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InputLocationState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  String? get receivingCardData => throw _privateConstructorUsedError;
  String? get palletData => throw _privateConstructorUsedError;
  List<String> get listReceivingCard => throw _privateConstructorUsedError;
  List<ReceivingCard> get listReceivingCardInPallet =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InputLocationStateCopyWith<InputLocationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputLocationStateCopyWith<$Res> {
  factory $InputLocationStateCopyWith(
          InputLocationState value, $Res Function(InputLocationState) then) =
      _$InputLocationStateCopyWithImpl<$Res, InputLocationState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      String? receivingCardData,
      String? palletData,
      List<String> listReceivingCard,
      List<ReceivingCard> listReceivingCardInPallet});
}

/// @nodoc
class _$InputLocationStateCopyWithImpl<$Res, $Val extends InputLocationState>
    implements $InputLocationStateCopyWith<$Res> {
  _$InputLocationStateCopyWithImpl(this._value, this._then);

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
    Object? receivingCardData = freezed,
    Object? palletData = freezed,
    Object? listReceivingCard = null,
    Object? listReceivingCardInPallet = null,
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
      receivingCardData: freezed == receivingCardData
          ? _value.receivingCardData
          : receivingCardData // ignore: cast_nullable_to_non_nullable
              as String?,
      palletData: freezed == palletData
          ? _value.palletData
          : palletData // ignore: cast_nullable_to_non_nullable
              as String?,
      listReceivingCard: null == listReceivingCard
          ? _value.listReceivingCard
          : listReceivingCard // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listReceivingCardInPallet: null == listReceivingCardInPallet
          ? _value.listReceivingCardInPallet
          : listReceivingCardInPallet // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InputLocationStateImplCopyWith<$Res>
    implements $InputLocationStateCopyWith<$Res> {
  factory _$$InputLocationStateImplCopyWith(_$InputLocationStateImpl value,
          $Res Function(_$InputLocationStateImpl) then) =
      __$$InputLocationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      String? receivingCardData,
      String? palletData,
      List<String> listReceivingCard,
      List<ReceivingCard> listReceivingCardInPallet});
}

/// @nodoc
class __$$InputLocationStateImplCopyWithImpl<$Res>
    extends _$InputLocationStateCopyWithImpl<$Res, _$InputLocationStateImpl>
    implements _$$InputLocationStateImplCopyWith<$Res> {
  __$$InputLocationStateImplCopyWithImpl(_$InputLocationStateImpl _value,
      $Res Function(_$InputLocationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? receivingCardData = freezed,
    Object? palletData = freezed,
    Object? listReceivingCard = null,
    Object? listReceivingCardInPallet = null,
  }) {
    return _then(_$InputLocationStateImpl(
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
      receivingCardData: freezed == receivingCardData
          ? _value.receivingCardData
          : receivingCardData // ignore: cast_nullable_to_non_nullable
              as String?,
      palletData: freezed == palletData
          ? _value.palletData
          : palletData // ignore: cast_nullable_to_non_nullable
              as String?,
      listReceivingCard: null == listReceivingCard
          ? _value._listReceivingCard
          : listReceivingCard // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listReceivingCardInPallet: null == listReceivingCardInPallet
          ? _value._listReceivingCardInPallet
          : listReceivingCardInPallet // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>,
    ));
  }
}

/// @nodoc

class _$InputLocationStateImpl implements _InputLocationState {
  _$InputLocationStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      this.receivingCardData = null,
      this.palletData = null,
      final List<String> listReceivingCard = const [],
      final List<ReceivingCard> listReceivingCardInPallet = const []})
      : _listReceivingCard = listReceivingCard,
        _listReceivingCardInPallet = listReceivingCardInPallet;

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
  final String? receivingCardData;
  @override
  @JsonKey()
  final String? palletData;
  final List<String> _listReceivingCard;
  @override
  @JsonKey()
  List<String> get listReceivingCard {
    if (_listReceivingCard is EqualUnmodifiableListView)
      return _listReceivingCard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listReceivingCard);
  }

  final List<ReceivingCard> _listReceivingCardInPallet;
  @override
  @JsonKey()
  List<ReceivingCard> get listReceivingCardInPallet {
    if (_listReceivingCardInPallet is EqualUnmodifiableListView)
      return _listReceivingCardInPallet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listReceivingCardInPallet);
  }

  @override
  String toString() {
    return 'InputLocationState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, receivingCardData: $receivingCardData, palletData: $palletData, listReceivingCard: $listReceivingCard, listReceivingCardInPallet: $listReceivingCardInPallet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputLocationStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.receivingCardData, receivingCardData) ||
                other.receivingCardData == receivingCardData) &&
            (identical(other.palletData, palletData) ||
                other.palletData == palletData) &&
            const DeepCollectionEquality()
                .equals(other._listReceivingCard, _listReceivingCard) &&
            const DeepCollectionEquality().equals(
                other._listReceivingCardInPallet, _listReceivingCardInPallet));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      receivingCardData,
      palletData,
      const DeepCollectionEquality().hash(_listReceivingCard),
      const DeepCollectionEquality().hash(_listReceivingCardInPallet));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InputLocationStateImplCopyWith<_$InputLocationStateImpl> get copyWith =>
      __$$InputLocationStateImplCopyWithImpl<_$InputLocationStateImpl>(
          this, _$identity);
}

abstract class _InputLocationState implements InputLocationState {
  factory _InputLocationState(
          {final PageStatus pageStatus,
          final bool processing,
          final ErrorEntity? errorEntity,
          final String? receivingCardData,
          final String? palletData,
          final List<String> listReceivingCard,
          final List<ReceivingCard> listReceivingCardInPallet}) =
      _$InputLocationStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  String? get receivingCardData;
  @override
  String? get palletData;
  @override
  List<String> get listReceivingCard;
  @override
  List<ReceivingCard> get listReceivingCardInPallet;
  @override
  @JsonKey(ignore: true)
  _$$InputLocationStateImplCopyWith<_$InputLocationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'barcode_scanned_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BarcodeScannedState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  List<ReceivingCard>? get receivingCards => throw _privateConstructorUsedError;
  List<ReceivingCardItem>? get receivingCardItems =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BarcodeScannedStateCopyWith<BarcodeScannedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarcodeScannedStateCopyWith<$Res> {
  factory $BarcodeScannedStateCopyWith(
          BarcodeScannedState value, $Res Function(BarcodeScannedState) then) =
      _$BarcodeScannedStateCopyWithImpl<$Res, BarcodeScannedState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<ReceivingCard>? receivingCards,
      List<ReceivingCardItem>? receivingCardItems});
}

/// @nodoc
class _$BarcodeScannedStateCopyWithImpl<$Res, $Val extends BarcodeScannedState>
    implements $BarcodeScannedStateCopyWith<$Res> {
  _$BarcodeScannedStateCopyWithImpl(this._value, this._then);

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
    Object? receivingCards = freezed,
    Object? receivingCardItems = freezed,
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
      receivingCards: freezed == receivingCards
          ? _value.receivingCards
          : receivingCards // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>?,
      receivingCardItems: freezed == receivingCardItems
          ? _value.receivingCardItems
          : receivingCardItems // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardItem>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BarcodeScannedStateImplCopyWith<$Res>
    implements $BarcodeScannedStateCopyWith<$Res> {
  factory _$$BarcodeScannedStateImplCopyWith(_$BarcodeScannedStateImpl value,
          $Res Function(_$BarcodeScannedStateImpl) then) =
      __$$BarcodeScannedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<ReceivingCard>? receivingCards,
      List<ReceivingCardItem>? receivingCardItems});
}

/// @nodoc
class __$$BarcodeScannedStateImplCopyWithImpl<$Res>
    extends _$BarcodeScannedStateCopyWithImpl<$Res, _$BarcodeScannedStateImpl>
    implements _$$BarcodeScannedStateImplCopyWith<$Res> {
  __$$BarcodeScannedStateImplCopyWithImpl(_$BarcodeScannedStateImpl _value,
      $Res Function(_$BarcodeScannedStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? receivingCards = freezed,
    Object? receivingCardItems = freezed,
  }) {
    return _then(_$BarcodeScannedStateImpl(
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
      receivingCards: freezed == receivingCards
          ? _value._receivingCards
          : receivingCards // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>?,
      receivingCardItems: freezed == receivingCardItems
          ? _value._receivingCardItems
          : receivingCardItems // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardItem>?,
    ));
  }
}

/// @nodoc

class _$BarcodeScannedStateImpl implements _BarcodeScannedState {
  _$BarcodeScannedStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      final List<ReceivingCard>? receivingCards = const [],
      final List<ReceivingCardItem>? receivingCardItems = const []})
      : _receivingCards = receivingCards,
        _receivingCardItems = receivingCardItems;

  @override
  @JsonKey()
  final PageStatus pageStatus;
  @override
  @JsonKey()
  final bool processing;
  @override
  @JsonKey()
  final ErrorEntity? errorEntity;
  final List<ReceivingCard>? _receivingCards;
  @override
  @JsonKey()
  List<ReceivingCard>? get receivingCards {
    final value = _receivingCards;
    if (value == null) return null;
    if (_receivingCards is EqualUnmodifiableListView) return _receivingCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ReceivingCardItem>? _receivingCardItems;
  @override
  @JsonKey()
  List<ReceivingCardItem>? get receivingCardItems {
    final value = _receivingCardItems;
    if (value == null) return null;
    if (_receivingCardItems is EqualUnmodifiableListView)
      return _receivingCardItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'BarcodeScannedState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, receivingCards: $receivingCards, receivingCardItems: $receivingCardItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarcodeScannedStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            const DeepCollectionEquality()
                .equals(other._receivingCards, _receivingCards) &&
            const DeepCollectionEquality()
                .equals(other._receivingCardItems, _receivingCardItems));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      const DeepCollectionEquality().hash(_receivingCards),
      const DeepCollectionEquality().hash(_receivingCardItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BarcodeScannedStateImplCopyWith<_$BarcodeScannedStateImpl> get copyWith =>
      __$$BarcodeScannedStateImplCopyWithImpl<_$BarcodeScannedStateImpl>(
          this, _$identity);
}

abstract class _BarcodeScannedState implements BarcodeScannedState {
  factory _BarcodeScannedState(
          {final PageStatus pageStatus,
          final bool processing,
          final ErrorEntity? errorEntity,
          final List<ReceivingCard>? receivingCards,
          final List<ReceivingCardItem>? receivingCardItems}) =
      _$BarcodeScannedStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  List<ReceivingCard>? get receivingCards;
  @override
  List<ReceivingCardItem>? get receivingCardItems;
  @override
  @JsonKey(ignore: true)
  _$$BarcodeScannedStateImplCopyWith<_$BarcodeScannedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

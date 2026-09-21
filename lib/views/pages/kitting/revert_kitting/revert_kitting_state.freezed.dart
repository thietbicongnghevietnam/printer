// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revert_kitting_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RevertKittingState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  List<KittingCard> get kittingCards => throw _privateConstructorUsedError;
  List<ReceivingCard> get receivingCards => throw _privateConstructorUsedError;
  PrinterDevice? get savePrinterDevice => throw _privateConstructorUsedError;
  List<PrinterDevice> get printerDevices => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RevertKittingStateCopyWith<RevertKittingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevertKittingStateCopyWith<$Res> {
  factory $RevertKittingStateCopyWith(
          RevertKittingState value, $Res Function(RevertKittingState) then) =
      _$RevertKittingStateCopyWithImpl<$Res, RevertKittingState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<KittingCard> kittingCards,
      List<ReceivingCard> receivingCards,
      PrinterDevice? savePrinterDevice,
      List<PrinterDevice> printerDevices});
}

/// @nodoc
class _$RevertKittingStateCopyWithImpl<$Res, $Val extends RevertKittingState>
    implements $RevertKittingStateCopyWith<$Res> {
  _$RevertKittingStateCopyWithImpl(this._value, this._then);

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
    Object? kittingCards = null,
    Object? receivingCards = null,
    Object? savePrinterDevice = freezed,
    Object? printerDevices = null,
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
      kittingCards: null == kittingCards
          ? _value.kittingCards
          : kittingCards // ignore: cast_nullable_to_non_nullable
              as List<KittingCard>,
      receivingCards: null == receivingCards
          ? _value.receivingCards
          : receivingCards // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>,
      savePrinterDevice: freezed == savePrinterDevice
          ? _value.savePrinterDevice
          : savePrinterDevice // ignore: cast_nullable_to_non_nullable
              as PrinterDevice?,
      printerDevices: null == printerDevices
          ? _value.printerDevices
          : printerDevices // ignore: cast_nullable_to_non_nullable
              as List<PrinterDevice>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RevertKittingStateImplCopyWith<$Res>
    implements $RevertKittingStateCopyWith<$Res> {
  factory _$$RevertKittingStateImplCopyWith(_$RevertKittingStateImpl value,
          $Res Function(_$RevertKittingStateImpl) then) =
      __$$RevertKittingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<KittingCard> kittingCards,
      List<ReceivingCard> receivingCards,
      PrinterDevice? savePrinterDevice,
      List<PrinterDevice> printerDevices});
}

/// @nodoc
class __$$RevertKittingStateImplCopyWithImpl<$Res>
    extends _$RevertKittingStateCopyWithImpl<$Res, _$RevertKittingStateImpl>
    implements _$$RevertKittingStateImplCopyWith<$Res> {
  __$$RevertKittingStateImplCopyWithImpl(_$RevertKittingStateImpl _value,
      $Res Function(_$RevertKittingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? kittingCards = null,
    Object? receivingCards = null,
    Object? savePrinterDevice = freezed,
    Object? printerDevices = null,
  }) {
    return _then(_$RevertKittingStateImpl(
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
      kittingCards: null == kittingCards
          ? _value._kittingCards
          : kittingCards // ignore: cast_nullable_to_non_nullable
              as List<KittingCard>,
      receivingCards: null == receivingCards
          ? _value._receivingCards
          : receivingCards // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>,
      savePrinterDevice: freezed == savePrinterDevice
          ? _value.savePrinterDevice
          : savePrinterDevice // ignore: cast_nullable_to_non_nullable
              as PrinterDevice?,
      printerDevices: null == printerDevices
          ? _value._printerDevices
          : printerDevices // ignore: cast_nullable_to_non_nullable
              as List<PrinterDevice>,
    ));
  }
}

/// @nodoc

class _$RevertKittingStateImpl implements _RevertKittingState {
  _$RevertKittingStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      final List<KittingCard> kittingCards = const [],
      final List<ReceivingCard> receivingCards = const [],
      this.savePrinterDevice = null,
      final List<PrinterDevice> printerDevices = const []})
      : _kittingCards = kittingCards,
        _receivingCards = receivingCards,
        _printerDevices = printerDevices;

  @override
  @JsonKey()
  final PageStatus pageStatus;
  @override
  @JsonKey()
  final bool processing;
  @override
  @JsonKey()
  final ErrorEntity? errorEntity;
  final List<KittingCard> _kittingCards;
  @override
  @JsonKey()
  List<KittingCard> get kittingCards {
    if (_kittingCards is EqualUnmodifiableListView) return _kittingCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kittingCards);
  }

  final List<ReceivingCard> _receivingCards;
  @override
  @JsonKey()
  List<ReceivingCard> get receivingCards {
    if (_receivingCards is EqualUnmodifiableListView) return _receivingCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_receivingCards);
  }

  @override
  @JsonKey()
  final PrinterDevice? savePrinterDevice;
  final List<PrinterDevice> _printerDevices;
  @override
  @JsonKey()
  List<PrinterDevice> get printerDevices {
    if (_printerDevices is EqualUnmodifiableListView) return _printerDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_printerDevices);
  }

  @override
  String toString() {
    return 'RevertKittingState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, kittingCards: $kittingCards, receivingCards: $receivingCards, savePrinterDevice: $savePrinterDevice, printerDevices: $printerDevices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevertKittingStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            const DeepCollectionEquality()
                .equals(other._kittingCards, _kittingCards) &&
            const DeepCollectionEquality()
                .equals(other._receivingCards, _receivingCards) &&
            (identical(other.savePrinterDevice, savePrinterDevice) ||
                other.savePrinterDevice == savePrinterDevice) &&
            const DeepCollectionEquality()
                .equals(other._printerDevices, _printerDevices));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      const DeepCollectionEquality().hash(_kittingCards),
      const DeepCollectionEquality().hash(_receivingCards),
      savePrinterDevice,
      const DeepCollectionEquality().hash(_printerDevices));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RevertKittingStateImplCopyWith<_$RevertKittingStateImpl> get copyWith =>
      __$$RevertKittingStateImplCopyWithImpl<_$RevertKittingStateImpl>(
          this, _$identity);
}

abstract class _RevertKittingState implements RevertKittingState {
  factory _RevertKittingState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final List<KittingCard> kittingCards,
      final List<ReceivingCard> receivingCards,
      final PrinterDevice? savePrinterDevice,
      final List<PrinterDevice> printerDevices}) = _$RevertKittingStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  List<KittingCard> get kittingCards;
  @override
  List<ReceivingCard> get receivingCards;
  @override
  PrinterDevice? get savePrinterDevice;
  @override
  List<PrinterDevice> get printerDevices;
  @override
  @JsonKey(ignore: true)
  _$$RevertKittingStateImplCopyWith<_$RevertKittingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

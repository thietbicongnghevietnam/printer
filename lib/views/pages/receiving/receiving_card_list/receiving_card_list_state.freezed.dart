// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receiving_card_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReceivingCardListState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  List<ReceivingCard> get receivingCards => throw _privateConstructorUsedError;
  List<PrinterDevice> get printerDevices => throw _privateConstructorUsedError;
  PrinterDevice? get selectedPrinterDevice =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReceivingCardListStateCopyWith<ReceivingCardListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceivingCardListStateCopyWith<$Res> {
  factory $ReceivingCardListStateCopyWith(ReceivingCardListState value,
          $Res Function(ReceivingCardListState) then) =
      _$ReceivingCardListStateCopyWithImpl<$Res, ReceivingCardListState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<ReceivingCard> receivingCards,
      List<PrinterDevice> printerDevices,
      PrinterDevice? selectedPrinterDevice});
}

/// @nodoc
class _$ReceivingCardListStateCopyWithImpl<$Res,
        $Val extends ReceivingCardListState>
    implements $ReceivingCardListStateCopyWith<$Res> {
  _$ReceivingCardListStateCopyWithImpl(this._value, this._then);

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
    Object? receivingCards = null,
    Object? printerDevices = null,
    Object? selectedPrinterDevice = freezed,
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
      receivingCards: null == receivingCards
          ? _value.receivingCards
          : receivingCards // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>,
      printerDevices: null == printerDevices
          ? _value.printerDevices
          : printerDevices // ignore: cast_nullable_to_non_nullable
              as List<PrinterDevice>,
      selectedPrinterDevice: freezed == selectedPrinterDevice
          ? _value.selectedPrinterDevice
          : selectedPrinterDevice // ignore: cast_nullable_to_non_nullable
              as PrinterDevice?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReceivingCardListStateImplCopyWith<$Res>
    implements $ReceivingCardListStateCopyWith<$Res> {
  factory _$$ReceivingCardListStateImplCopyWith(
          _$ReceivingCardListStateImpl value,
          $Res Function(_$ReceivingCardListStateImpl) then) =
      __$$ReceivingCardListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<ReceivingCard> receivingCards,
      List<PrinterDevice> printerDevices,
      PrinterDevice? selectedPrinterDevice});
}

/// @nodoc
class __$$ReceivingCardListStateImplCopyWithImpl<$Res>
    extends _$ReceivingCardListStateCopyWithImpl<$Res,
        _$ReceivingCardListStateImpl>
    implements _$$ReceivingCardListStateImplCopyWith<$Res> {
  __$$ReceivingCardListStateImplCopyWithImpl(
      _$ReceivingCardListStateImpl _value,
      $Res Function(_$ReceivingCardListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? receivingCards = null,
    Object? printerDevices = null,
    Object? selectedPrinterDevice = freezed,
  }) {
    return _then(_$ReceivingCardListStateImpl(
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
      receivingCards: null == receivingCards
          ? _value._receivingCards
          : receivingCards // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>,
      printerDevices: null == printerDevices
          ? _value._printerDevices
          : printerDevices // ignore: cast_nullable_to_non_nullable
              as List<PrinterDevice>,
      selectedPrinterDevice: freezed == selectedPrinterDevice
          ? _value.selectedPrinterDevice
          : selectedPrinterDevice // ignore: cast_nullable_to_non_nullable
              as PrinterDevice?,
    ));
  }
}

/// @nodoc

class _$ReceivingCardListStateImpl implements _ReceivingCardListState {
  _$ReceivingCardListStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.errorEntity = null,
      final List<ReceivingCard> receivingCards = const [],
      final List<PrinterDevice> printerDevices = const [],
      this.selectedPrinterDevice = null})
      : _receivingCards = receivingCards,
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
  final List<ReceivingCard> _receivingCards;
  @override
  @JsonKey()
  List<ReceivingCard> get receivingCards {
    if (_receivingCards is EqualUnmodifiableListView) return _receivingCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_receivingCards);
  }

  final List<PrinterDevice> _printerDevices;
  @override
  @JsonKey()
  List<PrinterDevice> get printerDevices {
    if (_printerDevices is EqualUnmodifiableListView) return _printerDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_printerDevices);
  }

  @override
  @JsonKey()
  final PrinterDevice? selectedPrinterDevice;

  @override
  String toString() {
    return 'ReceivingCardListState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, receivingCards: $receivingCards, printerDevices: $printerDevices, selectedPrinterDevice: $selectedPrinterDevice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceivingCardListStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            const DeepCollectionEquality()
                .equals(other._receivingCards, _receivingCards) &&
            const DeepCollectionEquality()
                .equals(other._printerDevices, _printerDevices) &&
            (identical(other.selectedPrinterDevice, selectedPrinterDevice) ||
                other.selectedPrinterDevice == selectedPrinterDevice));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      const DeepCollectionEquality().hash(_receivingCards),
      const DeepCollectionEquality().hash(_printerDevices),
      selectedPrinterDevice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceivingCardListStateImplCopyWith<_$ReceivingCardListStateImpl>
      get copyWith => __$$ReceivingCardListStateImplCopyWithImpl<
          _$ReceivingCardListStateImpl>(this, _$identity);
}

abstract class _ReceivingCardListState implements ReceivingCardListState {
  factory _ReceivingCardListState(
          {final PageStatus pageStatus,
          final bool processing,
          final ErrorEntity? errorEntity,
          final List<ReceivingCard> receivingCards,
          final List<PrinterDevice> printerDevices,
          final PrinterDevice? selectedPrinterDevice}) =
      _$ReceivingCardListStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  List<ReceivingCard> get receivingCards;
  @override
  List<PrinterDevice> get printerDevices;
  @override
  PrinterDevice? get selectedPrinterDevice;
  @override
  @JsonKey(ignore: true)
  _$$ReceivingCardListStateImplCopyWith<_$ReceivingCardListStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

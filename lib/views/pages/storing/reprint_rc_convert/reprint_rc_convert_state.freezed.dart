// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reprint_rc_convert_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RePrintRcConvertState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  ReceivingCard? get receivingCard => throw _privateConstructorUsedError;
  List<PrinterDevice> get printerDevices => throw _privateConstructorUsedError;
  PrinterDevice? get selectedPrinterDevice =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RePrintRcConvertStateCopyWith<RePrintRcConvertState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RePrintRcConvertStateCopyWith<$Res> {
  factory $RePrintRcConvertStateCopyWith(RePrintRcConvertState value,
          $Res Function(RePrintRcConvertState) then) =
      _$RePrintRcConvertStateCopyWithImpl<$Res, RePrintRcConvertState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      ReceivingCard? receivingCard,
      List<PrinterDevice> printerDevices,
      PrinterDevice? selectedPrinterDevice});
}

/// @nodoc
class _$RePrintRcConvertStateCopyWithImpl<$Res,
        $Val extends RePrintRcConvertState>
    implements $RePrintRcConvertStateCopyWith<$Res> {
  _$RePrintRcConvertStateCopyWithImpl(this._value, this._then);

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
    Object? receivingCard = freezed,
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
      receivingCard: freezed == receivingCard
          ? _value.receivingCard
          : receivingCard // ignore: cast_nullable_to_non_nullable
              as ReceivingCard?,
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
abstract class _$$RePrintRcConvertStateImplCopyWith<$Res>
    implements $RePrintRcConvertStateCopyWith<$Res> {
  factory _$$RePrintRcConvertStateImplCopyWith(
          _$RePrintRcConvertStateImpl value,
          $Res Function(_$RePrintRcConvertStateImpl) then) =
      __$$RePrintRcConvertStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      ReceivingCard? receivingCard,
      List<PrinterDevice> printerDevices,
      PrinterDevice? selectedPrinterDevice});
}

/// @nodoc
class __$$RePrintRcConvertStateImplCopyWithImpl<$Res>
    extends _$RePrintRcConvertStateCopyWithImpl<$Res,
        _$RePrintRcConvertStateImpl>
    implements _$$RePrintRcConvertStateImplCopyWith<$Res> {
  __$$RePrintRcConvertStateImplCopyWithImpl(_$RePrintRcConvertStateImpl _value,
      $Res Function(_$RePrintRcConvertStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? receivingCard = freezed,
    Object? printerDevices = null,
    Object? selectedPrinterDevice = freezed,
  }) {
    return _then(_$RePrintRcConvertStateImpl(
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
      receivingCard: freezed == receivingCard
          ? _value.receivingCard
          : receivingCard // ignore: cast_nullable_to_non_nullable
              as ReceivingCard?,
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

class _$RePrintRcConvertStateImpl implements _RePrintRcConvertState {
  _$RePrintRcConvertStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.errorEntity = null,
      this.receivingCard = null,
      final List<PrinterDevice> printerDevices = const [],
      this.selectedPrinterDevice = null})
      : _printerDevices = printerDevices;

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
  final ReceivingCard? receivingCard;
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
    return 'RePrintRcConvertState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, receivingCard: $receivingCard, printerDevices: $printerDevices, selectedPrinterDevice: $selectedPrinterDevice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RePrintRcConvertStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.receivingCard, receivingCard) ||
                other.receivingCard == receivingCard) &&
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
      receivingCard,
      const DeepCollectionEquality().hash(_printerDevices),
      selectedPrinterDevice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RePrintRcConvertStateImplCopyWith<_$RePrintRcConvertStateImpl>
      get copyWith => __$$RePrintRcConvertStateImplCopyWithImpl<
          _$RePrintRcConvertStateImpl>(this, _$identity);
}

abstract class _RePrintRcConvertState implements RePrintRcConvertState {
  factory _RePrintRcConvertState(
          {final PageStatus pageStatus,
          final bool processing,
          final ErrorEntity? errorEntity,
          final ReceivingCard? receivingCard,
          final List<PrinterDevice> printerDevices,
          final PrinterDevice? selectedPrinterDevice}) =
      _$RePrintRcConvertStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  ReceivingCard? get receivingCard;
  @override
  List<PrinterDevice> get printerDevices;
  @override
  PrinterDevice? get selectedPrinterDevice;
  @override
  @JsonKey(ignore: true)
  _$$RePrintRcConvertStateImplCopyWith<_$RePrintRcConvertStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

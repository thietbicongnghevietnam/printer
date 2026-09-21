// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reprint_barcode_ng_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReprintBarcodeNGState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  Barcode? get barcode => throw _privateConstructorUsedError;
  List<PrinterDevice> get printerDevices => throw _privateConstructorUsedError;
  PrinterDevice? get selectedPrinterDevice =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReprintBarcodeNGStateCopyWith<ReprintBarcodeNGState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReprintBarcodeNGStateCopyWith<$Res> {
  factory $ReprintBarcodeNGStateCopyWith(ReprintBarcodeNGState value,
          $Res Function(ReprintBarcodeNGState) then) =
      _$ReprintBarcodeNGStateCopyWithImpl<$Res, ReprintBarcodeNGState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      Barcode? barcode,
      List<PrinterDevice> printerDevices,
      PrinterDevice? selectedPrinterDevice});
}

/// @nodoc
class _$ReprintBarcodeNGStateCopyWithImpl<$Res,
        $Val extends ReprintBarcodeNGState>
    implements $ReprintBarcodeNGStateCopyWith<$Res> {
  _$ReprintBarcodeNGStateCopyWithImpl(this._value, this._then);

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
    Object? barcode = freezed,
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
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as Barcode?,
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
abstract class _$$ReprintBarcodeNGStateImplCopyWith<$Res>
    implements $ReprintBarcodeNGStateCopyWith<$Res> {
  factory _$$ReprintBarcodeNGStateImplCopyWith(
          _$ReprintBarcodeNGStateImpl value,
          $Res Function(_$ReprintBarcodeNGStateImpl) then) =
      __$$ReprintBarcodeNGStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      Barcode? barcode,
      List<PrinterDevice> printerDevices,
      PrinterDevice? selectedPrinterDevice});
}

/// @nodoc
class __$$ReprintBarcodeNGStateImplCopyWithImpl<$Res>
    extends _$ReprintBarcodeNGStateCopyWithImpl<$Res,
        _$ReprintBarcodeNGStateImpl>
    implements _$$ReprintBarcodeNGStateImplCopyWith<$Res> {
  __$$ReprintBarcodeNGStateImplCopyWithImpl(_$ReprintBarcodeNGStateImpl _value,
      $Res Function(_$ReprintBarcodeNGStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? barcode = freezed,
    Object? printerDevices = null,
    Object? selectedPrinterDevice = freezed,
  }) {
    return _then(_$ReprintBarcodeNGStateImpl(
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
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as Barcode?,
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

class _$ReprintBarcodeNGStateImpl implements _ReprintBarcodeNGState {
  _$ReprintBarcodeNGStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      this.barcode = null,
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
  final Barcode? barcode;
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
    return 'ReprintBarcodeNGState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, barcode: $barcode, printerDevices: $printerDevices, selectedPrinterDevice: $selectedPrinterDevice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReprintBarcodeNGStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
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
      barcode,
      const DeepCollectionEquality().hash(_printerDevices),
      selectedPrinterDevice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReprintBarcodeNGStateImplCopyWith<_$ReprintBarcodeNGStateImpl>
      get copyWith => __$$ReprintBarcodeNGStateImplCopyWithImpl<
          _$ReprintBarcodeNGStateImpl>(this, _$identity);
}

abstract class _ReprintBarcodeNGState implements ReprintBarcodeNGState {
  factory _ReprintBarcodeNGState(
          {final PageStatus pageStatus,
          final bool processing,
          final ErrorEntity? errorEntity,
          final Barcode? barcode,
          final List<PrinterDevice> printerDevices,
          final PrinterDevice? selectedPrinterDevice}) =
      _$ReprintBarcodeNGStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  Barcode? get barcode;
  @override
  List<PrinterDevice> get printerDevices;
  @override
  PrinterDevice? get selectedPrinterDevice;
  @override
  @JsonKey(ignore: true)
  _$$ReprintBarcodeNGStateImplCopyWith<_$ReprintBarcodeNGStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

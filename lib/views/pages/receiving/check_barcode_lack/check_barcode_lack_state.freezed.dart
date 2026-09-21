// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_barcode_lack_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CheckBarcodeLackState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  List<Barcode> get barcodes => throw _privateConstructorUsedError;
  List<ReceivingCardItem> get scannedBarcodes =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckBarcodeLackStateCopyWith<CheckBarcodeLackState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckBarcodeLackStateCopyWith<$Res> {
  factory $CheckBarcodeLackStateCopyWith(CheckBarcodeLackState value,
          $Res Function(CheckBarcodeLackState) then) =
      _$CheckBarcodeLackStateCopyWithImpl<$Res, CheckBarcodeLackState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<Barcode> barcodes,
      List<ReceivingCardItem> scannedBarcodes});
}

/// @nodoc
class _$CheckBarcodeLackStateCopyWithImpl<$Res,
        $Val extends CheckBarcodeLackState>
    implements $CheckBarcodeLackStateCopyWith<$Res> {
  _$CheckBarcodeLackStateCopyWithImpl(this._value, this._then);

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
    Object? barcodes = null,
    Object? scannedBarcodes = null,
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
      barcodes: null == barcodes
          ? _value.barcodes
          : barcodes // ignore: cast_nullable_to_non_nullable
              as List<Barcode>,
      scannedBarcodes: null == scannedBarcodes
          ? _value.scannedBarcodes
          : scannedBarcodes // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckBarcodeLackStateImplCopyWith<$Res>
    implements $CheckBarcodeLackStateCopyWith<$Res> {
  factory _$$CheckBarcodeLackStateImplCopyWith(
          _$CheckBarcodeLackStateImpl value,
          $Res Function(_$CheckBarcodeLackStateImpl) then) =
      __$$CheckBarcodeLackStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<Barcode> barcodes,
      List<ReceivingCardItem> scannedBarcodes});
}

/// @nodoc
class __$$CheckBarcodeLackStateImplCopyWithImpl<$Res>
    extends _$CheckBarcodeLackStateCopyWithImpl<$Res,
        _$CheckBarcodeLackStateImpl>
    implements _$$CheckBarcodeLackStateImplCopyWith<$Res> {
  __$$CheckBarcodeLackStateImplCopyWithImpl(_$CheckBarcodeLackStateImpl _value,
      $Res Function(_$CheckBarcodeLackStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? barcodes = null,
    Object? scannedBarcodes = null,
  }) {
    return _then(_$CheckBarcodeLackStateImpl(
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
      barcodes: null == barcodes
          ? _value._barcodes
          : barcodes // ignore: cast_nullable_to_non_nullable
              as List<Barcode>,
      scannedBarcodes: null == scannedBarcodes
          ? _value._scannedBarcodes
          : scannedBarcodes // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardItem>,
    ));
  }
}

/// @nodoc

class _$CheckBarcodeLackStateImpl implements _CheckBarcodeLackState {
  _$CheckBarcodeLackStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.errorEntity = null,
      final List<Barcode> barcodes = const [],
      final List<ReceivingCardItem> scannedBarcodes = const []})
      : _barcodes = barcodes,
        _scannedBarcodes = scannedBarcodes;

  @override
  @JsonKey()
  final PageStatus pageStatus;
  @override
  @JsonKey()
  final bool processing;
  @override
  @JsonKey()
  final ErrorEntity? errorEntity;
  final List<Barcode> _barcodes;
  @override
  @JsonKey()
  List<Barcode> get barcodes {
    if (_barcodes is EqualUnmodifiableListView) return _barcodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_barcodes);
  }

  final List<ReceivingCardItem> _scannedBarcodes;
  @override
  @JsonKey()
  List<ReceivingCardItem> get scannedBarcodes {
    if (_scannedBarcodes is EqualUnmodifiableListView) return _scannedBarcodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scannedBarcodes);
  }

  @override
  String toString() {
    return 'CheckBarcodeLackState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, barcodes: $barcodes, scannedBarcodes: $scannedBarcodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckBarcodeLackStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            const DeepCollectionEquality().equals(other._barcodes, _barcodes) &&
            const DeepCollectionEquality()
                .equals(other._scannedBarcodes, _scannedBarcodes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      const DeepCollectionEquality().hash(_barcodes),
      const DeepCollectionEquality().hash(_scannedBarcodes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckBarcodeLackStateImplCopyWith<_$CheckBarcodeLackStateImpl>
      get copyWith => __$$CheckBarcodeLackStateImplCopyWithImpl<
          _$CheckBarcodeLackStateImpl>(this, _$identity);
}

abstract class _CheckBarcodeLackState implements CheckBarcodeLackState {
  factory _CheckBarcodeLackState(
          {final PageStatus pageStatus,
          final bool processing,
          final ErrorEntity? errorEntity,
          final List<Barcode> barcodes,
          final List<ReceivingCardItem> scannedBarcodes}) =
      _$CheckBarcodeLackStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  List<Barcode> get barcodes;
  @override
  List<ReceivingCardItem> get scannedBarcodes;
  @override
  @JsonKey(ignore: true)
  _$$CheckBarcodeLackStateImplCopyWith<_$CheckBarcodeLackStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

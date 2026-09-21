// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'da_invoice_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DAInvoiceState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  DeliveryPlan? get deliveryPlan => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DAInvoiceStateCopyWith<DAInvoiceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DAInvoiceStateCopyWith<$Res> {
  factory $DAInvoiceStateCopyWith(
          DAInvoiceState value, $Res Function(DAInvoiceState) then) =
      _$DAInvoiceStateCopyWithImpl<$Res, DAInvoiceState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      DeliveryPlan? deliveryPlan});
}

/// @nodoc
class _$DAInvoiceStateCopyWithImpl<$Res, $Val extends DAInvoiceState>
    implements $DAInvoiceStateCopyWith<$Res> {
  _$DAInvoiceStateCopyWithImpl(this._value, this._then);

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
    Object? deliveryPlan = freezed,
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
      deliveryPlan: freezed == deliveryPlan
          ? _value.deliveryPlan
          : deliveryPlan // ignore: cast_nullable_to_non_nullable
              as DeliveryPlan?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DAInvoiceStateImplCopyWith<$Res>
    implements $DAInvoiceStateCopyWith<$Res> {
  factory _$$DAInvoiceStateImplCopyWith(_$DAInvoiceStateImpl value,
          $Res Function(_$DAInvoiceStateImpl) then) =
      __$$DAInvoiceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      DeliveryPlan? deliveryPlan});
}

/// @nodoc
class __$$DAInvoiceStateImplCopyWithImpl<$Res>
    extends _$DAInvoiceStateCopyWithImpl<$Res, _$DAInvoiceStateImpl>
    implements _$$DAInvoiceStateImplCopyWith<$Res> {
  __$$DAInvoiceStateImplCopyWithImpl(
      _$DAInvoiceStateImpl _value, $Res Function(_$DAInvoiceStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? deliveryPlan = freezed,
  }) {
    return _then(_$DAInvoiceStateImpl(
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
      deliveryPlan: freezed == deliveryPlan
          ? _value.deliveryPlan
          : deliveryPlan // ignore: cast_nullable_to_non_nullable
              as DeliveryPlan?,
    ));
  }
}

/// @nodoc

class _$DAInvoiceStateImpl implements _DAInvoiceState {
  _$DAInvoiceStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.errorEntity = null,
      this.deliveryPlan = null});

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
  final DeliveryPlan? deliveryPlan;

  @override
  String toString() {
    return 'DAInvoiceState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, deliveryPlan: $deliveryPlan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DAInvoiceStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.deliveryPlan, deliveryPlan) ||
                other.deliveryPlan == deliveryPlan));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, pageStatus, processing, errorEntity, deliveryPlan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DAInvoiceStateImplCopyWith<_$DAInvoiceStateImpl> get copyWith =>
      __$$DAInvoiceStateImplCopyWithImpl<_$DAInvoiceStateImpl>(
          this, _$identity);
}

abstract class _DAInvoiceState implements DAInvoiceState {
  factory _DAInvoiceState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final DeliveryPlan? deliveryPlan}) = _$DAInvoiceStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  DeliveryPlan? get deliveryPlan;
  @override
  @JsonKey(ignore: true)
  _$$DAInvoiceStateImplCopyWith<_$DAInvoiceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

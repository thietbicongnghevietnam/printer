// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_da_invoice_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectDAInvoiceState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  DeliveryPlanFilter? get filter => throw _privateConstructorUsedError;
  bool get isFiltering => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  List<Vendor> get vendors => throw _privateConstructorUsedError;
  List<DeliveryPlan> get daInvoices => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectDAInvoiceStateCopyWith<SelectDAInvoiceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectDAInvoiceStateCopyWith<$Res> {
  factory $SelectDAInvoiceStateCopyWith(SelectDAInvoiceState value,
          $Res Function(SelectDAInvoiceState) then) =
      _$SelectDAInvoiceStateCopyWithImpl<$Res, SelectDAInvoiceState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      DeliveryPlanFilter? filter,
      bool isFiltering,
      int page,
      List<Vendor> vendors,
      List<DeliveryPlan> daInvoices});
}

/// @nodoc
class _$SelectDAInvoiceStateCopyWithImpl<$Res,
        $Val extends SelectDAInvoiceState>
    implements $SelectDAInvoiceStateCopyWith<$Res> {
  _$SelectDAInvoiceStateCopyWithImpl(this._value, this._then);

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
    Object? filter = freezed,
    Object? isFiltering = null,
    Object? page = null,
    Object? vendors = null,
    Object? daInvoices = null,
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
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as DeliveryPlanFilter?,
      isFiltering: null == isFiltering
          ? _value.isFiltering
          : isFiltering // ignore: cast_nullable_to_non_nullable
              as bool,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      vendors: null == vendors
          ? _value.vendors
          : vendors // ignore: cast_nullable_to_non_nullable
              as List<Vendor>,
      daInvoices: null == daInvoices
          ? _value.daInvoices
          : daInvoices // ignore: cast_nullable_to_non_nullable
              as List<DeliveryPlan>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectDAInvoiceStateImplCopyWith<$Res>
    implements $SelectDAInvoiceStateCopyWith<$Res> {
  factory _$$SelectDAInvoiceStateImplCopyWith(_$SelectDAInvoiceStateImpl value,
          $Res Function(_$SelectDAInvoiceStateImpl) then) =
      __$$SelectDAInvoiceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      DeliveryPlanFilter? filter,
      bool isFiltering,
      int page,
      List<Vendor> vendors,
      List<DeliveryPlan> daInvoices});
}

/// @nodoc
class __$$SelectDAInvoiceStateImplCopyWithImpl<$Res>
    extends _$SelectDAInvoiceStateCopyWithImpl<$Res, _$SelectDAInvoiceStateImpl>
    implements _$$SelectDAInvoiceStateImplCopyWith<$Res> {
  __$$SelectDAInvoiceStateImplCopyWithImpl(_$SelectDAInvoiceStateImpl _value,
      $Res Function(_$SelectDAInvoiceStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? filter = freezed,
    Object? isFiltering = null,
    Object? page = null,
    Object? vendors = null,
    Object? daInvoices = null,
  }) {
    return _then(_$SelectDAInvoiceStateImpl(
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
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as DeliveryPlanFilter?,
      isFiltering: null == isFiltering
          ? _value.isFiltering
          : isFiltering // ignore: cast_nullable_to_non_nullable
              as bool,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      vendors: null == vendors
          ? _value._vendors
          : vendors // ignore: cast_nullable_to_non_nullable
              as List<Vendor>,
      daInvoices: null == daInvoices
          ? _value._daInvoices
          : daInvoices // ignore: cast_nullable_to_non_nullable
              as List<DeliveryPlan>,
    ));
  }
}

/// @nodoc

class _$SelectDAInvoiceStateImpl implements _SelectDAInvoiceState {
  _$SelectDAInvoiceStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.errorEntity = null,
      this.filter = null,
      this.isFiltering = false,
      this.page = 1,
      final List<Vendor> vendors = const [],
      final List<DeliveryPlan> daInvoices = const []})
      : _vendors = vendors,
        _daInvoices = daInvoices;

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
  final DeliveryPlanFilter? filter;
  @override
  @JsonKey()
  final bool isFiltering;
  @override
  @JsonKey()
  final int page;
  final List<Vendor> _vendors;
  @override
  @JsonKey()
  List<Vendor> get vendors {
    if (_vendors is EqualUnmodifiableListView) return _vendors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vendors);
  }

  final List<DeliveryPlan> _daInvoices;
  @override
  @JsonKey()
  List<DeliveryPlan> get daInvoices {
    if (_daInvoices is EqualUnmodifiableListView) return _daInvoices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_daInvoices);
  }

  @override
  String toString() {
    return 'SelectDAInvoiceState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, filter: $filter, isFiltering: $isFiltering, page: $page, vendors: $vendors, daInvoices: $daInvoices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectDAInvoiceStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.isFiltering, isFiltering) ||
                other.isFiltering == isFiltering) &&
            (identical(other.page, page) || other.page == page) &&
            const DeepCollectionEquality().equals(other._vendors, _vendors) &&
            const DeepCollectionEquality()
                .equals(other._daInvoices, _daInvoices));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      filter,
      isFiltering,
      page,
      const DeepCollectionEquality().hash(_vendors),
      const DeepCollectionEquality().hash(_daInvoices));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectDAInvoiceStateImplCopyWith<_$SelectDAInvoiceStateImpl>
      get copyWith =>
          __$$SelectDAInvoiceStateImplCopyWithImpl<_$SelectDAInvoiceStateImpl>(
              this, _$identity);
}

abstract class _SelectDAInvoiceState implements SelectDAInvoiceState {
  factory _SelectDAInvoiceState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final DeliveryPlanFilter? filter,
      final bool isFiltering,
      final int page,
      final List<Vendor> vendors,
      final List<DeliveryPlan> daInvoices}) = _$SelectDAInvoiceStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  DeliveryPlanFilter? get filter;
  @override
  bool get isFiltering;
  @override
  int get page;
  @override
  List<Vendor> get vendors;
  @override
  List<DeliveryPlan> get daInvoices;
  @override
  @JsonKey(ignore: true)
  _$$SelectDAInvoiceStateImplCopyWith<_$SelectDAInvoiceStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kitting_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$KittingState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  List<KittingDetail> get kittingDetails => throw _privateConstructorUsedError;
  List<int> get selectedKittingDetails => throw _privateConstructorUsedError;
  List<OrderBlock> get orderBlocks => throw _privateConstructorUsedError;
  List<SuggestPath> get suggestPaths => throw _privateConstructorUsedError;
  KittingFilter get kittingFilter => throw _privateConstructorUsedError;
  StorageCard? get scanningItem => throw _privateConstructorUsedError;
  String? get scanningLocation => throw _privateConstructorUsedError;
  List<StorageCard> get kittingBoxScanned => throw _privateConstructorUsedError;
  List<MaterialLocationResponseModel>? get receivingCardInLocation =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KittingStateCopyWith<KittingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KittingStateCopyWith<$Res> {
  factory $KittingStateCopyWith(
          KittingState value, $Res Function(KittingState) then) =
      _$KittingStateCopyWithImpl<$Res, KittingState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<KittingDetail> kittingDetails,
      List<int> selectedKittingDetails,
      List<OrderBlock> orderBlocks,
      List<SuggestPath> suggestPaths,
      KittingFilter kittingFilter,
      StorageCard? scanningItem,
      String? scanningLocation,
      List<StorageCard> kittingBoxScanned,
      List<MaterialLocationResponseModel>? receivingCardInLocation});

  $KittingFilterCopyWith<$Res> get kittingFilter;
}

/// @nodoc
class _$KittingStateCopyWithImpl<$Res, $Val extends KittingState>
    implements $KittingStateCopyWith<$Res> {
  _$KittingStateCopyWithImpl(this._value, this._then);

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
    Object? kittingDetails = null,
    Object? selectedKittingDetails = null,
    Object? orderBlocks = null,
    Object? suggestPaths = null,
    Object? kittingFilter = null,
    Object? scanningItem = freezed,
    Object? scanningLocation = freezed,
    Object? kittingBoxScanned = null,
    Object? receivingCardInLocation = freezed,
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
      kittingDetails: null == kittingDetails
          ? _value.kittingDetails
          : kittingDetails // ignore: cast_nullable_to_non_nullable
              as List<KittingDetail>,
      selectedKittingDetails: null == selectedKittingDetails
          ? _value.selectedKittingDetails
          : selectedKittingDetails // ignore: cast_nullable_to_non_nullable
              as List<int>,
      orderBlocks: null == orderBlocks
          ? _value.orderBlocks
          : orderBlocks // ignore: cast_nullable_to_non_nullable
              as List<OrderBlock>,
      suggestPaths: null == suggestPaths
          ? _value.suggestPaths
          : suggestPaths // ignore: cast_nullable_to_non_nullable
              as List<SuggestPath>,
      kittingFilter: null == kittingFilter
          ? _value.kittingFilter
          : kittingFilter // ignore: cast_nullable_to_non_nullable
              as KittingFilter,
      scanningItem: freezed == scanningItem
          ? _value.scanningItem
          : scanningItem // ignore: cast_nullable_to_non_nullable
              as StorageCard?,
      scanningLocation: freezed == scanningLocation
          ? _value.scanningLocation
          : scanningLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      kittingBoxScanned: null == kittingBoxScanned
          ? _value.kittingBoxScanned
          : kittingBoxScanned // ignore: cast_nullable_to_non_nullable
              as List<StorageCard>,
      receivingCardInLocation: freezed == receivingCardInLocation
          ? _value.receivingCardInLocation
          : receivingCardInLocation // ignore: cast_nullable_to_non_nullable
              as List<MaterialLocationResponseModel>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $KittingFilterCopyWith<$Res> get kittingFilter {
    return $KittingFilterCopyWith<$Res>(_value.kittingFilter, (value) {
      return _then(_value.copyWith(kittingFilter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$KittingStateImplCopyWith<$Res>
    implements $KittingStateCopyWith<$Res> {
  factory _$$KittingStateImplCopyWith(
          _$KittingStateImpl value, $Res Function(_$KittingStateImpl) then) =
      __$$KittingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      List<KittingDetail> kittingDetails,
      List<int> selectedKittingDetails,
      List<OrderBlock> orderBlocks,
      List<SuggestPath> suggestPaths,
      KittingFilter kittingFilter,
      StorageCard? scanningItem,
      String? scanningLocation,
      List<StorageCard> kittingBoxScanned,
      List<MaterialLocationResponseModel>? receivingCardInLocation});

  @override
  $KittingFilterCopyWith<$Res> get kittingFilter;
}

/// @nodoc
class __$$KittingStateImplCopyWithImpl<$Res>
    extends _$KittingStateCopyWithImpl<$Res, _$KittingStateImpl>
    implements _$$KittingStateImplCopyWith<$Res> {
  __$$KittingStateImplCopyWithImpl(
      _$KittingStateImpl _value, $Res Function(_$KittingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? kittingDetails = null,
    Object? selectedKittingDetails = null,
    Object? orderBlocks = null,
    Object? suggestPaths = null,
    Object? kittingFilter = null,
    Object? scanningItem = freezed,
    Object? scanningLocation = freezed,
    Object? kittingBoxScanned = null,
    Object? receivingCardInLocation = freezed,
  }) {
    return _then(_$KittingStateImpl(
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
      kittingDetails: null == kittingDetails
          ? _value._kittingDetails
          : kittingDetails // ignore: cast_nullable_to_non_nullable
              as List<KittingDetail>,
      selectedKittingDetails: null == selectedKittingDetails
          ? _value._selectedKittingDetails
          : selectedKittingDetails // ignore: cast_nullable_to_non_nullable
              as List<int>,
      orderBlocks: null == orderBlocks
          ? _value._orderBlocks
          : orderBlocks // ignore: cast_nullable_to_non_nullable
              as List<OrderBlock>,
      suggestPaths: null == suggestPaths
          ? _value._suggestPaths
          : suggestPaths // ignore: cast_nullable_to_non_nullable
              as List<SuggestPath>,
      kittingFilter: null == kittingFilter
          ? _value.kittingFilter
          : kittingFilter // ignore: cast_nullable_to_non_nullable
              as KittingFilter,
      scanningItem: freezed == scanningItem
          ? _value.scanningItem
          : scanningItem // ignore: cast_nullable_to_non_nullable
              as StorageCard?,
      scanningLocation: freezed == scanningLocation
          ? _value.scanningLocation
          : scanningLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      kittingBoxScanned: null == kittingBoxScanned
          ? _value._kittingBoxScanned
          : kittingBoxScanned // ignore: cast_nullable_to_non_nullable
              as List<StorageCard>,
      receivingCardInLocation: freezed == receivingCardInLocation
          ? _value._receivingCardInLocation
          : receivingCardInLocation // ignore: cast_nullable_to_non_nullable
              as List<MaterialLocationResponseModel>?,
    ));
  }
}

/// @nodoc

class _$KittingStateImpl implements _KittingState {
  _$KittingStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.errorEntity = null,
      final List<KittingDetail> kittingDetails = const [],
      final List<int> selectedKittingDetails = const [],
      final List<OrderBlock> orderBlocks = const [],
      final List<SuggestPath> suggestPaths = const [],
      this.kittingFilter = const KittingFilter(kittingType: KittingType.fa),
      this.scanningItem = null,
      this.scanningLocation = null,
      final List<StorageCard> kittingBoxScanned = const [],
      final List<MaterialLocationResponseModel>? receivingCardInLocation =
          null})
      : _kittingDetails = kittingDetails,
        _selectedKittingDetails = selectedKittingDetails,
        _orderBlocks = orderBlocks,
        _suggestPaths = suggestPaths,
        _kittingBoxScanned = kittingBoxScanned,
        _receivingCardInLocation = receivingCardInLocation;

  @override
  @JsonKey()
  final PageStatus pageStatus;
  @override
  @JsonKey()
  final bool processing;
  @override
  @JsonKey()
  final ErrorEntity? errorEntity;
  final List<KittingDetail> _kittingDetails;
  @override
  @JsonKey()
  List<KittingDetail> get kittingDetails {
    if (_kittingDetails is EqualUnmodifiableListView) return _kittingDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kittingDetails);
  }

  final List<int> _selectedKittingDetails;
  @override
  @JsonKey()
  List<int> get selectedKittingDetails {
    if (_selectedKittingDetails is EqualUnmodifiableListView)
      return _selectedKittingDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedKittingDetails);
  }

  final List<OrderBlock> _orderBlocks;
  @override
  @JsonKey()
  List<OrderBlock> get orderBlocks {
    if (_orderBlocks is EqualUnmodifiableListView) return _orderBlocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderBlocks);
  }

  final List<SuggestPath> _suggestPaths;
  @override
  @JsonKey()
  List<SuggestPath> get suggestPaths {
    if (_suggestPaths is EqualUnmodifiableListView) return _suggestPaths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestPaths);
  }

  @override
  @JsonKey()
  final KittingFilter kittingFilter;
  @override
  @JsonKey()
  final StorageCard? scanningItem;
  @override
  @JsonKey()
  final String? scanningLocation;
  final List<StorageCard> _kittingBoxScanned;
  @override
  @JsonKey()
  List<StorageCard> get kittingBoxScanned {
    if (_kittingBoxScanned is EqualUnmodifiableListView)
      return _kittingBoxScanned;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kittingBoxScanned);
  }

  final List<MaterialLocationResponseModel>? _receivingCardInLocation;
  @override
  @JsonKey()
  List<MaterialLocationResponseModel>? get receivingCardInLocation {
    final value = _receivingCardInLocation;
    if (value == null) return null;
    if (_receivingCardInLocation is EqualUnmodifiableListView)
      return _receivingCardInLocation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'KittingState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, kittingDetails: $kittingDetails, selectedKittingDetails: $selectedKittingDetails, orderBlocks: $orderBlocks, suggestPaths: $suggestPaths, kittingFilter: $kittingFilter, scanningItem: $scanningItem, scanningLocation: $scanningLocation, kittingBoxScanned: $kittingBoxScanned, receivingCardInLocation: $receivingCardInLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KittingStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            const DeepCollectionEquality()
                .equals(other._kittingDetails, _kittingDetails) &&
            const DeepCollectionEquality().equals(
                other._selectedKittingDetails, _selectedKittingDetails) &&
            const DeepCollectionEquality()
                .equals(other._orderBlocks, _orderBlocks) &&
            const DeepCollectionEquality()
                .equals(other._suggestPaths, _suggestPaths) &&
            (identical(other.kittingFilter, kittingFilter) ||
                other.kittingFilter == kittingFilter) &&
            (identical(other.scanningItem, scanningItem) ||
                other.scanningItem == scanningItem) &&
            (identical(other.scanningLocation, scanningLocation) ||
                other.scanningLocation == scanningLocation) &&
            const DeepCollectionEquality()
                .equals(other._kittingBoxScanned, _kittingBoxScanned) &&
            const DeepCollectionEquality().equals(
                other._receivingCardInLocation, _receivingCardInLocation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      const DeepCollectionEquality().hash(_kittingDetails),
      const DeepCollectionEquality().hash(_selectedKittingDetails),
      const DeepCollectionEquality().hash(_orderBlocks),
      const DeepCollectionEquality().hash(_suggestPaths),
      kittingFilter,
      scanningItem,
      scanningLocation,
      const DeepCollectionEquality().hash(_kittingBoxScanned),
      const DeepCollectionEquality().hash(_receivingCardInLocation));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KittingStateImplCopyWith<_$KittingStateImpl> get copyWith =>
      __$$KittingStateImplCopyWithImpl<_$KittingStateImpl>(this, _$identity);
}

abstract class _KittingState implements KittingState {
  factory _KittingState(
          {final PageStatus pageStatus,
          final bool processing,
          final ErrorEntity? errorEntity,
          final List<KittingDetail> kittingDetails,
          final List<int> selectedKittingDetails,
          final List<OrderBlock> orderBlocks,
          final List<SuggestPath> suggestPaths,
          final KittingFilter kittingFilter,
          final StorageCard? scanningItem,
          final String? scanningLocation,
          final List<StorageCard> kittingBoxScanned,
          final List<MaterialLocationResponseModel>? receivingCardInLocation}) =
      _$KittingStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  List<KittingDetail> get kittingDetails;
  @override
  List<int> get selectedKittingDetails;
  @override
  List<OrderBlock> get orderBlocks;
  @override
  List<SuggestPath> get suggestPaths;
  @override
  KittingFilter get kittingFilter;
  @override
  StorageCard? get scanningItem;
  @override
  String? get scanningLocation;
  @override
  List<StorageCard> get kittingBoxScanned;
  @override
  List<MaterialLocationResponseModel>? get receivingCardInLocation;
  @override
  @JsonKey(ignore: true)
  _$$KittingStateImplCopyWith<_$KittingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

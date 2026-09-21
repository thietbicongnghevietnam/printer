// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'iqc_borrow_receiving_card_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IQCBorrowReceivingCardState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  IQCBorrowType get icqBorrowType => throw _privateConstructorUsedError;
  String get qtyInput => throw _privateConstructorUsedError;
  ReceivingCard? get currentReCard => throw _privateConstructorUsedError;
  PlantTypeFrequencyResponseModel? get currentPlant =>
      throw _privateConstructorUsedError;
  SlocInfoFromPlantResponseModel? get currentSloc =>
      throw _privateConstructorUsedError;
  List<SlocInfoFromPlantResponseModel> get currentListSloc =>
      throw _privateConstructorUsedError;
  List<PlantTypeFrequencyResponseModel> get listPlant =>
      throw _privateConstructorUsedError;
  List<ReceivingCardItem> get listBoxInScanned =>
      throw _privateConstructorUsedError;
  List<BoxQCReturn> get listBoxQtyReturn => throw _privateConstructorUsedError;
  List<QtyQCHistory> get listQtHistory => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IQCBorrowReceivingCardStateCopyWith<IQCBorrowReceivingCardState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IQCBorrowReceivingCardStateCopyWith<$Res> {
  factory $IQCBorrowReceivingCardStateCopyWith(
          IQCBorrowReceivingCardState value,
          $Res Function(IQCBorrowReceivingCardState) then) =
      _$IQCBorrowReceivingCardStateCopyWithImpl<$Res,
          IQCBorrowReceivingCardState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      IQCBorrowType icqBorrowType,
      String qtyInput,
      ReceivingCard? currentReCard,
      PlantTypeFrequencyResponseModel? currentPlant,
      SlocInfoFromPlantResponseModel? currentSloc,
      List<SlocInfoFromPlantResponseModel> currentListSloc,
      List<PlantTypeFrequencyResponseModel> listPlant,
      List<ReceivingCardItem> listBoxInScanned,
      List<BoxQCReturn> listBoxQtyReturn,
      List<QtyQCHistory> listQtHistory});
}

/// @nodoc
class _$IQCBorrowReceivingCardStateCopyWithImpl<$Res,
        $Val extends IQCBorrowReceivingCardState>
    implements $IQCBorrowReceivingCardStateCopyWith<$Res> {
  _$IQCBorrowReceivingCardStateCopyWithImpl(this._value, this._then);

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
    Object? icqBorrowType = null,
    Object? qtyInput = null,
    Object? currentReCard = freezed,
    Object? currentPlant = freezed,
    Object? currentSloc = freezed,
    Object? currentListSloc = null,
    Object? listPlant = null,
    Object? listBoxInScanned = null,
    Object? listBoxQtyReturn = null,
    Object? listQtHistory = null,
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
      icqBorrowType: null == icqBorrowType
          ? _value.icqBorrowType
          : icqBorrowType // ignore: cast_nullable_to_non_nullable
              as IQCBorrowType,
      qtyInput: null == qtyInput
          ? _value.qtyInput
          : qtyInput // ignore: cast_nullable_to_non_nullable
              as String,
      currentReCard: freezed == currentReCard
          ? _value.currentReCard
          : currentReCard // ignore: cast_nullable_to_non_nullable
              as ReceivingCard?,
      currentPlant: freezed == currentPlant
          ? _value.currentPlant
          : currentPlant // ignore: cast_nullable_to_non_nullable
              as PlantTypeFrequencyResponseModel?,
      currentSloc: freezed == currentSloc
          ? _value.currentSloc
          : currentSloc // ignore: cast_nullable_to_non_nullable
              as SlocInfoFromPlantResponseModel?,
      currentListSloc: null == currentListSloc
          ? _value.currentListSloc
          : currentListSloc // ignore: cast_nullable_to_non_nullable
              as List<SlocInfoFromPlantResponseModel>,
      listPlant: null == listPlant
          ? _value.listPlant
          : listPlant // ignore: cast_nullable_to_non_nullable
              as List<PlantTypeFrequencyResponseModel>,
      listBoxInScanned: null == listBoxInScanned
          ? _value.listBoxInScanned
          : listBoxInScanned // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardItem>,
      listBoxQtyReturn: null == listBoxQtyReturn
          ? _value.listBoxQtyReturn
          : listBoxQtyReturn // ignore: cast_nullable_to_non_nullable
              as List<BoxQCReturn>,
      listQtHistory: null == listQtHistory
          ? _value.listQtHistory
          : listQtHistory // ignore: cast_nullable_to_non_nullable
              as List<QtyQCHistory>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IQCBorrowReceivingCardStateImplCopyWith<$Res>
    implements $IQCBorrowReceivingCardStateCopyWith<$Res> {
  factory _$$IQCBorrowReceivingCardStateImplCopyWith(
          _$IQCBorrowReceivingCardStateImpl value,
          $Res Function(_$IQCBorrowReceivingCardStateImpl) then) =
      __$$IQCBorrowReceivingCardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      IQCBorrowType icqBorrowType,
      String qtyInput,
      ReceivingCard? currentReCard,
      PlantTypeFrequencyResponseModel? currentPlant,
      SlocInfoFromPlantResponseModel? currentSloc,
      List<SlocInfoFromPlantResponseModel> currentListSloc,
      List<PlantTypeFrequencyResponseModel> listPlant,
      List<ReceivingCardItem> listBoxInScanned,
      List<BoxQCReturn> listBoxQtyReturn,
      List<QtyQCHistory> listQtHistory});
}

/// @nodoc
class __$$IQCBorrowReceivingCardStateImplCopyWithImpl<$Res>
    extends _$IQCBorrowReceivingCardStateCopyWithImpl<$Res,
        _$IQCBorrowReceivingCardStateImpl>
    implements _$$IQCBorrowReceivingCardStateImplCopyWith<$Res> {
  __$$IQCBorrowReceivingCardStateImplCopyWithImpl(
      _$IQCBorrowReceivingCardStateImpl _value,
      $Res Function(_$IQCBorrowReceivingCardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? icqBorrowType = null,
    Object? qtyInput = null,
    Object? currentReCard = freezed,
    Object? currentPlant = freezed,
    Object? currentSloc = freezed,
    Object? currentListSloc = null,
    Object? listPlant = null,
    Object? listBoxInScanned = null,
    Object? listBoxQtyReturn = null,
    Object? listQtHistory = null,
  }) {
    return _then(_$IQCBorrowReceivingCardStateImpl(
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
      icqBorrowType: null == icqBorrowType
          ? _value.icqBorrowType
          : icqBorrowType // ignore: cast_nullable_to_non_nullable
              as IQCBorrowType,
      qtyInput: null == qtyInput
          ? _value.qtyInput
          : qtyInput // ignore: cast_nullable_to_non_nullable
              as String,
      currentReCard: freezed == currentReCard
          ? _value.currentReCard
          : currentReCard // ignore: cast_nullable_to_non_nullable
              as ReceivingCard?,
      currentPlant: freezed == currentPlant
          ? _value.currentPlant
          : currentPlant // ignore: cast_nullable_to_non_nullable
              as PlantTypeFrequencyResponseModel?,
      currentSloc: freezed == currentSloc
          ? _value.currentSloc
          : currentSloc // ignore: cast_nullable_to_non_nullable
              as SlocInfoFromPlantResponseModel?,
      currentListSloc: null == currentListSloc
          ? _value._currentListSloc
          : currentListSloc // ignore: cast_nullable_to_non_nullable
              as List<SlocInfoFromPlantResponseModel>,
      listPlant: null == listPlant
          ? _value._listPlant
          : listPlant // ignore: cast_nullable_to_non_nullable
              as List<PlantTypeFrequencyResponseModel>,
      listBoxInScanned: null == listBoxInScanned
          ? _value._listBoxInScanned
          : listBoxInScanned // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardItem>,
      listBoxQtyReturn: null == listBoxQtyReturn
          ? _value._listBoxQtyReturn
          : listBoxQtyReturn // ignore: cast_nullable_to_non_nullable
              as List<BoxQCReturn>,
      listQtHistory: null == listQtHistory
          ? _value._listQtHistory
          : listQtHistory // ignore: cast_nullable_to_non_nullable
              as List<QtyQCHistory>,
    ));
  }
}

/// @nodoc

class _$IQCBorrowReceivingCardStateImpl
    implements _IQCBorrowReceivingCardState {
  _$IQCBorrowReceivingCardStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      this.icqBorrowType = IQCBorrowType.borrowRc,
      this.qtyInput = '',
      this.currentReCard = null,
      this.currentPlant = null,
      this.currentSloc = null,
      final List<SlocInfoFromPlantResponseModel> currentListSloc = const [],
      final List<PlantTypeFrequencyResponseModel> listPlant = const [],
      final List<ReceivingCardItem> listBoxInScanned = const [],
      final List<BoxQCReturn> listBoxQtyReturn = const [],
      final List<QtyQCHistory> listQtHistory = const []})
      : _currentListSloc = currentListSloc,
        _listPlant = listPlant,
        _listBoxInScanned = listBoxInScanned,
        _listBoxQtyReturn = listBoxQtyReturn,
        _listQtHistory = listQtHistory;

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
  final IQCBorrowType icqBorrowType;
  @override
  @JsonKey()
  final String qtyInput;
  @override
  @JsonKey()
  final ReceivingCard? currentReCard;
  @override
  @JsonKey()
  final PlantTypeFrequencyResponseModel? currentPlant;
  @override
  @JsonKey()
  final SlocInfoFromPlantResponseModel? currentSloc;
  final List<SlocInfoFromPlantResponseModel> _currentListSloc;
  @override
  @JsonKey()
  List<SlocInfoFromPlantResponseModel> get currentListSloc {
    if (_currentListSloc is EqualUnmodifiableListView) return _currentListSloc;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentListSloc);
  }

  final List<PlantTypeFrequencyResponseModel> _listPlant;
  @override
  @JsonKey()
  List<PlantTypeFrequencyResponseModel> get listPlant {
    if (_listPlant is EqualUnmodifiableListView) return _listPlant;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listPlant);
  }

  final List<ReceivingCardItem> _listBoxInScanned;
  @override
  @JsonKey()
  List<ReceivingCardItem> get listBoxInScanned {
    if (_listBoxInScanned is EqualUnmodifiableListView)
      return _listBoxInScanned;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listBoxInScanned);
  }

  final List<BoxQCReturn> _listBoxQtyReturn;
  @override
  @JsonKey()
  List<BoxQCReturn> get listBoxQtyReturn {
    if (_listBoxQtyReturn is EqualUnmodifiableListView)
      return _listBoxQtyReturn;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listBoxQtyReturn);
  }

  final List<QtyQCHistory> _listQtHistory;
  @override
  @JsonKey()
  List<QtyQCHistory> get listQtHistory {
    if (_listQtHistory is EqualUnmodifiableListView) return _listQtHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listQtHistory);
  }

  @override
  String toString() {
    return 'IQCBorrowReceivingCardState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, icqBorrowType: $icqBorrowType, qtyInput: $qtyInput, currentReCard: $currentReCard, currentPlant: $currentPlant, currentSloc: $currentSloc, currentListSloc: $currentListSloc, listPlant: $listPlant, listBoxInScanned: $listBoxInScanned, listBoxQtyReturn: $listBoxQtyReturn, listQtHistory: $listQtHistory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IQCBorrowReceivingCardStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.icqBorrowType, icqBorrowType) ||
                other.icqBorrowType == icqBorrowType) &&
            (identical(other.qtyInput, qtyInput) ||
                other.qtyInput == qtyInput) &&
            (identical(other.currentReCard, currentReCard) ||
                other.currentReCard == currentReCard) &&
            (identical(other.currentPlant, currentPlant) ||
                other.currentPlant == currentPlant) &&
            (identical(other.currentSloc, currentSloc) ||
                other.currentSloc == currentSloc) &&
            const DeepCollectionEquality()
                .equals(other._currentListSloc, _currentListSloc) &&
            const DeepCollectionEquality()
                .equals(other._listPlant, _listPlant) &&
            const DeepCollectionEquality()
                .equals(other._listBoxInScanned, _listBoxInScanned) &&
            const DeepCollectionEquality()
                .equals(other._listBoxQtyReturn, _listBoxQtyReturn) &&
            const DeepCollectionEquality()
                .equals(other._listQtHistory, _listQtHistory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      icqBorrowType,
      qtyInput,
      currentReCard,
      currentPlant,
      currentSloc,
      const DeepCollectionEquality().hash(_currentListSloc),
      const DeepCollectionEquality().hash(_listPlant),
      const DeepCollectionEquality().hash(_listBoxInScanned),
      const DeepCollectionEquality().hash(_listBoxQtyReturn),
      const DeepCollectionEquality().hash(_listQtHistory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IQCBorrowReceivingCardStateImplCopyWith<_$IQCBorrowReceivingCardStateImpl>
      get copyWith => __$$IQCBorrowReceivingCardStateImplCopyWithImpl<
          _$IQCBorrowReceivingCardStateImpl>(this, _$identity);
}

abstract class _IQCBorrowReceivingCardState
    implements IQCBorrowReceivingCardState {
  factory _IQCBorrowReceivingCardState(
          {final PageStatus pageStatus,
          final bool processing,
          final ErrorEntity? errorEntity,
          final IQCBorrowType icqBorrowType,
          final String qtyInput,
          final ReceivingCard? currentReCard,
          final PlantTypeFrequencyResponseModel? currentPlant,
          final SlocInfoFromPlantResponseModel? currentSloc,
          final List<SlocInfoFromPlantResponseModel> currentListSloc,
          final List<PlantTypeFrequencyResponseModel> listPlant,
          final List<ReceivingCardItem> listBoxInScanned,
          final List<BoxQCReturn> listBoxQtyReturn,
          final List<QtyQCHistory> listQtHistory}) =
      _$IQCBorrowReceivingCardStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  IQCBorrowType get icqBorrowType;
  @override
  String get qtyInput;
  @override
  ReceivingCard? get currentReCard;
  @override
  PlantTypeFrequencyResponseModel? get currentPlant;
  @override
  SlocInfoFromPlantResponseModel? get currentSloc;
  @override
  List<SlocInfoFromPlantResponseModel> get currentListSloc;
  @override
  List<PlantTypeFrequencyResponseModel> get listPlant;
  @override
  List<ReceivingCardItem> get listBoxInScanned;
  @override
  List<BoxQCReturn> get listBoxQtyReturn;
  @override
  List<QtyQCHistory> get listQtHistory;
  @override
  @JsonKey(ignore: true)
  _$$IQCBorrowReceivingCardStateImplCopyWith<_$IQCBorrowReceivingCardStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

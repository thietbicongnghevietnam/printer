// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance_rc_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BalanceRcState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  BalanceScanType get balanceScanType => throw _privateConstructorUsedError;
  int? get updateQty => throw _privateConstructorUsedError;
  int? get backUpTotalBalance => throw _privateConstructorUsedError;
  int? get currentQty => throw _privateConstructorUsedError;
  int? get boxTotal => throw _privateConstructorUsedError;
  bool get balanceAllBox => throw _privateConstructorUsedError;
  bool get balanceAllLot => throw _privateConstructorUsedError;
  ReceivingCard? get receivingCard => throw _privateConstructorUsedError;
  Barcode? get boxCard => throw _privateConstructorUsedError;
  List<BalanceBoxRequestModel> get balanceBoxList =>
      throw _privateConstructorUsedError;
  List<ReceivingCardItem> get boxCardWillBalance =>
      throw _privateConstructorUsedError;
  List<ReceivingCardItem> get boxListShowTotalChange =>
      throw _privateConstructorUsedError;
  List<ReceivingCard> get listReceivingCardScanned =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BalanceRcStateCopyWith<BalanceRcState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceRcStateCopyWith<$Res> {
  factory $BalanceRcStateCopyWith(
          BalanceRcState value, $Res Function(BalanceRcState) then) =
      _$BalanceRcStateCopyWithImpl<$Res, BalanceRcState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      BalanceScanType balanceScanType,
      int? updateQty,
      int? backUpTotalBalance,
      int? currentQty,
      int? boxTotal,
      bool balanceAllBox,
      bool balanceAllLot,
      ReceivingCard? receivingCard,
      Barcode? boxCard,
      List<BalanceBoxRequestModel> balanceBoxList,
      List<ReceivingCardItem> boxCardWillBalance,
      List<ReceivingCardItem> boxListShowTotalChange,
      List<ReceivingCard> listReceivingCardScanned});
}

/// @nodoc
class _$BalanceRcStateCopyWithImpl<$Res, $Val extends BalanceRcState>
    implements $BalanceRcStateCopyWith<$Res> {
  _$BalanceRcStateCopyWithImpl(this._value, this._then);

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
    Object? balanceScanType = null,
    Object? updateQty = freezed,
    Object? backUpTotalBalance = freezed,
    Object? currentQty = freezed,
    Object? boxTotal = freezed,
    Object? balanceAllBox = null,
    Object? balanceAllLot = null,
    Object? receivingCard = freezed,
    Object? boxCard = freezed,
    Object? balanceBoxList = null,
    Object? boxCardWillBalance = null,
    Object? boxListShowTotalChange = null,
    Object? listReceivingCardScanned = null,
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
      balanceScanType: null == balanceScanType
          ? _value.balanceScanType
          : balanceScanType // ignore: cast_nullable_to_non_nullable
              as BalanceScanType,
      updateQty: freezed == updateQty
          ? _value.updateQty
          : updateQty // ignore: cast_nullable_to_non_nullable
              as int?,
      backUpTotalBalance: freezed == backUpTotalBalance
          ? _value.backUpTotalBalance
          : backUpTotalBalance // ignore: cast_nullable_to_non_nullable
              as int?,
      currentQty: freezed == currentQty
          ? _value.currentQty
          : currentQty // ignore: cast_nullable_to_non_nullable
              as int?,
      boxTotal: freezed == boxTotal
          ? _value.boxTotal
          : boxTotal // ignore: cast_nullable_to_non_nullable
              as int?,
      balanceAllBox: null == balanceAllBox
          ? _value.balanceAllBox
          : balanceAllBox // ignore: cast_nullable_to_non_nullable
              as bool,
      balanceAllLot: null == balanceAllLot
          ? _value.balanceAllLot
          : balanceAllLot // ignore: cast_nullable_to_non_nullable
              as bool,
      receivingCard: freezed == receivingCard
          ? _value.receivingCard
          : receivingCard // ignore: cast_nullable_to_non_nullable
              as ReceivingCard?,
      boxCard: freezed == boxCard
          ? _value.boxCard
          : boxCard // ignore: cast_nullable_to_non_nullable
              as Barcode?,
      balanceBoxList: null == balanceBoxList
          ? _value.balanceBoxList
          : balanceBoxList // ignore: cast_nullable_to_non_nullable
              as List<BalanceBoxRequestModel>,
      boxCardWillBalance: null == boxCardWillBalance
          ? _value.boxCardWillBalance
          : boxCardWillBalance // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardItem>,
      boxListShowTotalChange: null == boxListShowTotalChange
          ? _value.boxListShowTotalChange
          : boxListShowTotalChange // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardItem>,
      listReceivingCardScanned: null == listReceivingCardScanned
          ? _value.listReceivingCardScanned
          : listReceivingCardScanned // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BalanceRcStateImplCopyWith<$Res>
    implements $BalanceRcStateCopyWith<$Res> {
  factory _$$BalanceRcStateImplCopyWith(_$BalanceRcStateImpl value,
          $Res Function(_$BalanceRcStateImpl) then) =
      __$$BalanceRcStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      BalanceScanType balanceScanType,
      int? updateQty,
      int? backUpTotalBalance,
      int? currentQty,
      int? boxTotal,
      bool balanceAllBox,
      bool balanceAllLot,
      ReceivingCard? receivingCard,
      Barcode? boxCard,
      List<BalanceBoxRequestModel> balanceBoxList,
      List<ReceivingCardItem> boxCardWillBalance,
      List<ReceivingCardItem> boxListShowTotalChange,
      List<ReceivingCard> listReceivingCardScanned});
}

/// @nodoc
class __$$BalanceRcStateImplCopyWithImpl<$Res>
    extends _$BalanceRcStateCopyWithImpl<$Res, _$BalanceRcStateImpl>
    implements _$$BalanceRcStateImplCopyWith<$Res> {
  __$$BalanceRcStateImplCopyWithImpl(
      _$BalanceRcStateImpl _value, $Res Function(_$BalanceRcStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? balanceScanType = null,
    Object? updateQty = freezed,
    Object? backUpTotalBalance = freezed,
    Object? currentQty = freezed,
    Object? boxTotal = freezed,
    Object? balanceAllBox = null,
    Object? balanceAllLot = null,
    Object? receivingCard = freezed,
    Object? boxCard = freezed,
    Object? balanceBoxList = null,
    Object? boxCardWillBalance = null,
    Object? boxListShowTotalChange = null,
    Object? listReceivingCardScanned = null,
  }) {
    return _then(_$BalanceRcStateImpl(
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
      balanceScanType: null == balanceScanType
          ? _value.balanceScanType
          : balanceScanType // ignore: cast_nullable_to_non_nullable
              as BalanceScanType,
      updateQty: freezed == updateQty
          ? _value.updateQty
          : updateQty // ignore: cast_nullable_to_non_nullable
              as int?,
      backUpTotalBalance: freezed == backUpTotalBalance
          ? _value.backUpTotalBalance
          : backUpTotalBalance // ignore: cast_nullable_to_non_nullable
              as int?,
      currentQty: freezed == currentQty
          ? _value.currentQty
          : currentQty // ignore: cast_nullable_to_non_nullable
              as int?,
      boxTotal: freezed == boxTotal
          ? _value.boxTotal
          : boxTotal // ignore: cast_nullable_to_non_nullable
              as int?,
      balanceAllBox: null == balanceAllBox
          ? _value.balanceAllBox
          : balanceAllBox // ignore: cast_nullable_to_non_nullable
              as bool,
      balanceAllLot: null == balanceAllLot
          ? _value.balanceAllLot
          : balanceAllLot // ignore: cast_nullable_to_non_nullable
              as bool,
      receivingCard: freezed == receivingCard
          ? _value.receivingCard
          : receivingCard // ignore: cast_nullable_to_non_nullable
              as ReceivingCard?,
      boxCard: freezed == boxCard
          ? _value.boxCard
          : boxCard // ignore: cast_nullable_to_non_nullable
              as Barcode?,
      balanceBoxList: null == balanceBoxList
          ? _value._balanceBoxList
          : balanceBoxList // ignore: cast_nullable_to_non_nullable
              as List<BalanceBoxRequestModel>,
      boxCardWillBalance: null == boxCardWillBalance
          ? _value._boxCardWillBalance
          : boxCardWillBalance // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardItem>,
      boxListShowTotalChange: null == boxListShowTotalChange
          ? _value._boxListShowTotalChange
          : boxListShowTotalChange // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardItem>,
      listReceivingCardScanned: null == listReceivingCardScanned
          ? _value._listReceivingCardScanned
          : listReceivingCardScanned // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>,
    ));
  }
}

/// @nodoc

class _$BalanceRcStateImpl implements _BalanceRcState {
  _$BalanceRcStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      this.balanceScanType = BalanceScanType.scanRc,
      this.updateQty = null,
      this.backUpTotalBalance = null,
      this.currentQty = null,
      this.boxTotal = null,
      this.balanceAllBox = true,
      this.balanceAllLot = false,
      this.receivingCard = null,
      this.boxCard = null,
      final List<BalanceBoxRequestModel> balanceBoxList = const [],
      final List<ReceivingCardItem> boxCardWillBalance = const [],
      final List<ReceivingCardItem> boxListShowTotalChange = const [],
      final List<ReceivingCard> listReceivingCardScanned = const []})
      : _balanceBoxList = balanceBoxList,
        _boxCardWillBalance = boxCardWillBalance,
        _boxListShowTotalChange = boxListShowTotalChange,
        _listReceivingCardScanned = listReceivingCardScanned;

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
  final BalanceScanType balanceScanType;
  @override
  @JsonKey()
  final int? updateQty;
  @override
  @JsonKey()
  final int? backUpTotalBalance;
  @override
  @JsonKey()
  final int? currentQty;
  @override
  @JsonKey()
  final int? boxTotal;
  @override
  @JsonKey()
  final bool balanceAllBox;
  @override
  @JsonKey()
  final bool balanceAllLot;
  @override
  @JsonKey()
  final ReceivingCard? receivingCard;
  @override
  @JsonKey()
  final Barcode? boxCard;
  final List<BalanceBoxRequestModel> _balanceBoxList;
  @override
  @JsonKey()
  List<BalanceBoxRequestModel> get balanceBoxList {
    if (_balanceBoxList is EqualUnmodifiableListView) return _balanceBoxList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_balanceBoxList);
  }

  final List<ReceivingCardItem> _boxCardWillBalance;
  @override
  @JsonKey()
  List<ReceivingCardItem> get boxCardWillBalance {
    if (_boxCardWillBalance is EqualUnmodifiableListView)
      return _boxCardWillBalance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_boxCardWillBalance);
  }

  final List<ReceivingCardItem> _boxListShowTotalChange;
  @override
  @JsonKey()
  List<ReceivingCardItem> get boxListShowTotalChange {
    if (_boxListShowTotalChange is EqualUnmodifiableListView)
      return _boxListShowTotalChange;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_boxListShowTotalChange);
  }

  final List<ReceivingCard> _listReceivingCardScanned;
  @override
  @JsonKey()
  List<ReceivingCard> get listReceivingCardScanned {
    if (_listReceivingCardScanned is EqualUnmodifiableListView)
      return _listReceivingCardScanned;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listReceivingCardScanned);
  }

  @override
  String toString() {
    return 'BalanceRcState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, balanceScanType: $balanceScanType, updateQty: $updateQty, backUpTotalBalance: $backUpTotalBalance, currentQty: $currentQty, boxTotal: $boxTotal, balanceAllBox: $balanceAllBox, balanceAllLot: $balanceAllLot, receivingCard: $receivingCard, boxCard: $boxCard, balanceBoxList: $balanceBoxList, boxCardWillBalance: $boxCardWillBalance, boxListShowTotalChange: $boxListShowTotalChange, listReceivingCardScanned: $listReceivingCardScanned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceRcStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.balanceScanType, balanceScanType) ||
                other.balanceScanType == balanceScanType) &&
            (identical(other.updateQty, updateQty) ||
                other.updateQty == updateQty) &&
            (identical(other.backUpTotalBalance, backUpTotalBalance) ||
                other.backUpTotalBalance == backUpTotalBalance) &&
            (identical(other.currentQty, currentQty) ||
                other.currentQty == currentQty) &&
            (identical(other.boxTotal, boxTotal) ||
                other.boxTotal == boxTotal) &&
            (identical(other.balanceAllBox, balanceAllBox) ||
                other.balanceAllBox == balanceAllBox) &&
            (identical(other.balanceAllLot, balanceAllLot) ||
                other.balanceAllLot == balanceAllLot) &&
            (identical(other.receivingCard, receivingCard) ||
                other.receivingCard == receivingCard) &&
            (identical(other.boxCard, boxCard) || other.boxCard == boxCard) &&
            const DeepCollectionEquality()
                .equals(other._balanceBoxList, _balanceBoxList) &&
            const DeepCollectionEquality()
                .equals(other._boxCardWillBalance, _boxCardWillBalance) &&
            const DeepCollectionEquality().equals(
                other._boxListShowTotalChange, _boxListShowTotalChange) &&
            const DeepCollectionEquality().equals(
                other._listReceivingCardScanned, _listReceivingCardScanned));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      balanceScanType,
      updateQty,
      backUpTotalBalance,
      currentQty,
      boxTotal,
      balanceAllBox,
      balanceAllLot,
      receivingCard,
      boxCard,
      const DeepCollectionEquality().hash(_balanceBoxList),
      const DeepCollectionEquality().hash(_boxCardWillBalance),
      const DeepCollectionEquality().hash(_boxListShowTotalChange),
      const DeepCollectionEquality().hash(_listReceivingCardScanned));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceRcStateImplCopyWith<_$BalanceRcStateImpl> get copyWith =>
      __$$BalanceRcStateImplCopyWithImpl<_$BalanceRcStateImpl>(
          this, _$identity);
}

abstract class _BalanceRcState implements BalanceRcState {
  factory _BalanceRcState(
          {final PageStatus pageStatus,
          final bool processing,
          final ErrorEntity? errorEntity,
          final BalanceScanType balanceScanType,
          final int? updateQty,
          final int? backUpTotalBalance,
          final int? currentQty,
          final int? boxTotal,
          final bool balanceAllBox,
          final bool balanceAllLot,
          final ReceivingCard? receivingCard,
          final Barcode? boxCard,
          final List<BalanceBoxRequestModel> balanceBoxList,
          final List<ReceivingCardItem> boxCardWillBalance,
          final List<ReceivingCardItem> boxListShowTotalChange,
          final List<ReceivingCard> listReceivingCardScanned}) =
      _$BalanceRcStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  BalanceScanType get balanceScanType;
  @override
  int? get updateQty;
  @override
  int? get backUpTotalBalance;
  @override
  int? get currentQty;
  @override
  int? get boxTotal;
  @override
  bool get balanceAllBox;
  @override
  bool get balanceAllLot;
  @override
  ReceivingCard? get receivingCard;
  @override
  Barcode? get boxCard;
  @override
  List<BalanceBoxRequestModel> get balanceBoxList;
  @override
  List<ReceivingCardItem> get boxCardWillBalance;
  @override
  List<ReceivingCardItem> get boxListShowTotalChange;
  @override
  List<ReceivingCard> get listReceivingCardScanned;
  @override
  @JsonKey(ignore: true)
  _$$BalanceRcStateImplCopyWith<_$BalanceRcStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

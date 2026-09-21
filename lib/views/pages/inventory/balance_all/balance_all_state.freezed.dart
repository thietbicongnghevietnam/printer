// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance_all_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BalanceAllState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  int? get pageNumber => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;
  int? get qtyBalanceUpdate => throw _privateConstructorUsedError;
  int? get qtySystemUpdate => throw _privateConstructorUsedError;
  bool? get isSearched => throw _privateConstructorUsedError;
  PlantCategory? get currentPlant => throw _privateConstructorUsedError;
  CategorySloc? get currentCate => throw _privateConstructorUsedError;
  String? get currentSloc => throw _privateConstructorUsedError;
  ReceivingCard? get receivingCard => throw _privateConstructorUsedError;
  List<PlantCategory> get listPlant => throw _privateConstructorUsedError;
  List<CategorySloc> get listCate => throw _privateConstructorUsedError;
  List<String> get listSloc => throw _privateConstructorUsedError;
  List<BalanceDetail> get listBalanceDetail =>
      throw _privateConstructorUsedError;
  List<CreateBalanceQtyRequestModel> get listUpdateBalance =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BalanceAllStateCopyWith<BalanceAllState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceAllStateCopyWith<$Res> {
  factory $BalanceAllStateCopyWith(
          BalanceAllState value, $Res Function(BalanceAllState) then) =
      _$BalanceAllStateCopyWithImpl<$Res, BalanceAllState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      int? pageNumber,
      int? pageSize,
      int? qtyBalanceUpdate,
      int? qtySystemUpdate,
      bool? isSearched,
      PlantCategory? currentPlant,
      CategorySloc? currentCate,
      String? currentSloc,
      ReceivingCard? receivingCard,
      List<PlantCategory> listPlant,
      List<CategorySloc> listCate,
      List<String> listSloc,
      List<BalanceDetail> listBalanceDetail,
      List<CreateBalanceQtyRequestModel> listUpdateBalance});
}

/// @nodoc
class _$BalanceAllStateCopyWithImpl<$Res, $Val extends BalanceAllState>
    implements $BalanceAllStateCopyWith<$Res> {
  _$BalanceAllStateCopyWithImpl(this._value, this._then);

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
    Object? pageNumber = freezed,
    Object? pageSize = freezed,
    Object? qtyBalanceUpdate = freezed,
    Object? qtySystemUpdate = freezed,
    Object? isSearched = freezed,
    Object? currentPlant = freezed,
    Object? currentCate = freezed,
    Object? currentSloc = freezed,
    Object? receivingCard = freezed,
    Object? listPlant = null,
    Object? listCate = null,
    Object? listSloc = null,
    Object? listBalanceDetail = null,
    Object? listUpdateBalance = null,
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
      pageNumber: freezed == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
      qtyBalanceUpdate: freezed == qtyBalanceUpdate
          ? _value.qtyBalanceUpdate
          : qtyBalanceUpdate // ignore: cast_nullable_to_non_nullable
              as int?,
      qtySystemUpdate: freezed == qtySystemUpdate
          ? _value.qtySystemUpdate
          : qtySystemUpdate // ignore: cast_nullable_to_non_nullable
              as int?,
      isSearched: freezed == isSearched
          ? _value.isSearched
          : isSearched // ignore: cast_nullable_to_non_nullable
              as bool?,
      currentPlant: freezed == currentPlant
          ? _value.currentPlant
          : currentPlant // ignore: cast_nullable_to_non_nullable
              as PlantCategory?,
      currentCate: freezed == currentCate
          ? _value.currentCate
          : currentCate // ignore: cast_nullable_to_non_nullable
              as CategorySloc?,
      currentSloc: freezed == currentSloc
          ? _value.currentSloc
          : currentSloc // ignore: cast_nullable_to_non_nullable
              as String?,
      receivingCard: freezed == receivingCard
          ? _value.receivingCard
          : receivingCard // ignore: cast_nullable_to_non_nullable
              as ReceivingCard?,
      listPlant: null == listPlant
          ? _value.listPlant
          : listPlant // ignore: cast_nullable_to_non_nullable
              as List<PlantCategory>,
      listCate: null == listCate
          ? _value.listCate
          : listCate // ignore: cast_nullable_to_non_nullable
              as List<CategorySloc>,
      listSloc: null == listSloc
          ? _value.listSloc
          : listSloc // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listBalanceDetail: null == listBalanceDetail
          ? _value.listBalanceDetail
          : listBalanceDetail // ignore: cast_nullable_to_non_nullable
              as List<BalanceDetail>,
      listUpdateBalance: null == listUpdateBalance
          ? _value.listUpdateBalance
          : listUpdateBalance // ignore: cast_nullable_to_non_nullable
              as List<CreateBalanceQtyRequestModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BalanceAllStateImplCopyWith<$Res>
    implements $BalanceAllStateCopyWith<$Res> {
  factory _$$BalanceAllStateImplCopyWith(_$BalanceAllStateImpl value,
          $Res Function(_$BalanceAllStateImpl) then) =
      __$$BalanceAllStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      int? pageNumber,
      int? pageSize,
      int? qtyBalanceUpdate,
      int? qtySystemUpdate,
      bool? isSearched,
      PlantCategory? currentPlant,
      CategorySloc? currentCate,
      String? currentSloc,
      ReceivingCard? receivingCard,
      List<PlantCategory> listPlant,
      List<CategorySloc> listCate,
      List<String> listSloc,
      List<BalanceDetail> listBalanceDetail,
      List<CreateBalanceQtyRequestModel> listUpdateBalance});
}

/// @nodoc
class __$$BalanceAllStateImplCopyWithImpl<$Res>
    extends _$BalanceAllStateCopyWithImpl<$Res, _$BalanceAllStateImpl>
    implements _$$BalanceAllStateImplCopyWith<$Res> {
  __$$BalanceAllStateImplCopyWithImpl(
      _$BalanceAllStateImpl _value, $Res Function(_$BalanceAllStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? pageNumber = freezed,
    Object? pageSize = freezed,
    Object? qtyBalanceUpdate = freezed,
    Object? qtySystemUpdate = freezed,
    Object? isSearched = freezed,
    Object? currentPlant = freezed,
    Object? currentCate = freezed,
    Object? currentSloc = freezed,
    Object? receivingCard = freezed,
    Object? listPlant = null,
    Object? listCate = null,
    Object? listSloc = null,
    Object? listBalanceDetail = null,
    Object? listUpdateBalance = null,
  }) {
    return _then(_$BalanceAllStateImpl(
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
      pageNumber: freezed == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
      qtyBalanceUpdate: freezed == qtyBalanceUpdate
          ? _value.qtyBalanceUpdate
          : qtyBalanceUpdate // ignore: cast_nullable_to_non_nullable
              as int?,
      qtySystemUpdate: freezed == qtySystemUpdate
          ? _value.qtySystemUpdate
          : qtySystemUpdate // ignore: cast_nullable_to_non_nullable
              as int?,
      isSearched: freezed == isSearched
          ? _value.isSearched
          : isSearched // ignore: cast_nullable_to_non_nullable
              as bool?,
      currentPlant: freezed == currentPlant
          ? _value.currentPlant
          : currentPlant // ignore: cast_nullable_to_non_nullable
              as PlantCategory?,
      currentCate: freezed == currentCate
          ? _value.currentCate
          : currentCate // ignore: cast_nullable_to_non_nullable
              as CategorySloc?,
      currentSloc: freezed == currentSloc
          ? _value.currentSloc
          : currentSloc // ignore: cast_nullable_to_non_nullable
              as String?,
      receivingCard: freezed == receivingCard
          ? _value.receivingCard
          : receivingCard // ignore: cast_nullable_to_non_nullable
              as ReceivingCard?,
      listPlant: null == listPlant
          ? _value._listPlant
          : listPlant // ignore: cast_nullable_to_non_nullable
              as List<PlantCategory>,
      listCate: null == listCate
          ? _value._listCate
          : listCate // ignore: cast_nullable_to_non_nullable
              as List<CategorySloc>,
      listSloc: null == listSloc
          ? _value._listSloc
          : listSloc // ignore: cast_nullable_to_non_nullable
              as List<String>,
      listBalanceDetail: null == listBalanceDetail
          ? _value._listBalanceDetail
          : listBalanceDetail // ignore: cast_nullable_to_non_nullable
              as List<BalanceDetail>,
      listUpdateBalance: null == listUpdateBalance
          ? _value._listUpdateBalance
          : listUpdateBalance // ignore: cast_nullable_to_non_nullable
              as List<CreateBalanceQtyRequestModel>,
    ));
  }
}

/// @nodoc

class _$BalanceAllStateImpl implements _BalanceAllState {
  _$BalanceAllStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.errorEntity = null,
      this.pageNumber = null,
      this.pageSize = null,
      this.qtyBalanceUpdate = null,
      this.qtySystemUpdate = null,
      this.isSearched = false,
      this.currentPlant = null,
      this.currentCate = null,
      this.currentSloc = null,
      this.receivingCard = null,
      final List<PlantCategory> listPlant = const [],
      final List<CategorySloc> listCate = const [],
      final List<String> listSloc = const [],
      final List<BalanceDetail> listBalanceDetail = const [],
      final List<CreateBalanceQtyRequestModel> listUpdateBalance = const []})
      : _listPlant = listPlant,
        _listCate = listCate,
        _listSloc = listSloc,
        _listBalanceDetail = listBalanceDetail,
        _listUpdateBalance = listUpdateBalance;

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
  final int? pageNumber;
  @override
  @JsonKey()
  final int? pageSize;
  @override
  @JsonKey()
  final int? qtyBalanceUpdate;
  @override
  @JsonKey()
  final int? qtySystemUpdate;
  @override
  @JsonKey()
  final bool? isSearched;
  @override
  @JsonKey()
  final PlantCategory? currentPlant;
  @override
  @JsonKey()
  final CategorySloc? currentCate;
  @override
  @JsonKey()
  final String? currentSloc;
  @override
  @JsonKey()
  final ReceivingCard? receivingCard;
  final List<PlantCategory> _listPlant;
  @override
  @JsonKey()
  List<PlantCategory> get listPlant {
    if (_listPlant is EqualUnmodifiableListView) return _listPlant;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listPlant);
  }

  final List<CategorySloc> _listCate;
  @override
  @JsonKey()
  List<CategorySloc> get listCate {
    if (_listCate is EqualUnmodifiableListView) return _listCate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listCate);
  }

  final List<String> _listSloc;
  @override
  @JsonKey()
  List<String> get listSloc {
    if (_listSloc is EqualUnmodifiableListView) return _listSloc;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listSloc);
  }

  final List<BalanceDetail> _listBalanceDetail;
  @override
  @JsonKey()
  List<BalanceDetail> get listBalanceDetail {
    if (_listBalanceDetail is EqualUnmodifiableListView)
      return _listBalanceDetail;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listBalanceDetail);
  }

  final List<CreateBalanceQtyRequestModel> _listUpdateBalance;
  @override
  @JsonKey()
  List<CreateBalanceQtyRequestModel> get listUpdateBalance {
    if (_listUpdateBalance is EqualUnmodifiableListView)
      return _listUpdateBalance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listUpdateBalance);
  }

  @override
  String toString() {
    return 'BalanceAllState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, pageNumber: $pageNumber, pageSize: $pageSize, qtyBalanceUpdate: $qtyBalanceUpdate, qtySystemUpdate: $qtySystemUpdate, isSearched: $isSearched, currentPlant: $currentPlant, currentCate: $currentCate, currentSloc: $currentSloc, receivingCard: $receivingCard, listPlant: $listPlant, listCate: $listCate, listSloc: $listSloc, listBalanceDetail: $listBalanceDetail, listUpdateBalance: $listUpdateBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceAllStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.qtyBalanceUpdate, qtyBalanceUpdate) ||
                other.qtyBalanceUpdate == qtyBalanceUpdate) &&
            (identical(other.qtySystemUpdate, qtySystemUpdate) ||
                other.qtySystemUpdate == qtySystemUpdate) &&
            (identical(other.isSearched, isSearched) ||
                other.isSearched == isSearched) &&
            (identical(other.currentPlant, currentPlant) ||
                other.currentPlant == currentPlant) &&
            (identical(other.currentCate, currentCate) ||
                other.currentCate == currentCate) &&
            (identical(other.currentSloc, currentSloc) ||
                other.currentSloc == currentSloc) &&
            (identical(other.receivingCard, receivingCard) ||
                other.receivingCard == receivingCard) &&
            const DeepCollectionEquality()
                .equals(other._listPlant, _listPlant) &&
            const DeepCollectionEquality().equals(other._listCate, _listCate) &&
            const DeepCollectionEquality().equals(other._listSloc, _listSloc) &&
            const DeepCollectionEquality()
                .equals(other._listBalanceDetail, _listBalanceDetail) &&
            const DeepCollectionEquality()
                .equals(other._listUpdateBalance, _listUpdateBalance));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      pageNumber,
      pageSize,
      qtyBalanceUpdate,
      qtySystemUpdate,
      isSearched,
      currentPlant,
      currentCate,
      currentSloc,
      receivingCard,
      const DeepCollectionEquality().hash(_listPlant),
      const DeepCollectionEquality().hash(_listCate),
      const DeepCollectionEquality().hash(_listSloc),
      const DeepCollectionEquality().hash(_listBalanceDetail),
      const DeepCollectionEquality().hash(_listUpdateBalance));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceAllStateImplCopyWith<_$BalanceAllStateImpl> get copyWith =>
      __$$BalanceAllStateImplCopyWithImpl<_$BalanceAllStateImpl>(
          this, _$identity);
}

abstract class _BalanceAllState implements BalanceAllState {
  factory _BalanceAllState(
          {final PageStatus pageStatus,
          final bool processing,
          final ErrorEntity? errorEntity,
          final int? pageNumber,
          final int? pageSize,
          final int? qtyBalanceUpdate,
          final int? qtySystemUpdate,
          final bool? isSearched,
          final PlantCategory? currentPlant,
          final CategorySloc? currentCate,
          final String? currentSloc,
          final ReceivingCard? receivingCard,
          final List<PlantCategory> listPlant,
          final List<CategorySloc> listCate,
          final List<String> listSloc,
          final List<BalanceDetail> listBalanceDetail,
          final List<CreateBalanceQtyRequestModel> listUpdateBalance}) =
      _$BalanceAllStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  int? get pageNumber;
  @override
  int? get pageSize;
  @override
  int? get qtyBalanceUpdate;
  @override
  int? get qtySystemUpdate;
  @override
  bool? get isSearched;
  @override
  PlantCategory? get currentPlant;
  @override
  CategorySloc? get currentCate;
  @override
  String? get currentSloc;
  @override
  ReceivingCard? get receivingCard;
  @override
  List<PlantCategory> get listPlant;
  @override
  List<CategorySloc> get listCate;
  @override
  List<String> get listSloc;
  @override
  List<BalanceDetail> get listBalanceDetail;
  @override
  List<CreateBalanceQtyRequestModel> get listUpdateBalance;
  @override
  @JsonKey(ignore: true)
  _$$BalanceAllStateImplCopyWith<_$BalanceAllStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_borrow_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StorageBorrowItemState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  String get goods => throw _privateConstructorUsedError;
  String get remark => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  bool get hasStored => throw _privateConstructorUsedError;
  List<StoreGoodsRequestModel> get itemList =>
      throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StorageBorrowItemStateCopyWith<StorageBorrowItemState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageBorrowItemStateCopyWith<$Res> {
  factory $StorageBorrowItemStateCopyWith(StorageBorrowItemState value,
          $Res Function(StorageBorrowItemState) then) =
      _$StorageBorrowItemStateCopyWithImpl<$Res, StorageBorrowItemState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      String goods,
      String remark,
      String location,
      bool hasStored,
      List<StoreGoodsRequestModel> itemList,
      ErrorEntity? errorEntity});
}

/// @nodoc
class _$StorageBorrowItemStateCopyWithImpl<$Res,
        $Val extends StorageBorrowItemState>
    implements $StorageBorrowItemStateCopyWith<$Res> {
  _$StorageBorrowItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? goods = null,
    Object? remark = null,
    Object? location = null,
    Object? hasStored = null,
    Object? itemList = null,
    Object? errorEntity = freezed,
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
      goods: null == goods
          ? _value.goods
          : goods // ignore: cast_nullable_to_non_nullable
              as String,
      remark: null == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      hasStored: null == hasStored
          ? _value.hasStored
          : hasStored // ignore: cast_nullable_to_non_nullable
              as bool,
      itemList: null == itemList
          ? _value.itemList
          : itemList // ignore: cast_nullable_to_non_nullable
              as List<StoreGoodsRequestModel>,
      errorEntity: freezed == errorEntity
          ? _value.errorEntity
          : errorEntity // ignore: cast_nullable_to_non_nullable
              as ErrorEntity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StorageBorrowItemStateImplCopyWith<$Res>
    implements $StorageBorrowItemStateCopyWith<$Res> {
  factory _$$StorageBorrowItemStateImplCopyWith(
          _$StorageBorrowItemStateImpl value,
          $Res Function(_$StorageBorrowItemStateImpl) then) =
      __$$StorageBorrowItemStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      String goods,
      String remark,
      String location,
      bool hasStored,
      List<StoreGoodsRequestModel> itemList,
      ErrorEntity? errorEntity});
}

/// @nodoc
class __$$StorageBorrowItemStateImplCopyWithImpl<$Res>
    extends _$StorageBorrowItemStateCopyWithImpl<$Res,
        _$StorageBorrowItemStateImpl>
    implements _$$StorageBorrowItemStateImplCopyWith<$Res> {
  __$$StorageBorrowItemStateImplCopyWithImpl(
      _$StorageBorrowItemStateImpl _value,
      $Res Function(_$StorageBorrowItemStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? goods = null,
    Object? remark = null,
    Object? location = null,
    Object? hasStored = null,
    Object? itemList = null,
    Object? errorEntity = freezed,
  }) {
    return _then(_$StorageBorrowItemStateImpl(
      pageStatus: null == pageStatus
          ? _value.pageStatus
          : pageStatus // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as bool,
      goods: null == goods
          ? _value.goods
          : goods // ignore: cast_nullable_to_non_nullable
              as String,
      remark: null == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      hasStored: null == hasStored
          ? _value.hasStored
          : hasStored // ignore: cast_nullable_to_non_nullable
              as bool,
      itemList: null == itemList
          ? _value._itemList
          : itemList // ignore: cast_nullable_to_non_nullable
              as List<StoreGoodsRequestModel>,
      errorEntity: freezed == errorEntity
          ? _value.errorEntity
          : errorEntity // ignore: cast_nullable_to_non_nullable
              as ErrorEntity?,
    ));
  }
}

/// @nodoc

class _$StorageBorrowItemStateImpl implements _StorageBorrowItemState {
  _$StorageBorrowItemStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.goods = '',
      this.remark = '',
      this.location = '',
      this.hasStored = false,
      final List<StoreGoodsRequestModel> itemList = const [],
      this.errorEntity = null})
      : _itemList = itemList;

  @override
  @JsonKey()
  final PageStatus pageStatus;
  @override
  @JsonKey()
  final bool processing;
  @override
  @JsonKey()
  final String goods;
  @override
  @JsonKey()
  final String remark;
  @override
  @JsonKey()
  final String location;
  @override
  @JsonKey()
  final bool hasStored;
  final List<StoreGoodsRequestModel> _itemList;
  @override
  @JsonKey()
  List<StoreGoodsRequestModel> get itemList {
    if (_itemList is EqualUnmodifiableListView) return _itemList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemList);
  }

  @override
  @JsonKey()
  final ErrorEntity? errorEntity;

  @override
  String toString() {
    return 'StorageBorrowItemState(pageStatus: $pageStatus, processing: $processing, goods: $goods, remark: $remark, location: $location, hasStored: $hasStored, itemList: $itemList, errorEntity: $errorEntity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageBorrowItemStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.goods, goods) || other.goods == goods) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.hasStored, hasStored) ||
                other.hasStored == hasStored) &&
            const DeepCollectionEquality().equals(other._itemList, _itemList) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      goods,
      remark,
      location,
      hasStored,
      const DeepCollectionEquality().hash(_itemList),
      errorEntity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageBorrowItemStateImplCopyWith<_$StorageBorrowItemStateImpl>
      get copyWith => __$$StorageBorrowItemStateImplCopyWithImpl<
          _$StorageBorrowItemStateImpl>(this, _$identity);
}

abstract class _StorageBorrowItemState implements StorageBorrowItemState {
  factory _StorageBorrowItemState(
      {final PageStatus pageStatus,
      final bool processing,
      final String goods,
      final String remark,
      final String location,
      final bool hasStored,
      final List<StoreGoodsRequestModel> itemList,
      final ErrorEntity? errorEntity}) = _$StorageBorrowItemStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  String get goods;
  @override
  String get remark;
  @override
  String get location;
  @override
  bool get hasStored;
  @override
  List<StoreGoodsRequestModel> get itemList;
  @override
  ErrorEntity? get errorEntity;
  @override
  @JsonKey(ignore: true)
  _$$StorageBorrowItemStateImplCopyWith<_$StorageBorrowItemStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

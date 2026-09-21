// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_borrow_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ListBorrowItemState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  bool get isSearched => throw _privateConstructorUsedError;
  int get pageNumber => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  String get searchName => throw _privateConstructorUsedError;
  List<BorrowGoodsResponseModel> get borrowGoodsList =>
      throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ListBorrowItemStateCopyWith<ListBorrowItemState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListBorrowItemStateCopyWith<$Res> {
  factory $ListBorrowItemStateCopyWith(
          ListBorrowItemState value, $Res Function(ListBorrowItemState) then) =
      _$ListBorrowItemStateCopyWithImpl<$Res, ListBorrowItemState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      bool isSearched,
      int pageNumber,
      int pageSize,
      String searchName,
      List<BorrowGoodsResponseModel> borrowGoodsList,
      ErrorEntity? errorEntity});
}

/// @nodoc
class _$ListBorrowItemStateCopyWithImpl<$Res, $Val extends ListBorrowItemState>
    implements $ListBorrowItemStateCopyWith<$Res> {
  _$ListBorrowItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? isSearched = null,
    Object? pageNumber = null,
    Object? pageSize = null,
    Object? searchName = null,
    Object? borrowGoodsList = null,
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
      isSearched: null == isSearched
          ? _value.isSearched
          : isSearched // ignore: cast_nullable_to_non_nullable
              as bool,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      searchName: null == searchName
          ? _value.searchName
          : searchName // ignore: cast_nullable_to_non_nullable
              as String,
      borrowGoodsList: null == borrowGoodsList
          ? _value.borrowGoodsList
          : borrowGoodsList // ignore: cast_nullable_to_non_nullable
              as List<BorrowGoodsResponseModel>,
      errorEntity: freezed == errorEntity
          ? _value.errorEntity
          : errorEntity // ignore: cast_nullable_to_non_nullable
              as ErrorEntity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListBorrowItemStateImplCopyWith<$Res>
    implements $ListBorrowItemStateCopyWith<$Res> {
  factory _$$ListBorrowItemStateImplCopyWith(_$ListBorrowItemStateImpl value,
          $Res Function(_$ListBorrowItemStateImpl) then) =
      __$$ListBorrowItemStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      bool isSearched,
      int pageNumber,
      int pageSize,
      String searchName,
      List<BorrowGoodsResponseModel> borrowGoodsList,
      ErrorEntity? errorEntity});
}

/// @nodoc
class __$$ListBorrowItemStateImplCopyWithImpl<$Res>
    extends _$ListBorrowItemStateCopyWithImpl<$Res, _$ListBorrowItemStateImpl>
    implements _$$ListBorrowItemStateImplCopyWith<$Res> {
  __$$ListBorrowItemStateImplCopyWithImpl(_$ListBorrowItemStateImpl _value,
      $Res Function(_$ListBorrowItemStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? isSearched = null,
    Object? pageNumber = null,
    Object? pageSize = null,
    Object? searchName = null,
    Object? borrowGoodsList = null,
    Object? errorEntity = freezed,
  }) {
    return _then(_$ListBorrowItemStateImpl(
      pageStatus: null == pageStatus
          ? _value.pageStatus
          : pageStatus // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as bool,
      isSearched: null == isSearched
          ? _value.isSearched
          : isSearched // ignore: cast_nullable_to_non_nullable
              as bool,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      searchName: null == searchName
          ? _value.searchName
          : searchName // ignore: cast_nullable_to_non_nullable
              as String,
      borrowGoodsList: null == borrowGoodsList
          ? _value._borrowGoodsList
          : borrowGoodsList // ignore: cast_nullable_to_non_nullable
              as List<BorrowGoodsResponseModel>,
      errorEntity: freezed == errorEntity
          ? _value.errorEntity
          : errorEntity // ignore: cast_nullable_to_non_nullable
              as ErrorEntity?,
    ));
  }
}

/// @nodoc

class _$ListBorrowItemStateImpl implements _ListBorrowItemState {
  _$ListBorrowItemStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.isSearched = false,
      this.pageNumber = 1,
      this.pageSize = 10,
      this.searchName = '',
      final List<BorrowGoodsResponseModel> borrowGoodsList = const [],
      this.errorEntity = null})
      : _borrowGoodsList = borrowGoodsList;

  @override
  @JsonKey()
  final PageStatus pageStatus;
  @override
  @JsonKey()
  final bool processing;
  @override
  @JsonKey()
  final bool isSearched;
  @override
  @JsonKey()
  final int pageNumber;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final String searchName;
  final List<BorrowGoodsResponseModel> _borrowGoodsList;
  @override
  @JsonKey()
  List<BorrowGoodsResponseModel> get borrowGoodsList {
    if (_borrowGoodsList is EqualUnmodifiableListView) return _borrowGoodsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_borrowGoodsList);
  }

  @override
  @JsonKey()
  final ErrorEntity? errorEntity;

  @override
  String toString() {
    return 'ListBorrowItemState(pageStatus: $pageStatus, processing: $processing, isSearched: $isSearched, pageNumber: $pageNumber, pageSize: $pageSize, searchName: $searchName, borrowGoodsList: $borrowGoodsList, errorEntity: $errorEntity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListBorrowItemStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.isSearched, isSearched) ||
                other.isSearched == isSearched) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.searchName, searchName) ||
                other.searchName == searchName) &&
            const DeepCollectionEquality()
                .equals(other._borrowGoodsList, _borrowGoodsList) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      isSearched,
      pageNumber,
      pageSize,
      searchName,
      const DeepCollectionEquality().hash(_borrowGoodsList),
      errorEntity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListBorrowItemStateImplCopyWith<_$ListBorrowItemStateImpl> get copyWith =>
      __$$ListBorrowItemStateImplCopyWithImpl<_$ListBorrowItemStateImpl>(
          this, _$identity);
}

abstract class _ListBorrowItemState implements ListBorrowItemState {
  factory _ListBorrowItemState(
      {final PageStatus pageStatus,
      final bool processing,
      final bool isSearched,
      final int pageNumber,
      final int pageSize,
      final String searchName,
      final List<BorrowGoodsResponseModel> borrowGoodsList,
      final ErrorEntity? errorEntity}) = _$ListBorrowItemStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  bool get isSearched;
  @override
  int get pageNumber;
  @override
  int get pageSize;
  @override
  String get searchName;
  @override
  List<BorrowGoodsResponseModel> get borrowGoodsList;
  @override
  ErrorEntity? get errorEntity;
  @override
  @JsonKey(ignore: true)
  _$$ListBorrowItemStateImplCopyWith<_$ListBorrowItemStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

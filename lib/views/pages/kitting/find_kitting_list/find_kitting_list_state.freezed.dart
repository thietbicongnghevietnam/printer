// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'find_kitting_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FindKittingListState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  KittingList? get kittingList => throw _privateConstructorUsedError;
  List<String> get codeTrolleys => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FindKittingListStateCopyWith<FindKittingListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FindKittingListStateCopyWith<$Res> {
  factory $FindKittingListStateCopyWith(FindKittingListState value,
          $Res Function(FindKittingListState) then) =
      _$FindKittingListStateCopyWithImpl<$Res, FindKittingListState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      KittingList? kittingList,
      List<String> codeTrolleys});
}

/// @nodoc
class _$FindKittingListStateCopyWithImpl<$Res,
        $Val extends FindKittingListState>
    implements $FindKittingListStateCopyWith<$Res> {
  _$FindKittingListStateCopyWithImpl(this._value, this._then);

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
    Object? kittingList = freezed,
    Object? codeTrolleys = null,
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
      kittingList: freezed == kittingList
          ? _value.kittingList
          : kittingList // ignore: cast_nullable_to_non_nullable
              as KittingList?,
      codeTrolleys: null == codeTrolleys
          ? _value.codeTrolleys
          : codeTrolleys // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FindKittingListStateImplCopyWith<$Res>
    implements $FindKittingListStateCopyWith<$Res> {
  factory _$$FindKittingListStateImplCopyWith(_$FindKittingListStateImpl value,
          $Res Function(_$FindKittingListStateImpl) then) =
      __$$FindKittingListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      KittingList? kittingList,
      List<String> codeTrolleys});
}

/// @nodoc
class __$$FindKittingListStateImplCopyWithImpl<$Res>
    extends _$FindKittingListStateCopyWithImpl<$Res, _$FindKittingListStateImpl>
    implements _$$FindKittingListStateImplCopyWith<$Res> {
  __$$FindKittingListStateImplCopyWithImpl(_$FindKittingListStateImpl _value,
      $Res Function(_$FindKittingListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? kittingList = freezed,
    Object? codeTrolleys = null,
  }) {
    return _then(_$FindKittingListStateImpl(
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
      kittingList: freezed == kittingList
          ? _value.kittingList
          : kittingList // ignore: cast_nullable_to_non_nullable
              as KittingList?,
      codeTrolleys: null == codeTrolleys
          ? _value._codeTrolleys
          : codeTrolleys // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$FindKittingListStateImpl implements _FindKittingListState {
  _$FindKittingListStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      this.kittingList = null,
      final List<String> codeTrolleys = const []})
      : _codeTrolleys = codeTrolleys;

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
  final KittingList? kittingList;
  final List<String> _codeTrolleys;
  @override
  @JsonKey()
  List<String> get codeTrolleys {
    if (_codeTrolleys is EqualUnmodifiableListView) return _codeTrolleys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_codeTrolleys);
  }

  @override
  String toString() {
    return 'FindKittingListState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, kittingList: $kittingList, codeTrolleys: $codeTrolleys)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FindKittingListStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.kittingList, kittingList) ||
                other.kittingList == kittingList) &&
            const DeepCollectionEquality()
                .equals(other._codeTrolleys, _codeTrolleys));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      kittingList,
      const DeepCollectionEquality().hash(_codeTrolleys));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FindKittingListStateImplCopyWith<_$FindKittingListStateImpl>
      get copyWith =>
          __$$FindKittingListStateImplCopyWithImpl<_$FindKittingListStateImpl>(
              this, _$identity);
}

abstract class _FindKittingListState implements FindKittingListState {
  factory _FindKittingListState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final KittingList? kittingList,
      final List<String> codeTrolleys}) = _$FindKittingListStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  KittingList? get kittingList;
  @override
  List<String> get codeTrolleys;
  @override
  @JsonKey(ignore: true)
  _$$FindKittingListStateImplCopyWith<_$FindKittingListStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

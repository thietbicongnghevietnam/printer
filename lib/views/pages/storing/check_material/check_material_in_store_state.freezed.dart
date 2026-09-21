// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_material_in_store_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CheckMaterialInStoreState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;
  ReceivingCard? get currentReCard => throw _privateConstructorUsedError;
  List<MaterialLocationResponseModel> get materialList =>
      throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckMaterialInStoreStateCopyWith<CheckMaterialInStoreState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckMaterialInStoreStateCopyWith<$Res> {
  factory $CheckMaterialInStoreStateCopyWith(CheckMaterialInStoreState value,
          $Res Function(CheckMaterialInStoreState) then) =
      _$CheckMaterialInStoreStateCopyWithImpl<$Res, CheckMaterialInStoreState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      String position,
      ReceivingCard? currentReCard,
      List<MaterialLocationResponseModel> materialList,
      ErrorEntity? errorEntity});
}

/// @nodoc
class _$CheckMaterialInStoreStateCopyWithImpl<$Res,
        $Val extends CheckMaterialInStoreState>
    implements $CheckMaterialInStoreStateCopyWith<$Res> {
  _$CheckMaterialInStoreStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? position = null,
    Object? currentReCard = freezed,
    Object? materialList = null,
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
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      currentReCard: freezed == currentReCard
          ? _value.currentReCard
          : currentReCard // ignore: cast_nullable_to_non_nullable
              as ReceivingCard?,
      materialList: null == materialList
          ? _value.materialList
          : materialList // ignore: cast_nullable_to_non_nullable
              as List<MaterialLocationResponseModel>,
      errorEntity: freezed == errorEntity
          ? _value.errorEntity
          : errorEntity // ignore: cast_nullable_to_non_nullable
              as ErrorEntity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckMaterialInStoreStateImplCopyWith<$Res>
    implements $CheckMaterialInStoreStateCopyWith<$Res> {
  factory _$$CheckMaterialInStoreStateImplCopyWith(
          _$CheckMaterialInStoreStateImpl value,
          $Res Function(_$CheckMaterialInStoreStateImpl) then) =
      __$$CheckMaterialInStoreStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      String position,
      ReceivingCard? currentReCard,
      List<MaterialLocationResponseModel> materialList,
      ErrorEntity? errorEntity});
}

/// @nodoc
class __$$CheckMaterialInStoreStateImplCopyWithImpl<$Res>
    extends _$CheckMaterialInStoreStateCopyWithImpl<$Res,
        _$CheckMaterialInStoreStateImpl>
    implements _$$CheckMaterialInStoreStateImplCopyWith<$Res> {
  __$$CheckMaterialInStoreStateImplCopyWithImpl(
      _$CheckMaterialInStoreStateImpl _value,
      $Res Function(_$CheckMaterialInStoreStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? position = null,
    Object? currentReCard = freezed,
    Object? materialList = null,
    Object? errorEntity = freezed,
  }) {
    return _then(_$CheckMaterialInStoreStateImpl(
      pageStatus: null == pageStatus
          ? _value.pageStatus
          : pageStatus // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as bool,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      currentReCard: freezed == currentReCard
          ? _value.currentReCard
          : currentReCard // ignore: cast_nullable_to_non_nullable
              as ReceivingCard?,
      materialList: null == materialList
          ? _value._materialList
          : materialList // ignore: cast_nullable_to_non_nullable
              as List<MaterialLocationResponseModel>,
      errorEntity: freezed == errorEntity
          ? _value.errorEntity
          : errorEntity // ignore: cast_nullable_to_non_nullable
              as ErrorEntity?,
    ));
  }
}

/// @nodoc

class _$CheckMaterialInStoreStateImpl implements _CheckMaterialInStoreState {
  _$CheckMaterialInStoreStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.position = '',
      this.currentReCard = null,
      final List<MaterialLocationResponseModel> materialList = const [],
      this.errorEntity = null})
      : _materialList = materialList;

  @override
  @JsonKey()
  final PageStatus pageStatus;
  @override
  @JsonKey()
  final bool processing;
  @override
  @JsonKey()
  final String position;
  @override
  @JsonKey()
  final ReceivingCard? currentReCard;
  final List<MaterialLocationResponseModel> _materialList;
  @override
  @JsonKey()
  List<MaterialLocationResponseModel> get materialList {
    if (_materialList is EqualUnmodifiableListView) return _materialList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_materialList);
  }

  @override
  @JsonKey()
  final ErrorEntity? errorEntity;

  @override
  String toString() {
    return 'CheckMaterialInStoreState(pageStatus: $pageStatus, processing: $processing, position: $position, currentReCard: $currentReCard, materialList: $materialList, errorEntity: $errorEntity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckMaterialInStoreStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.currentReCard, currentReCard) ||
                other.currentReCard == currentReCard) &&
            const DeepCollectionEquality()
                .equals(other._materialList, _materialList) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      position,
      currentReCard,
      const DeepCollectionEquality().hash(_materialList),
      errorEntity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckMaterialInStoreStateImplCopyWith<_$CheckMaterialInStoreStateImpl>
      get copyWith => __$$CheckMaterialInStoreStateImplCopyWithImpl<
          _$CheckMaterialInStoreStateImpl>(this, _$identity);
}

abstract class _CheckMaterialInStoreState implements CheckMaterialInStoreState {
  factory _CheckMaterialInStoreState(
      {final PageStatus pageStatus,
      final bool processing,
      final String position,
      final ReceivingCard? currentReCard,
      final List<MaterialLocationResponseModel> materialList,
      final ErrorEntity? errorEntity}) = _$CheckMaterialInStoreStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  String get position;
  @override
  ReceivingCard? get currentReCard;
  @override
  List<MaterialLocationResponseModel> get materialList;
  @override
  ErrorEntity? get errorEntity;
  @override
  @JsonKey(ignore: true)
  _$$CheckMaterialInStoreStateImplCopyWith<_$CheckMaterialInStoreStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

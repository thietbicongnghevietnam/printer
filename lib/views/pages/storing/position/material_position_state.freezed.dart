// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'material_position_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MaterialPositionState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  List<MaterialLocationResponseModel> get materialList =>
      throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MaterialPositionStateCopyWith<MaterialPositionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialPositionStateCopyWith<$Res> {
  factory $MaterialPositionStateCopyWith(MaterialPositionState value,
          $Res Function(MaterialPositionState) then) =
      _$MaterialPositionStateCopyWithImpl<$Res, MaterialPositionState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      List<MaterialLocationResponseModel> materialList,
      ErrorEntity? errorEntity});
}

/// @nodoc
class _$MaterialPositionStateCopyWithImpl<$Res,
        $Val extends MaterialPositionState>
    implements $MaterialPositionStateCopyWith<$Res> {
  _$MaterialPositionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
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
abstract class _$$MaterialPositionStateImplCopyWith<$Res>
    implements $MaterialPositionStateCopyWith<$Res> {
  factory _$$MaterialPositionStateImplCopyWith(
          _$MaterialPositionStateImpl value,
          $Res Function(_$MaterialPositionStateImpl) then) =
      __$$MaterialPositionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      List<MaterialLocationResponseModel> materialList,
      ErrorEntity? errorEntity});
}

/// @nodoc
class __$$MaterialPositionStateImplCopyWithImpl<$Res>
    extends _$MaterialPositionStateCopyWithImpl<$Res,
        _$MaterialPositionStateImpl>
    implements _$$MaterialPositionStateImplCopyWith<$Res> {
  __$$MaterialPositionStateImplCopyWithImpl(_$MaterialPositionStateImpl _value,
      $Res Function(_$MaterialPositionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? materialList = null,
    Object? errorEntity = freezed,
  }) {
    return _then(_$MaterialPositionStateImpl(
      pageStatus: null == pageStatus
          ? _value.pageStatus
          : pageStatus // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as bool,
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

class _$MaterialPositionStateImpl implements _MaterialPositionState {
  _$MaterialPositionStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      final List<MaterialLocationResponseModel> materialList = const [],
      this.errorEntity = null})
      : _materialList = materialList;

  @override
  @JsonKey()
  final PageStatus pageStatus;
  @override
  @JsonKey()
  final bool processing;
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
    return 'MaterialPositionState(pageStatus: $pageStatus, processing: $processing, materialList: $materialList, errorEntity: $errorEntity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialPositionStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            const DeepCollectionEquality()
                .equals(other._materialList, _materialList) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageStatus, processing,
      const DeepCollectionEquality().hash(_materialList), errorEntity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialPositionStateImplCopyWith<_$MaterialPositionStateImpl>
      get copyWith => __$$MaterialPositionStateImplCopyWithImpl<
          _$MaterialPositionStateImpl>(this, _$identity);
}

abstract class _MaterialPositionState implements MaterialPositionState {
  factory _MaterialPositionState(
      {final PageStatus pageStatus,
      final bool processing,
      final List<MaterialLocationResponseModel> materialList,
      final ErrorEntity? errorEntity}) = _$MaterialPositionStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  List<MaterialLocationResponseModel> get materialList;
  @override
  ErrorEntity? get errorEntity;
  @override
  @JsonKey(ignore: true)
  _$$MaterialPositionStateImplCopyWith<_$MaterialPositionStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'material_sample_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MaterialSampleState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  MaterialSampleResponseModel? get materialSample =>
      throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MaterialSampleStateCopyWith<MaterialSampleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialSampleStateCopyWith<$Res> {
  factory $MaterialSampleStateCopyWith(
          MaterialSampleState value, $Res Function(MaterialSampleState) then) =
      _$MaterialSampleStateCopyWithImpl<$Res, MaterialSampleState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      MaterialSampleResponseModel? materialSample,
      ErrorEntity? errorEntity});
}

/// @nodoc
class _$MaterialSampleStateCopyWithImpl<$Res, $Val extends MaterialSampleState>
    implements $MaterialSampleStateCopyWith<$Res> {
  _$MaterialSampleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? materialSample = freezed,
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
      materialSample: freezed == materialSample
          ? _value.materialSample
          : materialSample // ignore: cast_nullable_to_non_nullable
              as MaterialSampleResponseModel?,
      errorEntity: freezed == errorEntity
          ? _value.errorEntity
          : errorEntity // ignore: cast_nullable_to_non_nullable
              as ErrorEntity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MaterialSampleStateImplCopyWith<$Res>
    implements $MaterialSampleStateCopyWith<$Res> {
  factory _$$MaterialSampleStateImplCopyWith(_$MaterialSampleStateImpl value,
          $Res Function(_$MaterialSampleStateImpl) then) =
      __$$MaterialSampleStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      MaterialSampleResponseModel? materialSample,
      ErrorEntity? errorEntity});
}

/// @nodoc
class __$$MaterialSampleStateImplCopyWithImpl<$Res>
    extends _$MaterialSampleStateCopyWithImpl<$Res, _$MaterialSampleStateImpl>
    implements _$$MaterialSampleStateImplCopyWith<$Res> {
  __$$MaterialSampleStateImplCopyWithImpl(_$MaterialSampleStateImpl _value,
      $Res Function(_$MaterialSampleStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? materialSample = freezed,
    Object? errorEntity = freezed,
  }) {
    return _then(_$MaterialSampleStateImpl(
      pageStatus: null == pageStatus
          ? _value.pageStatus
          : pageStatus // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as bool,
      materialSample: freezed == materialSample
          ? _value.materialSample
          : materialSample // ignore: cast_nullable_to_non_nullable
              as MaterialSampleResponseModel?,
      errorEntity: freezed == errorEntity
          ? _value.errorEntity
          : errorEntity // ignore: cast_nullable_to_non_nullable
              as ErrorEntity?,
    ));
  }
}

/// @nodoc

class _$MaterialSampleStateImpl implements _MaterialSampleState {
  _$MaterialSampleStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.materialSample = null,
      this.errorEntity = null});

  @override
  @JsonKey()
  final PageStatus pageStatus;
  @override
  @JsonKey()
  final bool processing;
  @override
  @JsonKey()
  final MaterialSampleResponseModel? materialSample;
  @override
  @JsonKey()
  final ErrorEntity? errorEntity;

  @override
  String toString() {
    return 'MaterialSampleState(pageStatus: $pageStatus, processing: $processing, materialSample: $materialSample, errorEntity: $errorEntity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialSampleStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.materialSample, materialSample) ||
                other.materialSample == materialSample) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, pageStatus, processing, materialSample, errorEntity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialSampleStateImplCopyWith<_$MaterialSampleStateImpl> get copyWith =>
      __$$MaterialSampleStateImplCopyWithImpl<_$MaterialSampleStateImpl>(
          this, _$identity);
}

abstract class _MaterialSampleState implements MaterialSampleState {
  factory _MaterialSampleState(
      {final PageStatus pageStatus,
      final bool processing,
      final MaterialSampleResponseModel? materialSample,
      final ErrorEntity? errorEntity}) = _$MaterialSampleStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  MaterialSampleResponseModel? get materialSample;
  @override
  ErrorEntity? get errorEntity;
  @override
  @JsonKey(ignore: true)
  _$$MaterialSampleStateImplCopyWith<_$MaterialSampleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'out_trolley_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OutTrolleyState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  String? get trolleyBarcode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OutTrolleyStateCopyWith<OutTrolleyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutTrolleyStateCopyWith<$Res> {
  factory $OutTrolleyStateCopyWith(
          OutTrolleyState value, $Res Function(OutTrolleyState) then) =
      _$OutTrolleyStateCopyWithImpl<$Res, OutTrolleyState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      String? trolleyBarcode});
}

/// @nodoc
class _$OutTrolleyStateCopyWithImpl<$Res, $Val extends OutTrolleyState>
    implements $OutTrolleyStateCopyWith<$Res> {
  _$OutTrolleyStateCopyWithImpl(this._value, this._then);

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
    Object? trolleyBarcode = freezed,
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
      trolleyBarcode: freezed == trolleyBarcode
          ? _value.trolleyBarcode
          : trolleyBarcode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutTrolleyStateImplCopyWith<$Res>
    implements $OutTrolleyStateCopyWith<$Res> {
  factory _$$OutTrolleyStateImplCopyWith(_$OutTrolleyStateImpl value,
          $Res Function(_$OutTrolleyStateImpl) then) =
      __$$OutTrolleyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      String? trolleyBarcode});
}

/// @nodoc
class __$$OutTrolleyStateImplCopyWithImpl<$Res>
    extends _$OutTrolleyStateCopyWithImpl<$Res, _$OutTrolleyStateImpl>
    implements _$$OutTrolleyStateImplCopyWith<$Res> {
  __$$OutTrolleyStateImplCopyWithImpl(
      _$OutTrolleyStateImpl _value, $Res Function(_$OutTrolleyStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? trolleyBarcode = freezed,
  }) {
    return _then(_$OutTrolleyStateImpl(
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
      trolleyBarcode: freezed == trolleyBarcode
          ? _value.trolleyBarcode
          : trolleyBarcode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$OutTrolleyStateImpl implements _OutTrolleyState {
  _$OutTrolleyStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      this.trolleyBarcode = null});

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
  final String? trolleyBarcode;

  @override
  String toString() {
    return 'OutTrolleyState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, trolleyBarcode: $trolleyBarcode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutTrolleyStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.trolleyBarcode, trolleyBarcode) ||
                other.trolleyBarcode == trolleyBarcode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, pageStatus, processing, errorEntity, trolleyBarcode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutTrolleyStateImplCopyWith<_$OutTrolleyStateImpl> get copyWith =>
      __$$OutTrolleyStateImplCopyWithImpl<_$OutTrolleyStateImpl>(
          this, _$identity);
}

abstract class _OutTrolleyState implements OutTrolleyState {
  factory _OutTrolleyState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final String? trolleyBarcode}) = _$OutTrolleyStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  String? get trolleyBarcode;
  @override
  @JsonKey(ignore: true)
  _$$OutTrolleyStateImplCopyWith<_$OutTrolleyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

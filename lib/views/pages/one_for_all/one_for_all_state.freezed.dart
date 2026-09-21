// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'one_for_all_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OneForAllState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  QRCard? get qrCard => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OneForAllStateCopyWith<OneForAllState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OneForAllStateCopyWith<$Res> {
  factory $OneForAllStateCopyWith(
          OneForAllState value, $Res Function(OneForAllState) then) =
      _$OneForAllStateCopyWithImpl<$Res, OneForAllState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      QRCard? qrCard});
}

/// @nodoc
class _$OneForAllStateCopyWithImpl<$Res, $Val extends OneForAllState>
    implements $OneForAllStateCopyWith<$Res> {
  _$OneForAllStateCopyWithImpl(this._value, this._then);

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
    Object? qrCard = freezed,
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
      qrCard: freezed == qrCard
          ? _value.qrCard
          : qrCard // ignore: cast_nullable_to_non_nullable
              as QRCard?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OneForAllStateImplCopyWith<$Res>
    implements $OneForAllStateCopyWith<$Res> {
  factory _$$OneForAllStateImplCopyWith(_$OneForAllStateImpl value,
          $Res Function(_$OneForAllStateImpl) then) =
      __$$OneForAllStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      QRCard? qrCard});
}

/// @nodoc
class __$$OneForAllStateImplCopyWithImpl<$Res>
    extends _$OneForAllStateCopyWithImpl<$Res, _$OneForAllStateImpl>
    implements _$$OneForAllStateImplCopyWith<$Res> {
  __$$OneForAllStateImplCopyWithImpl(
      _$OneForAllStateImpl _value, $Res Function(_$OneForAllStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? qrCard = freezed,
  }) {
    return _then(_$OneForAllStateImpl(
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
      qrCard: freezed == qrCard
          ? _value.qrCard
          : qrCard // ignore: cast_nullable_to_non_nullable
              as QRCard?,
    ));
  }
}

/// @nodoc

class _$OneForAllStateImpl implements _OneForAllState {
  _$OneForAllStateImpl(
      {this.pageStatus = PageStatus.initial,
      this.processing = false,
      this.errorEntity = null,
      this.qrCard = null});

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
  final QRCard? qrCard;

  @override
  String toString() {
    return 'OneForAllState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, qrCard: $qrCard)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OneForAllStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.qrCard, qrCard) || other.qrCard == qrCard));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, pageStatus, processing, errorEntity, qrCard);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OneForAllStateImplCopyWith<_$OneForAllStateImpl> get copyWith =>
      __$$OneForAllStateImplCopyWithImpl<_$OneForAllStateImpl>(
          this, _$identity);
}

abstract class _OneForAllState implements OneForAllState {
  factory _OneForAllState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final QRCard? qrCard}) = _$OneForAllStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  QRCard? get qrCard;
  @override
  @JsonKey(ignore: true)
  _$$OneForAllStateImplCopyWith<_$OneForAllStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

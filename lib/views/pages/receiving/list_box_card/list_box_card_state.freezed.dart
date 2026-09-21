// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_box_card_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ListBoxCardState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  int get totalQuantity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ListBoxCardStateCopyWith<ListBoxCardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListBoxCardStateCopyWith<$Res> {
  factory $ListBoxCardStateCopyWith(
          ListBoxCardState value, $Res Function(ListBoxCardState) then) =
      _$ListBoxCardStateCopyWithImpl<$Res, ListBoxCardState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      int totalQuantity});
}

/// @nodoc
class _$ListBoxCardStateCopyWithImpl<$Res, $Val extends ListBoxCardState>
    implements $ListBoxCardStateCopyWith<$Res> {
  _$ListBoxCardStateCopyWithImpl(this._value, this._then);

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
    Object? totalQuantity = null,
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
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListBoxCardStateImplCopyWith<$Res>
    implements $ListBoxCardStateCopyWith<$Res> {
  factory _$$ListBoxCardStateImplCopyWith(_$ListBoxCardStateImpl value,
          $Res Function(_$ListBoxCardStateImpl) then) =
      __$$ListBoxCardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      int totalQuantity});
}

/// @nodoc
class __$$ListBoxCardStateImplCopyWithImpl<$Res>
    extends _$ListBoxCardStateCopyWithImpl<$Res, _$ListBoxCardStateImpl>
    implements _$$ListBoxCardStateImplCopyWith<$Res> {
  __$$ListBoxCardStateImplCopyWithImpl(_$ListBoxCardStateImpl _value,
      $Res Function(_$ListBoxCardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? totalQuantity = null,
  }) {
    return _then(_$ListBoxCardStateImpl(
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
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ListBoxCardStateImpl implements _ListBoxCardState {
  _$ListBoxCardStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      this.totalQuantity = 0});

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
  final int totalQuantity;

  @override
  String toString() {
    return 'ListBoxCardState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, totalQuantity: $totalQuantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListBoxCardStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, pageStatus, processing, errorEntity, totalQuantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListBoxCardStateImplCopyWith<_$ListBoxCardStateImpl> get copyWith =>
      __$$ListBoxCardStateImplCopyWithImpl<_$ListBoxCardStateImpl>(
          this, _$identity);
}

abstract class _ListBoxCardState implements ListBoxCardState {
  factory _ListBoxCardState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final int totalQuantity}) = _$ListBoxCardStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  int get totalQuantity;
  @override
  @JsonKey(ignore: true)
  _$$ListBoxCardStateImplCopyWith<_$ListBoxCardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

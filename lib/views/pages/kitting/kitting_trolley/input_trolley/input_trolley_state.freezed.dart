// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_trolley_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InputTrolleyState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  String get trolley => throw _privateConstructorUsedError;
  List<String> get listKittingCardQr => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InputTrolleyStateCopyWith<InputTrolleyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputTrolleyStateCopyWith<$Res> {
  factory $InputTrolleyStateCopyWith(
          InputTrolleyState value, $Res Function(InputTrolleyState) then) =
      _$InputTrolleyStateCopyWithImpl<$Res, InputTrolleyState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      String trolley,
      List<String> listKittingCardQr});
}

/// @nodoc
class _$InputTrolleyStateCopyWithImpl<$Res, $Val extends InputTrolleyState>
    implements $InputTrolleyStateCopyWith<$Res> {
  _$InputTrolleyStateCopyWithImpl(this._value, this._then);

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
    Object? trolley = null,
    Object? listKittingCardQr = null,
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
      trolley: null == trolley
          ? _value.trolley
          : trolley // ignore: cast_nullable_to_non_nullable
              as String,
      listKittingCardQr: null == listKittingCardQr
          ? _value.listKittingCardQr
          : listKittingCardQr // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InputTrolleyStateImplCopyWith<$Res>
    implements $InputTrolleyStateCopyWith<$Res> {
  factory _$$InputTrolleyStateImplCopyWith(_$InputTrolleyStateImpl value,
          $Res Function(_$InputTrolleyStateImpl) then) =
      __$$InputTrolleyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      String trolley,
      List<String> listKittingCardQr});
}

/// @nodoc
class __$$InputTrolleyStateImplCopyWithImpl<$Res>
    extends _$InputTrolleyStateCopyWithImpl<$Res, _$InputTrolleyStateImpl>
    implements _$$InputTrolleyStateImplCopyWith<$Res> {
  __$$InputTrolleyStateImplCopyWithImpl(_$InputTrolleyStateImpl _value,
      $Res Function(_$InputTrolleyStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? trolley = null,
    Object? listKittingCardQr = null,
  }) {
    return _then(_$InputTrolleyStateImpl(
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
      trolley: null == trolley
          ? _value.trolley
          : trolley // ignore: cast_nullable_to_non_nullable
              as String,
      listKittingCardQr: null == listKittingCardQr
          ? _value._listKittingCardQr
          : listKittingCardQr // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$InputTrolleyStateImpl implements _InputTrolleyState {
  _$InputTrolleyStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      this.trolley = '',
      final List<String> listKittingCardQr = const []})
      : _listKittingCardQr = listKittingCardQr;

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
  final String trolley;
  final List<String> _listKittingCardQr;
  @override
  @JsonKey()
  List<String> get listKittingCardQr {
    if (_listKittingCardQr is EqualUnmodifiableListView)
      return _listKittingCardQr;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listKittingCardQr);
  }

  @override
  String toString() {
    return 'InputTrolleyState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, trolley: $trolley, listKittingCardQr: $listKittingCardQr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputTrolleyStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.trolley, trolley) || other.trolley == trolley) &&
            const DeepCollectionEquality()
                .equals(other._listKittingCardQr, _listKittingCardQr));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      trolley,
      const DeepCollectionEquality().hash(_listKittingCardQr));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InputTrolleyStateImplCopyWith<_$InputTrolleyStateImpl> get copyWith =>
      __$$InputTrolleyStateImplCopyWithImpl<_$InputTrolleyStateImpl>(
          this, _$identity);
}

abstract class _InputTrolleyState implements InputTrolleyState {
  factory _InputTrolleyState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final String trolley,
      final List<String> listKittingCardQr}) = _$InputTrolleyStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  String get trolley;
  @override
  List<String> get listKittingCardQr;
  @override
  @JsonKey(ignore: true)
  _$$InputTrolleyStateImplCopyWith<_$InputTrolleyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_trolley_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CheckTrolleyState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  String get trolley => throw _privateConstructorUsedError;
  String get barcode => throw _privateConstructorUsedError;
  List<KittingList> get kittingLists => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckTrolleyStateCopyWith<CheckTrolleyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckTrolleyStateCopyWith<$Res> {
  factory $CheckTrolleyStateCopyWith(
          CheckTrolleyState value, $Res Function(CheckTrolleyState) then) =
      _$CheckTrolleyStateCopyWithImpl<$Res, CheckTrolleyState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      String trolley,
      String barcode,
      List<KittingList> kittingLists});
}

/// @nodoc
class _$CheckTrolleyStateCopyWithImpl<$Res, $Val extends CheckTrolleyState>
    implements $CheckTrolleyStateCopyWith<$Res> {
  _$CheckTrolleyStateCopyWithImpl(this._value, this._then);

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
    Object? barcode = null,
    Object? kittingLists = null,
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
      barcode: null == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String,
      kittingLists: null == kittingLists
          ? _value.kittingLists
          : kittingLists // ignore: cast_nullable_to_non_nullable
              as List<KittingList>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckTrolleyStateImplCopyWith<$Res>
    implements $CheckTrolleyStateCopyWith<$Res> {
  factory _$$CheckTrolleyStateImplCopyWith(_$CheckTrolleyStateImpl value,
          $Res Function(_$CheckTrolleyStateImpl) then) =
      __$$CheckTrolleyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      String trolley,
      String barcode,
      List<KittingList> kittingLists});
}

/// @nodoc
class __$$CheckTrolleyStateImplCopyWithImpl<$Res>
    extends _$CheckTrolleyStateCopyWithImpl<$Res, _$CheckTrolleyStateImpl>
    implements _$$CheckTrolleyStateImplCopyWith<$Res> {
  __$$CheckTrolleyStateImplCopyWithImpl(_$CheckTrolleyStateImpl _value,
      $Res Function(_$CheckTrolleyStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? trolley = null,
    Object? barcode = null,
    Object? kittingLists = null,
  }) {
    return _then(_$CheckTrolleyStateImpl(
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
      barcode: null == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String,
      kittingLists: null == kittingLists
          ? _value._kittingLists
          : kittingLists // ignore: cast_nullable_to_non_nullable
              as List<KittingList>,
    ));
  }
}

/// @nodoc

class _$CheckTrolleyStateImpl implements _CheckTrolleyState {
  _$CheckTrolleyStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      this.trolley = '',
      this.barcode = '',
      final List<KittingList> kittingLists = const []})
      : _kittingLists = kittingLists;

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
  @override
  @JsonKey()
  final String barcode;
  final List<KittingList> _kittingLists;
  @override
  @JsonKey()
  List<KittingList> get kittingLists {
    if (_kittingLists is EqualUnmodifiableListView) return _kittingLists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_kittingLists);
  }

  @override
  String toString() {
    return 'CheckTrolleyState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, trolley: $trolley, barcode: $barcode, kittingLists: $kittingLists)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckTrolleyStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.trolley, trolley) || other.trolley == trolley) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            const DeepCollectionEquality()
                .equals(other._kittingLists, _kittingLists));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      trolley,
      barcode,
      const DeepCollectionEquality().hash(_kittingLists));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckTrolleyStateImplCopyWith<_$CheckTrolleyStateImpl> get copyWith =>
      __$$CheckTrolleyStateImplCopyWithImpl<_$CheckTrolleyStateImpl>(
          this, _$identity);
}

abstract class _CheckTrolleyState implements CheckTrolleyState {
  factory _CheckTrolleyState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final String trolley,
      final String barcode,
      final List<KittingList> kittingLists}) = _$CheckTrolleyStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  String get trolley;
  @override
  String get barcode;
  @override
  List<KittingList> get kittingLists;
  @override
  @JsonKey(ignore: true)
  _$$CheckTrolleyStateImplCopyWith<_$CheckTrolleyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_trolley_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChangeTrolleyState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  String? get trolleySource => throw _privateConstructorUsedError;
  String? get trolleyEnd => throw _privateConstructorUsedError;
  List<String> get barCodeKittingList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChangeTrolleyStateCopyWith<ChangeTrolleyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeTrolleyStateCopyWith<$Res> {
  factory $ChangeTrolleyStateCopyWith(
          ChangeTrolleyState value, $Res Function(ChangeTrolleyState) then) =
      _$ChangeTrolleyStateCopyWithImpl<$Res, ChangeTrolleyState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      String? trolleySource,
      String? trolleyEnd,
      List<String> barCodeKittingList});
}

/// @nodoc
class _$ChangeTrolleyStateCopyWithImpl<$Res, $Val extends ChangeTrolleyState>
    implements $ChangeTrolleyStateCopyWith<$Res> {
  _$ChangeTrolleyStateCopyWithImpl(this._value, this._then);

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
    Object? trolleySource = freezed,
    Object? trolleyEnd = freezed,
    Object? barCodeKittingList = null,
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
      trolleySource: freezed == trolleySource
          ? _value.trolleySource
          : trolleySource // ignore: cast_nullable_to_non_nullable
              as String?,
      trolleyEnd: freezed == trolleyEnd
          ? _value.trolleyEnd
          : trolleyEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      barCodeKittingList: null == barCodeKittingList
          ? _value.barCodeKittingList
          : barCodeKittingList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangeTrolleyStateImplCopyWith<$Res>
    implements $ChangeTrolleyStateCopyWith<$Res> {
  factory _$$ChangeTrolleyStateImplCopyWith(_$ChangeTrolleyStateImpl value,
          $Res Function(_$ChangeTrolleyStateImpl) then) =
      __$$ChangeTrolleyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      String? trolleySource,
      String? trolleyEnd,
      List<String> barCodeKittingList});
}

/// @nodoc
class __$$ChangeTrolleyStateImplCopyWithImpl<$Res>
    extends _$ChangeTrolleyStateCopyWithImpl<$Res, _$ChangeTrolleyStateImpl>
    implements _$$ChangeTrolleyStateImplCopyWith<$Res> {
  __$$ChangeTrolleyStateImplCopyWithImpl(_$ChangeTrolleyStateImpl _value,
      $Res Function(_$ChangeTrolleyStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? trolleySource = freezed,
    Object? trolleyEnd = freezed,
    Object? barCodeKittingList = null,
  }) {
    return _then(_$ChangeTrolleyStateImpl(
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
      trolleySource: freezed == trolleySource
          ? _value.trolleySource
          : trolleySource // ignore: cast_nullable_to_non_nullable
              as String?,
      trolleyEnd: freezed == trolleyEnd
          ? _value.trolleyEnd
          : trolleyEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      barCodeKittingList: null == barCodeKittingList
          ? _value._barCodeKittingList
          : barCodeKittingList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$ChangeTrolleyStateImpl implements _ChangeTrolleyState {
  _$ChangeTrolleyStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      this.trolleySource = null,
      this.trolleyEnd = null,
      final List<String> barCodeKittingList = const []})
      : _barCodeKittingList = barCodeKittingList;

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
  final String? trolleySource;
  @override
  @JsonKey()
  final String? trolleyEnd;
  final List<String> _barCodeKittingList;
  @override
  @JsonKey()
  List<String> get barCodeKittingList {
    if (_barCodeKittingList is EqualUnmodifiableListView)
      return _barCodeKittingList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_barCodeKittingList);
  }

  @override
  String toString() {
    return 'ChangeTrolleyState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, trolleySource: $trolleySource, trolleyEnd: $trolleyEnd, barCodeKittingList: $barCodeKittingList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeTrolleyStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.trolleySource, trolleySource) ||
                other.trolleySource == trolleySource) &&
            (identical(other.trolleyEnd, trolleyEnd) ||
                other.trolleyEnd == trolleyEnd) &&
            const DeepCollectionEquality()
                .equals(other._barCodeKittingList, _barCodeKittingList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      trolleySource,
      trolleyEnd,
      const DeepCollectionEquality().hash(_barCodeKittingList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeTrolleyStateImplCopyWith<_$ChangeTrolleyStateImpl> get copyWith =>
      __$$ChangeTrolleyStateImplCopyWithImpl<_$ChangeTrolleyStateImpl>(
          this, _$identity);
}

abstract class _ChangeTrolleyState implements ChangeTrolleyState {
  factory _ChangeTrolleyState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final String? trolleySource,
      final String? trolleyEnd,
      final List<String> barCodeKittingList}) = _$ChangeTrolleyStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  String? get trolleySource;
  @override
  String? get trolleyEnd;
  @override
  List<String> get barCodeKittingList;
  @override
  @JsonKey(ignore: true)
  _$$ChangeTrolleyStateImplCopyWith<_$ChangeTrolleyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

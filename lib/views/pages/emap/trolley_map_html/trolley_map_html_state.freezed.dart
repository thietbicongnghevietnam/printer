// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trolley_map_html_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TrolleyMapHTMLState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  MapTrolleyResponsesModel? get trolleyMapData =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrolleyMapHTMLStateCopyWith<TrolleyMapHTMLState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrolleyMapHTMLStateCopyWith<$Res> {
  factory $TrolleyMapHTMLStateCopyWith(
          TrolleyMapHTMLState value, $Res Function(TrolleyMapHTMLState) then) =
      _$TrolleyMapHTMLStateCopyWithImpl<$Res, TrolleyMapHTMLState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      MapTrolleyResponsesModel? trolleyMapData});
}

/// @nodoc
class _$TrolleyMapHTMLStateCopyWithImpl<$Res, $Val extends TrolleyMapHTMLState>
    implements $TrolleyMapHTMLStateCopyWith<$Res> {
  _$TrolleyMapHTMLStateCopyWithImpl(this._value, this._then);

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
    Object? trolleyMapData = freezed,
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
      trolleyMapData: freezed == trolleyMapData
          ? _value.trolleyMapData
          : trolleyMapData // ignore: cast_nullable_to_non_nullable
              as MapTrolleyResponsesModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrolleyMapHTMLStateImplCopyWith<$Res>
    implements $TrolleyMapHTMLStateCopyWith<$Res> {
  factory _$$TrolleyMapHTMLStateImplCopyWith(_$TrolleyMapHTMLStateImpl value,
          $Res Function(_$TrolleyMapHTMLStateImpl) then) =
      __$$TrolleyMapHTMLStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      MapTrolleyResponsesModel? trolleyMapData});
}

/// @nodoc
class __$$TrolleyMapHTMLStateImplCopyWithImpl<$Res>
    extends _$TrolleyMapHTMLStateCopyWithImpl<$Res, _$TrolleyMapHTMLStateImpl>
    implements _$$TrolleyMapHTMLStateImplCopyWith<$Res> {
  __$$TrolleyMapHTMLStateImplCopyWithImpl(_$TrolleyMapHTMLStateImpl _value,
      $Res Function(_$TrolleyMapHTMLStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? trolleyMapData = freezed,
  }) {
    return _then(_$TrolleyMapHTMLStateImpl(
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
      trolleyMapData: freezed == trolleyMapData
          ? _value.trolleyMapData
          : trolleyMapData // ignore: cast_nullable_to_non_nullable
              as MapTrolleyResponsesModel?,
    ));
  }
}

/// @nodoc

class _$TrolleyMapHTMLStateImpl implements _TrolleyMapHTMLState {
  _$TrolleyMapHTMLStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      this.trolleyMapData = null});

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
  final MapTrolleyResponsesModel? trolleyMapData;

  @override
  String toString() {
    return 'TrolleyMapHTMLState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, trolleyMapData: $trolleyMapData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrolleyMapHTMLStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.trolleyMapData, trolleyMapData) ||
                other.trolleyMapData == trolleyMapData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, pageStatus, processing, errorEntity, trolleyMapData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrolleyMapHTMLStateImplCopyWith<_$TrolleyMapHTMLStateImpl> get copyWith =>
      __$$TrolleyMapHTMLStateImplCopyWithImpl<_$TrolleyMapHTMLStateImpl>(
          this, _$identity);
}

abstract class _TrolleyMapHTMLState implements TrolleyMapHTMLState {
  factory _TrolleyMapHTMLState(
          {final PageStatus pageStatus,
          final bool processing,
          final ErrorEntity? errorEntity,
          final MapTrolleyResponsesModel? trolleyMapData}) =
      _$TrolleyMapHTMLStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  MapTrolleyResponsesModel? get trolleyMapData;
  @override
  @JsonKey(ignore: true)
  _$$TrolleyMapHTMLStateImplCopyWith<_$TrolleyMapHTMLStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'find_barcode_lost_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FindBarcodeLostState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  int get activePage => throw _privateConstructorUsedError;
  ReceivingCard? get receivingCard => throw _privateConstructorUsedError;
  Barcode? get barcode => throw _privateConstructorUsedError;
  List<ReceivingCardItem> get listBoxAlive =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FindBarcodeLostStateCopyWith<FindBarcodeLostState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FindBarcodeLostStateCopyWith<$Res> {
  factory $FindBarcodeLostStateCopyWith(FindBarcodeLostState value,
          $Res Function(FindBarcodeLostState) then) =
      _$FindBarcodeLostStateCopyWithImpl<$Res, FindBarcodeLostState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      int activePage,
      ReceivingCard? receivingCard,
      Barcode? barcode,
      List<ReceivingCardItem> listBoxAlive});
}

/// @nodoc
class _$FindBarcodeLostStateCopyWithImpl<$Res,
        $Val extends FindBarcodeLostState>
    implements $FindBarcodeLostStateCopyWith<$Res> {
  _$FindBarcodeLostStateCopyWithImpl(this._value, this._then);

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
    Object? activePage = null,
    Object? receivingCard = freezed,
    Object? barcode = freezed,
    Object? listBoxAlive = null,
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
      activePage: null == activePage
          ? _value.activePage
          : activePage // ignore: cast_nullable_to_non_nullable
              as int,
      receivingCard: freezed == receivingCard
          ? _value.receivingCard
          : receivingCard // ignore: cast_nullable_to_non_nullable
              as ReceivingCard?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as Barcode?,
      listBoxAlive: null == listBoxAlive
          ? _value.listBoxAlive
          : listBoxAlive // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FindBarcodeLostStateImplCopyWith<$Res>
    implements $FindBarcodeLostStateCopyWith<$Res> {
  factory _$$FindBarcodeLostStateImplCopyWith(_$FindBarcodeLostStateImpl value,
          $Res Function(_$FindBarcodeLostStateImpl) then) =
      __$$FindBarcodeLostStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      int activePage,
      ReceivingCard? receivingCard,
      Barcode? barcode,
      List<ReceivingCardItem> listBoxAlive});
}

/// @nodoc
class __$$FindBarcodeLostStateImplCopyWithImpl<$Res>
    extends _$FindBarcodeLostStateCopyWithImpl<$Res, _$FindBarcodeLostStateImpl>
    implements _$$FindBarcodeLostStateImplCopyWith<$Res> {
  __$$FindBarcodeLostStateImplCopyWithImpl(_$FindBarcodeLostStateImpl _value,
      $Res Function(_$FindBarcodeLostStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? activePage = null,
    Object? receivingCard = freezed,
    Object? barcode = freezed,
    Object? listBoxAlive = null,
  }) {
    return _then(_$FindBarcodeLostStateImpl(
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
      activePage: null == activePage
          ? _value.activePage
          : activePage // ignore: cast_nullable_to_non_nullable
              as int,
      receivingCard: freezed == receivingCard
          ? _value.receivingCard
          : receivingCard // ignore: cast_nullable_to_non_nullable
              as ReceivingCard?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as Barcode?,
      listBoxAlive: null == listBoxAlive
          ? _value._listBoxAlive
          : listBoxAlive // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCardItem>,
    ));
  }
}

/// @nodoc

class _$FindBarcodeLostStateImpl implements _FindBarcodeLostState {
  _$FindBarcodeLostStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      this.activePage = 0,
      this.receivingCard = null,
      this.barcode = null,
      final List<ReceivingCardItem> listBoxAlive = const []})
      : _listBoxAlive = listBoxAlive;

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
  final int activePage;
  @override
  @JsonKey()
  final ReceivingCard? receivingCard;
  @override
  @JsonKey()
  final Barcode? barcode;
  final List<ReceivingCardItem> _listBoxAlive;
  @override
  @JsonKey()
  List<ReceivingCardItem> get listBoxAlive {
    if (_listBoxAlive is EqualUnmodifiableListView) return _listBoxAlive;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listBoxAlive);
  }

  @override
  String toString() {
    return 'FindBarcodeLostState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, activePage: $activePage, receivingCard: $receivingCard, barcode: $barcode, listBoxAlive: $listBoxAlive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FindBarcodeLostStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.activePage, activePage) ||
                other.activePage == activePage) &&
            (identical(other.receivingCard, receivingCard) ||
                other.receivingCard == receivingCard) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            const DeepCollectionEquality()
                .equals(other._listBoxAlive, _listBoxAlive));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      activePage,
      receivingCard,
      barcode,
      const DeepCollectionEquality().hash(_listBoxAlive));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FindBarcodeLostStateImplCopyWith<_$FindBarcodeLostStateImpl>
      get copyWith =>
          __$$FindBarcodeLostStateImplCopyWithImpl<_$FindBarcodeLostStateImpl>(
              this, _$identity);
}

abstract class _FindBarcodeLostState implements FindBarcodeLostState {
  factory _FindBarcodeLostState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final int activePage,
      final ReceivingCard? receivingCard,
      final Barcode? barcode,
      final List<ReceivingCardItem> listBoxAlive}) = _$FindBarcodeLostStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  int get activePage;
  @override
  ReceivingCard? get receivingCard;
  @override
  Barcode? get barcode;
  @override
  List<ReceivingCardItem> get listBoxAlive;
  @override
  @JsonKey(ignore: true)
  _$$FindBarcodeLostStateImplCopyWith<_$FindBarcodeLostStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

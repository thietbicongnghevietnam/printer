// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'out_receiving_card_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OutReceivingCardState {
  PageStatus get pageStatus => throw _privateConstructorUsedError;
  bool get processing => throw _privateConstructorUsedError;
  ErrorEntity? get errorEntity => throw _privateConstructorUsedError;
  String? get receivingCard => throw _privateConstructorUsedError;
  String? get pallet => throw _privateConstructorUsedError;
  InOutType get inOutType => throw _privateConstructorUsedError;
  List<ReceivingCard> get receivingCards => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OutReceivingCardStateCopyWith<OutReceivingCardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutReceivingCardStateCopyWith<$Res> {
  factory $OutReceivingCardStateCopyWith(OutReceivingCardState value,
          $Res Function(OutReceivingCardState) then) =
      _$OutReceivingCardStateCopyWithImpl<$Res, OutReceivingCardState>;
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      String? receivingCard,
      String? pallet,
      InOutType inOutType,
      List<ReceivingCard> receivingCards});
}

/// @nodoc
class _$OutReceivingCardStateCopyWithImpl<$Res,
        $Val extends OutReceivingCardState>
    implements $OutReceivingCardStateCopyWith<$Res> {
  _$OutReceivingCardStateCopyWithImpl(this._value, this._then);

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
    Object? receivingCard = freezed,
    Object? pallet = freezed,
    Object? inOutType = null,
    Object? receivingCards = null,
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
      receivingCard: freezed == receivingCard
          ? _value.receivingCard
          : receivingCard // ignore: cast_nullable_to_non_nullable
              as String?,
      pallet: freezed == pallet
          ? _value.pallet
          : pallet // ignore: cast_nullable_to_non_nullable
              as String?,
      inOutType: null == inOutType
          ? _value.inOutType
          : inOutType // ignore: cast_nullable_to_non_nullable
              as InOutType,
      receivingCards: null == receivingCards
          ? _value.receivingCards
          : receivingCards // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutReceivingCardStateImplCopyWith<$Res>
    implements $OutReceivingCardStateCopyWith<$Res> {
  factory _$$OutReceivingCardStateImplCopyWith(
          _$OutReceivingCardStateImpl value,
          $Res Function(_$OutReceivingCardStateImpl) then) =
      __$$OutReceivingCardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PageStatus pageStatus,
      bool processing,
      ErrorEntity? errorEntity,
      String? receivingCard,
      String? pallet,
      InOutType inOutType,
      List<ReceivingCard> receivingCards});
}

/// @nodoc
class __$$OutReceivingCardStateImplCopyWithImpl<$Res>
    extends _$OutReceivingCardStateCopyWithImpl<$Res,
        _$OutReceivingCardStateImpl>
    implements _$$OutReceivingCardStateImplCopyWith<$Res> {
  __$$OutReceivingCardStateImplCopyWithImpl(_$OutReceivingCardStateImpl _value,
      $Res Function(_$OutReceivingCardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageStatus = null,
    Object? processing = null,
    Object? errorEntity = freezed,
    Object? receivingCard = freezed,
    Object? pallet = freezed,
    Object? inOutType = null,
    Object? receivingCards = null,
  }) {
    return _then(_$OutReceivingCardStateImpl(
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
      receivingCard: freezed == receivingCard
          ? _value.receivingCard
          : receivingCard // ignore: cast_nullable_to_non_nullable
              as String?,
      pallet: freezed == pallet
          ? _value.pallet
          : pallet // ignore: cast_nullable_to_non_nullable
              as String?,
      inOutType: null == inOutType
          ? _value.inOutType
          : inOutType // ignore: cast_nullable_to_non_nullable
              as InOutType,
      receivingCards: null == receivingCards
          ? _value._receivingCards
          : receivingCards // ignore: cast_nullable_to_non_nullable
              as List<ReceivingCard>,
    ));
  }
}

/// @nodoc

class _$OutReceivingCardStateImpl implements _OutReceivingCardState {
  _$OutReceivingCardStateImpl(
      {this.pageStatus = PageStatus.loaded,
      this.processing = false,
      this.errorEntity = null,
      this.receivingCard = null,
      this.pallet = null,
      this.inOutType = InOutType.oneByOne,
      final List<ReceivingCard> receivingCards = const []})
      : _receivingCards = receivingCards;

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
  final String? receivingCard;
  @override
  @JsonKey()
  final String? pallet;
  @override
  @JsonKey()
  final InOutType inOutType;
  final List<ReceivingCard> _receivingCards;
  @override
  @JsonKey()
  List<ReceivingCard> get receivingCards {
    if (_receivingCards is EqualUnmodifiableListView) return _receivingCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_receivingCards);
  }

  @override
  String toString() {
    return 'OutReceivingCardState(pageStatus: $pageStatus, processing: $processing, errorEntity: $errorEntity, receivingCard: $receivingCard, pallet: $pallet, inOutType: $inOutType, receivingCards: $receivingCards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutReceivingCardStateImpl &&
            (identical(other.pageStatus, pageStatus) ||
                other.pageStatus == pageStatus) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.errorEntity, errorEntity) ||
                other.errorEntity == errorEntity) &&
            (identical(other.receivingCard, receivingCard) ||
                other.receivingCard == receivingCard) &&
            (identical(other.pallet, pallet) || other.pallet == pallet) &&
            (identical(other.inOutType, inOutType) ||
                other.inOutType == inOutType) &&
            const DeepCollectionEquality()
                .equals(other._receivingCards, _receivingCards));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageStatus,
      processing,
      errorEntity,
      receivingCard,
      pallet,
      inOutType,
      const DeepCollectionEquality().hash(_receivingCards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutReceivingCardStateImplCopyWith<_$OutReceivingCardStateImpl>
      get copyWith => __$$OutReceivingCardStateImplCopyWithImpl<
          _$OutReceivingCardStateImpl>(this, _$identity);
}

abstract class _OutReceivingCardState implements OutReceivingCardState {
  factory _OutReceivingCardState(
      {final PageStatus pageStatus,
      final bool processing,
      final ErrorEntity? errorEntity,
      final String? receivingCard,
      final String? pallet,
      final InOutType inOutType,
      final List<ReceivingCard> receivingCards}) = _$OutReceivingCardStateImpl;

  @override
  PageStatus get pageStatus;
  @override
  bool get processing;
  @override
  ErrorEntity? get errorEntity;
  @override
  String? get receivingCard;
  @override
  String? get pallet;
  @override
  InOutType get inOutType;
  @override
  List<ReceivingCard> get receivingCards;
  @override
  @JsonKey(ignore: true)
  _$$OutReceivingCardStateImplCopyWith<_$OutReceivingCardStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

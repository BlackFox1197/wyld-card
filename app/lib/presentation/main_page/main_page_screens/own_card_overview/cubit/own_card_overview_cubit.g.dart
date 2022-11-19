// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'own_card_overview_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OwnCardOverviewStateCWProxy {
  OwnCardOverviewState cards(List<Buisiness_card> cards);

  OwnCardOverviewState selectedIndex(int? selectedIndex);

  OwnCardOverviewState status(OCOStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OwnCardOverviewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OwnCardOverviewState(...).copyWith(id: 12, name: "My name")
  /// ````
  OwnCardOverviewState call({
    List<Buisiness_card>? cards,
    int? selectedIndex,
    OCOStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOwnCardOverviewState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOwnCardOverviewState.copyWith.fieldName(...)`
class _$OwnCardOverviewStateCWProxyImpl
    implements _$OwnCardOverviewStateCWProxy {
  final OwnCardOverviewState _value;

  const _$OwnCardOverviewStateCWProxyImpl(this._value);

  @override
  OwnCardOverviewState cards(List<Buisiness_card> cards) => this(cards: cards);

  @override
  OwnCardOverviewState selectedIndex(int? selectedIndex) =>
      this(selectedIndex: selectedIndex);

  @override
  OwnCardOverviewState status(OCOStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OwnCardOverviewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OwnCardOverviewState(...).copyWith(id: 12, name: "My name")
  /// ````
  OwnCardOverviewState call({
    Object? cards = const $CopyWithPlaceholder(),
    Object? selectedIndex = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return OwnCardOverviewState(
      cards: cards == const $CopyWithPlaceholder() || cards == null
          ? _value.cards
          // ignore: cast_nullable_to_non_nullable
          : cards as List<Buisiness_card>,
      selectedIndex: selectedIndex == const $CopyWithPlaceholder()
          ? _value.selectedIndex
          // ignore: cast_nullable_to_non_nullable
          : selectedIndex as int?,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as OCOStatus,
    );
  }
}

extension $OwnCardOverviewStateCopyWith on OwnCardOverviewState {
  /// Returns a callable class that can be used as follows: `instanceOfOwnCardOverviewState.copyWith(...)` or like so:`instanceOfOwnCardOverviewState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OwnCardOverviewStateCWProxy get copyWith =>
      _$OwnCardOverviewStateCWProxyImpl(this);
}

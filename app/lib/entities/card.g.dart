// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$Buisiness_cardCWProxy {
  Buisiness_card cardName(String? cardName);

  Buisiness_card color(Color color);

  Buisiness_card id(UniqueId? id);

  Buisiness_card mainCard(bool mainCard);

  Buisiness_card person(Person person);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Buisiness_card(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Buisiness_card(...).copyWith(id: 12, name: "My name")
  /// ````
  Buisiness_card call({
    String? cardName,
    Color? color,
    UniqueId? id,
    bool? mainCard,
    Person? person,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBuisiness_card.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBuisiness_card.copyWith.fieldName(...)`
class _$Buisiness_cardCWProxyImpl implements _$Buisiness_cardCWProxy {
  final Buisiness_card _value;

  const _$Buisiness_cardCWProxyImpl(this._value);

  @override
  Buisiness_card cardName(String? cardName) => this(cardName: cardName);

  @override
  Buisiness_card color(Color color) => this(color: color);

  @override
  Buisiness_card id(UniqueId? id) => this(id: id);

  @override
  Buisiness_card mainCard(bool mainCard) => this(mainCard: mainCard);

  @override
  Buisiness_card person(Person person) => this(person: person);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Buisiness_card(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Buisiness_card(...).copyWith(id: 12, name: "My name")
  /// ````
  Buisiness_card call({
    Object? cardName = const $CopyWithPlaceholder(),
    Object? color = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? mainCard = const $CopyWithPlaceholder(),
    Object? person = const $CopyWithPlaceholder(),
  }) {
    return Buisiness_card(
      cardName: cardName == const $CopyWithPlaceholder()
          ? _value.cardName
          // ignore: cast_nullable_to_non_nullable
          : cardName as String?,
      color: color == const $CopyWithPlaceholder() || color == null
          ? _value.color
          // ignore: cast_nullable_to_non_nullable
          : color as Color,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as UniqueId?,
      mainCard: mainCard == const $CopyWithPlaceholder() || mainCard == null
          ? _value.mainCard
          // ignore: cast_nullable_to_non_nullable
          : mainCard as bool,
      person: person == const $CopyWithPlaceholder() || person == null
          ? _value.person
          // ignore: cast_nullable_to_non_nullable
          : person as Person,
    );
  }
}

extension $Buisiness_cardCopyWith on Buisiness_card {
  /// Returns a callable class that can be used as follows: `instanceOfBuisiness_card.copyWith(...)` or like so:`instanceOfBuisiness_card.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$Buisiness_cardCWProxy get copyWith => _$Buisiness_cardCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Buisiness_card _$Buisiness_cardFromJson(Map<String, dynamic> json) =>
    Buisiness_card(
      mainCard: json['mainCard'] as bool,
      person: const PersonConverter()
          .fromJson(json['person'] as Map<String, dynamic>),
      color: const ColorConverter().fromJson(json['color'] as int),
      id: _$JsonConverterFromJson<String, UniqueId>(
          json['id'], const UuidConverter().fromJson),
      cardName: json['cardName'] as String?,
    );

Map<String, dynamic> _$Buisiness_cardToJson(Buisiness_card instance) =>
    <String, dynamic>{
      'cardName': instance.cardName,
      'id': const UuidConverter().toJson(instance.id),
      'person': const PersonConverter().toJson(instance.person),
      'color': const ColorConverter().toJson(instance.color),
      'mainCard': instance.mainCard,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

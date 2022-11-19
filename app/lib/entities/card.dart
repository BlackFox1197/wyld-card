import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wyld_card/entities/person.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';


@CopyWith()
@JsonSerializable()
class Buisiness_card {

  final String? cardName;
  @UuidConverter()
  late UniqueId id;
  @PersonConverter()
  final Person person;
  @ColorConverter()
  final Color color;
  final bool mainCard;

  Buisiness_card( {required this.mainCard, required this.person, required this.color, UniqueId? id, this.cardName}){
    this.id = id ?? UniqueId();
  }

  factory Buisiness_card.fromJson(Map<String, dynamic> json) => _$Buisiness_cardFromJson(json);

  Map<String, dynamic> toJson() => _$Buisiness_cardToJson(this);



}



class PersonConverter extends JsonConverter<Person, Map<String, dynamic>> {
  const PersonConverter(): super();
  @override
  Person fromJson(Map<String, dynamic> json) {
    return Person.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Person person) {
    return person.toJson();
  }
}


class UuidConverter extends JsonConverter<UniqueId, String> {
  const UuidConverter(): super();
  @override
  UniqueId fromJson(String json) {
    return UniqueId.fromUniqueString(json);
  }

  @override
  String toJson(UniqueId uuid) {
    return uuid.value;
  }
// TODO
}

class ColorConverter extends JsonConverter<Color, int> {
  const ColorConverter(): super();
  @override
  Color fromJson(int json) {
    // TODO: implement fromJson
    return Color(json);
  }

  @override
  int toJson(Color color) {
    return color.hashCode;
  }
  // TODO
}




class UniqueId {


  final String value;

  factory UniqueId.fromUniqueString(String uniqueId) {
    return UniqueId._(
      uniqueId,
    );
  }

  factory UniqueId() {
    return UniqueId._(
      const Uuid().v4(),
    );
  }

  const UniqueId._(this.value);
}
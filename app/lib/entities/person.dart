import 'package:json_annotation/json_annotation.dart';
part 'person.g.dart';


@JsonSerializable()
class Person{
  final String name;
  final String email;
  final String telephoneNumber;

  Person({required this.email, required this.telephoneNumber, required this.name}){}

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
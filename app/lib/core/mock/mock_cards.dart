import 'package:wyld_card/entities/card.dart';
import 'package:wyld_card/entities/person.dart';
import 'package:flutter/material.dart' hide Card;

List<Person> mock_persons = [
  Person(email: "email1", telephoneNumber: "12345678", name: "Hanz Heinrich"),
  Person(email: "email1", telephoneNumber: "12345678", name: "PerterPanmh"),
];


List<Buisiness_card> mock_cards = [
  Buisiness_card(person: mock_persons[0], color: Colors.black, mainCard: true),
  Buisiness_card(person: mock_persons[1], color: Colors.green, mainCard: false)
];
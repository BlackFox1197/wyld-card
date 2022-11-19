import 'package:flutter/material.dart';
import 'package:wyld_card/entities/card.dart';

class BusinessCard extends StatelessWidget {
  final Buisiness_card card;
  const BusinessCard({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = Color(0xFFFFFF - card.color.hashCode).withAlpha(0xFF);
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(width: 1, color: Colors.black)),
      child: Container(
        color: card.color,
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width *0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                card.person.name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: textColor),),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: ListTile(
                textColor: textColor,
                title: Text("Contact"),
                subtitle: Column(
                  children: [
                    _iconText(Icons.phone, card.person.telephoneNumber, textColor),
                    _iconText(Icons.alternate_email, card.person.email, textColor)
                  ],
                ),
              ),
            )
            // _padingListTile(Icons.phone, card.person.telephoneNumber, textColor),
            // _padingListTile(Icons.alternate_email, card.person.email, textColor),

          ],
        ),
      ),
    );
  }

  Widget _iconText(IconData icon, String text, Color color){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(icon, color: color,),
        Text(text,)
      ],);
  }
}

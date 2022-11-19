import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyld_card/entities/card.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/own_card_overview/cubit/own_card_overview_cubit.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/own_card_overview/cubit/own_card_overview_cubit.dart';
import 'package:wyld_card/shared/Card/businessCard.dart';

class BuisinessCardCard extends StatelessWidget {
  const BuisinessCardCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnCardOverviewCubit, OwnCardOverviewState>(
      builder: (context, state) {
        if((state.selectedIndex??-1) < 0){
          return Text("No Cards Yet");
        }

        Buisiness_card card = state.cards[state.selectedIndex!];
        return BusinessCard(card: card);
        },
    );
  }




  Widget _padingListTile(IconData icon, String text, Color color){
    return Padding(
        padding: EdgeInsets.only(left: 30, right: 10),
        child: ListTile(
          leading: Icon(icon),
          title: Center(child: Text(text)),
          textColor: color,
          iconColor: color,));
  }
}

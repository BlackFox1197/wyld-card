import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyld_card/entities/card.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/own_card_overview/cubit/own_card_overview_cubit.dart';

class CardSelector extends StatelessWidget {
  const CardSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnCardOverviewCubit, OwnCardOverviewState>(
        builder: (context, state){
          return DropdownButtonFormField<Buisiness_card>(
            decoration:  const InputDecoration(border: OutlineInputBorder()),
            value: (state.selectedIndex??-1) >= 0 ?state.cards[state.selectedIndex??0] : null,
            isExpanded: true,
              items: _generateItems(state), onChanged: (Buisiness_card? card) =>
                context.read<OwnCardOverviewCubit>().changeCardShow(card));
        }
    );
  }


  List<DropdownMenuItem<Buisiness_card>> _generateItems(OwnCardOverviewState state){
    return state.cards.map<DropdownMenuItem<Buisiness_card>>(
            (e) => DropdownMenuItem<Buisiness_card>(
              value: e,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.person.name),
                    if(e.mainCard)
                      Icon(Icons.check_circle_outline)
                ],)
            )
    ).toList();
  }
}

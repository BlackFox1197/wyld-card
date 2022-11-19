import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/own_card_overview/cubit/own_card_overview_cubit.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/own_card_overview/widgets/card_selector.dart';
import 'package:wyld_card/shared/Card/buisiness_card_card.dart';

class OwnCardOverview extends StatelessWidget {
  const OwnCardOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OwnCardOverviewCubit(),
      child: BlocBuilder<OwnCardOverviewCubit, OwnCardOverviewState>(
        builder: (context, state){
          return state.status == OCOStatus.loaded  ? Column(
            children: [CardSelector(), BuisinessCardCard()],
          ) : CircularProgressIndicator();
        },
      ),
    );
  }
}

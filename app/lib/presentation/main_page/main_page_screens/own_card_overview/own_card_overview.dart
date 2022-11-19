import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyld_card/core/mock/mock_cards.dart';
import 'package:wyld_card/infrastructure/card_infra/card_repository.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/own_card_overview/Dialogs/AddCardDialog.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/own_card_overview/cubit/own_card_overview_cubit.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/own_card_overview/widgets/card_selector.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/own_card_overview/widgets/buisiness_card_card.dart';

class OwnCardOverview extends StatelessWidget {
  const OwnCardOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OwnCardOverviewCubit(),
      child: BlocBuilder<OwnCardOverviewCubit, OwnCardOverviewState>(
        builder: (context, state) {
          return state.status == OCOStatus.loaded ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: CardSelector(),
              ),
              Spacer(),
              Center(child: BuisinessCardCard()),
              Spacer(),
              Spacer(),
              MaterialButton(child: Text("Mock Card"), onPressed: () {
                _showAddDialog(context);
              })
            ],
          ) : CircularProgressIndicator();
        },
      ),
    );
  }


  _showAddDialog(BuildContext contextCubit) {
    showDialog(context: contextCubit, builder: (context) {
      return BlocProvider.value(
        value: BlocProvider.of<OwnCardOverviewCubit>(contextCubit),
       child: AlertDialog(content: AddCardDialog(),)
      );
    });
  }
}

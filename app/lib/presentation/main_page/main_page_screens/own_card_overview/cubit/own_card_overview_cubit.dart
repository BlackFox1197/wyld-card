import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:meta/meta.dart';
import 'package:wyld_card/core/mock/mock_cards.dart';
import 'package:wyld_card/entities/person.dart';

import '../../../../../entities/card.dart';

part 'own_card_overview_state.dart';
part 'own_card_overview_cubit.g.dart';


class OwnCardOverviewCubit extends Cubit<OwnCardOverviewState> {
  OwnCardOverviewCubit() : super(OwnCardOverviewState.initial()){getCards();}


  Future<void> getCards() async{
    emit(OwnCardOverviewState.loaded(mock_cards, mock_cards.indexWhere((element) => element.mainCard)));
  }


  void changeCardShow(Buisiness_card? card){
    if(card != null){
      emit(state.copyWith(selectedIndex: state.cards.indexOf(card)));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:meta/meta.dart';
import 'package:wyld_card/core/mock/mock_cards.dart';
import 'package:wyld_card/entities/person.dart';
import 'package:wyld_card/infrastructure/card_infra/card_repository.dart';

import '../../../../../entities/card.dart';

part 'own_card_overview_state.dart';
part 'own_card_overview_cubit.g.dart';


class OwnCardOverviewCubit extends Cubit<OwnCardOverviewState> {
  final CardRepository repo = CardRepository();
  OwnCardOverviewCubit() : super(OwnCardOverviewState.initial()){getCards();}


  Future<void> getCards() async{

    List<Buisiness_card> cards = await repo.getOwnCards();
    int index = cards.indexWhere((element) => element.mainCard);

    emit(OwnCardOverviewState.loaded(cards, cards.length > 0 && index < 0 ? 0 : index));
  }


  void changeCardShow(Buisiness_card? card){
    if(card != null){
      emit(state.copyWith(selectedIndex: state.cards.indexOf(card)));
    }
  }

  void addCard(Buisiness_card card){
    emit(state.copyWith(status: OCOStatus.saving));
    repo.saveNewCard(card).then((value) => getCards());
  }


  void changeMainCard(){
    Buisiness_card card;
    if((state.selectedIndex??-1) >= 0){
       card = state.cards[state.selectedIndex!];
    }else{
      return;
    }

    repo.changeMainCard(card).then((value) => getCards());
  }

  void deleteCard(){
    Buisiness_card card;
    if((state.selectedIndex??-1) >= 0){
       card = state.cards[state.selectedIndex!];
    }else{
      return;
    }

    repo.deleteCard(card).then((value) => getCards());
  }
}

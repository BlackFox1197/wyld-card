part of 'own_card_overview_cubit.dart';


enum OCOStatus {loading, loaded}
class OwnCardOverviewState {
  final OCOStatus status;
  final List<Card> cards;


  const OwnCardOverviewState({required this.status, this.cards = const []});

  factory OwnCardOverviewState.initial() => OwnCardOverviewState(status: OCOStatus.loading);
  factory OwnCardOverviewState.loaded(List<Card> cards) => OwnCardOverviewState(status: OCOStatus.loaded, cards: cards);

}


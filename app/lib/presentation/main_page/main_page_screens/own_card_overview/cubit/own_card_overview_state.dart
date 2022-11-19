part of 'own_card_overview_cubit.dart';


enum OCOStatus {loading, loaded}
@CopyWith()
class OwnCardOverviewState {
  final OCOStatus status;
  final List<Buisiness_card> cards;
  final int? selectedIndex;


  const OwnCardOverviewState({required this.status, this.cards = const [], this.selectedIndex});

  factory OwnCardOverviewState.initial() => OwnCardOverviewState(status: OCOStatus.loading);
  factory OwnCardOverviewState.loaded(List<Buisiness_card> cards, int selectedIndex)=>
      OwnCardOverviewState(status: OCOStatus.loaded, cards: cards, selectedIndex: selectedIndex);

}


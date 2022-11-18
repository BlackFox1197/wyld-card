import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wyld_card/entities/person.dart';

import '../../../../../entities/card.dart';

part 'own_card_overview_state.dart';

class OwnCardOverviewCubit extends Cubit<OwnCardOverviewState> {
  OwnCardOverviewCubit() : super(OwnCardOverviewState.initial());


  Future<void> getCards() async{
    emit(OwnCardOverviewState.loaded())
  }
}

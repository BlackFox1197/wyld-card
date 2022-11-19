import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'saved_cards_state.dart';

class SavedCardsCubit extends Cubit<SavedCardsState> {
  SavedCardsCubit() : super(SavedCardsInitial());
}

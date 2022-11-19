import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wyld_card/infrastructure/card_infra/card_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {

  final CardRepository repo = CardRepository();

  SettingsCubit() : super(SettingsState.initial());

  Future<void> clearStorage() async{
    repo.cleatStorage();
  }

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyld_card/core/Cubits/settings_cubit/settings_cubit.dart';
import 'package:wyld_card/shared/gen_dialog.dart';

class SettingsIndex extends StatelessWidget {
  const SettingsIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Container(
          child: Column(children: [
              MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Icon(Icons.delete),
                    Text("Delete EVERYTHING")
                  ],),
                  onPressed: (){
                    GenDialog.genericDialog(context, "Delete ALL???", "You are about to delete everything")
                        .then((value) => value ? context.read<SettingsCubit>().clearStorage() : null);
                  }
                  ),
          ],
          ),
        );
      },
    );
  }




}

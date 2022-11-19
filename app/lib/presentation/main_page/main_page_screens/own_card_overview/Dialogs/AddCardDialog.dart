import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyld_card/entities/card.dart';
import 'package:wyld_card/entities/person.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/own_card_overview/cubit/own_card_overview_cubit.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/own_card_overview/cubit/own_card_overview_cubit.dart';
import 'package:wyld_card/shared/animations/animated_check.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddCardDialog extends StatefulWidget {
  const AddCardDialog({Key? key}) : super(key: key);

  @override
  State<AddCardDialog> createState() => _AddCardDialogState();
}

class _AddCardDialogState extends State<AddCardDialog> {
  TextEditingController controller_cn = TextEditingController();
  TextEditingController controller_pn = TextEditingController();
  TextEditingController controller_pt = TextEditingController();
  TextEditingController controller_pe = TextEditingController();
  bool isMain = false;
  Color currentColor = Colors.black26;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OwnCardOverviewCubit, OwnCardOverviewState>(
      listenWhen: (previous, current) => previous.status == OCOStatus.saving && current.status != OCOStatus.saving,
      listener: (context, state) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfull"),));

      },
      builder: (context, state) {
        if(state.status != OCOStatus.saving){

          return Container(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _TextFormField(controller_cn, "Card Name"),
                        const SizedBox(height: 20),
                        _TextFormField(controller_pn, "Person Name"),
                        const SizedBox(height: 20),
                        _TextFormField(controller_pt, "Person Telephone"),
                        const SizedBox(height: 20),
                        _TextFormField(controller_pe, "Person Email"),
                        const SizedBox(height: 20),

                        MaterialButton(onPressed: (){CP(context);}, child: SizedBox(height: 40, child: Container(color: currentColor,),),),
                        Row(
                          children: [
                            Checkbox(value: isMain, onChanged: (value) {
                              this.isMain = value ?? false;
                              setState(() {

                              });
                            }),
                            Text("Should this be set as main?")
                          ],
                        )
                      ],),
                    MaterialButton(onPressed: () {
                      if(_formKey.currentState!.validate()){
                        context.read<OwnCardOverviewCubit>().addCard(_makeCard());
                      }
                    }, child: Text("Submit"),)
                  ],
                ),
              ),
            ),
          );
        }
        else{
          if(state.status == OCOStatus.saving){
            return CircularProgressIndicator();
          }
          else {
            return AnimatedCheck();
          }
        }
      },
    );
  }

  void CP(BuildContext context){
    showDialog(context: context, builder: (context){
      return AlertDialog(content:
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColorPicker(pickerColor: currentColor, onColorChanged: (Color color) => setState(() {
                currentColor = color;},)),
          MaterialButton(onPressed: (){
            Navigator.pop(context);
          },
            child: Text("Select this color",),
          )
        ],
      ),);
    });
  }


  Buisiness_card _makeCard(){
    return Buisiness_card(
      person: Person(email: controller_pe.value.text, telephoneNumber: controller_pt.value.text, name: controller_pn.value.text),
      cardName: controller_cn.value.text,
      mainCard: this.isMain,
      color: currentColor


    );
  }

  _TextFormField(TextEditingController controller, String name) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: name,
        border: const OutlineInputBorder(),
        labelText: name,
      ),
      controller: controller,
      validator: (content) =>
      ((content == null) || content == "")
          ? "musn't be empty"
          : null,
    );
  }
}

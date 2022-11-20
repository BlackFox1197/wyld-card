import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyld_card/presentation/main_page/main_page_screens/settings/bluetooth/bluetooth_cubit/bluetooth_cubit.dart';
import 'package:wyld_card/shared/animations/circle_beating.dart';

class BluetoothIndex extends StatelessWidget {
  const BluetoothIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => BluetoothCubit(),
      child: BlocBuilder<BluetoothCubit, BluetoothState>(
        builder: (context, state){
          return SizedBox(
            height: MediaQuery.of(context).size.height/2,
            child: Column(
              children: [
                MaterialButton(onPressed: ()=>context.read<BluetoothCubit>().scanForDevices(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Start Scanning"),
                      if(state.status == BStatus.scanning)
                        CircleBeating(color: Colors.black, size: 15)
                    ],
                  ),),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.devices.length,
                      itemBuilder: (context, index){
                        return InkWell(
                          onDoubleTap: () => context.read<BluetoothCubit>().connectToDevice(state.devices[index]),
                          child: ListTile(title: Text(state.devices[index].name),),
                        );
                      }),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.connectedDevices.length,
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: () => context.read<BluetoothCubit>().scanServices(state.devices[index]),
                          onDoubleTap: () => context.read<BluetoothCubit>().disconnect(state.devices[index]),
                          child: ListTile(title: Text(state.connectedDevices[index].name,), textColor: Colors.cyanAccent,
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:firebaseapp/screens/cloud_notification/cloudnotification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CloudNotificationScreens extends StatelessWidget {
  const CloudNotificationScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CloudNotificationCubit()..mobileToken(),
        child: BlocBuilder<CloudNotificationCubit, CloudNotificationState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text(state.opToken,style: TextStyle(fontSize: 30.0,
                    color: Colors.red.shade400),)),
                ElevatedButton(onPressed: () {
                  context.read<CloudNotificationCubit>().hotelOne();
                }, child: const Text("hotelOne")),
                const SizedBox(height: 10.0,),
                ElevatedButton(onPressed: () {
                  context.read<CloudNotificationCubit>().hotelTwo();
                }, child: const Text("hotelTwo"))
              ],
            );
          },
        ),
      ),
    );
  }
}

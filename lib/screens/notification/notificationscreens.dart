import 'package:firebaseapp/screens/notification/notification__cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'notificationservice.dart';

class NotificationScreens extends StatefulWidget {
  const NotificationScreens({Key? key}) : super(key: key);

  @override
  State<NotificationScreens> createState() => _NotificationScreensState();
}

class _NotificationScreensState extends State<NotificationScreens> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        create: (context) => NotificationCubit()
          ..initializeTimeZones(),
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Title"),
                    TextFormField(
                        decoration: const InputDecoration(border: OutlineInputBorder()),
                        controller: state.titleController),
                    const SizedBox(height: 20.0),
                    const Text("Description"),
                    TextFormField(
                        decoration: const InputDecoration(border: OutlineInputBorder()),
                        controller: state.descriptionController),
                    const SizedBox(height: 20.0),
                    const Text("Time"),
                    TextFormField(
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: IconButton(
                              onPressed: () {
                                context.read<NotificationCubit>().selectDate(context);
                              },
                              icon: const Icon(Icons.timer))),
                      controller: state.timeInput,
                      onTap: () {
                        context.read<NotificationCubit>().selectDate(context);
                      },
                      readOnly: true,
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                        onPressed: () async{
                          print("++++${state.timeInput.text}");
                            NotificationServiceData().scheduleNotification(
                                title: state.titleController.text,
                                body: state.descriptionController.text,
                                scheduledNotificationDateTime: state.timeInput.text);
                            Fluttertoast.showToast(
                                msg: "Done notification",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );


                        },
                        child: const Text("Done"))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

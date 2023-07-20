import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
part 'notification__state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
      : super(NotificationState(
            descriptionController: TextEditingController(),
            titleController: TextEditingController(),
            timeInput: TextEditingController()));


  Future<void> selectDate(BuildContext context) async {
    DateTime dateTime = DateTime.now();
    await showDatePicker(
            context: context,
            initialDate: dateTime,
            initialDatePickerMode: DatePickerMode.day,
            firstDate: dateTime,
            lastDate: DateTime(2101))
        .then((value) async {
          if (value != null) {
            await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((pickedTime) {
          if (pickedTime != null) {
            DateTime selectedDateTime = DateTime(
              value.year,
              value.month,
              value.day,pickedTime.hour,
              pickedTime.minute,
              value.second,
            );
            String formattedDate = DateFormat('dd-MM-yyyy hh:mm:ss a').format(selectedDateTime);
            print(formattedDate);
            state.timeInput.text = formattedDate;
          } else {
            print("error");
          }
        });
      }
    });
  }

  initializeTimeZones() async {
    try {
      tz.initializeTimeZones();
      final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      print("error");
      print(e.toString());
    }
  }
}

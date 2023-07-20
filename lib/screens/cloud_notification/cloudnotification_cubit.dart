import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cloudnotification_state.dart';

class CloudNotificationCubit extends Cubit<CloudNotificationState> {
  CloudNotificationCubit() : super(CloudNotificationState(opToken: "",));

  void mobileToken() async{
    await FirebaseMessaging.instance.getToken().then((token) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", token.toString());
      emit(state.copyWith(opToken:token.toString()));
    });

  }


  Future<void> hotelOne() async {
    await FirebaseMessaging.instance.subscribeToTopic('hotelOne').then((value) {
      print("subscribed hotelOne");
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        await AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 1,
                channelKey: 'normal',
                title: message.notification?.title,
                body: message.notification?.body));
      });
    });
    await FirebaseMessaging.instance.unsubscribeFromTopic('hotelOne');

  }

  Future<void> hotelTwo() async {
    await FirebaseMessaging.instance.subscribeToTopic('hotelTwo').then((value) => print("subscribed hotelTwo"));
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 1,
              channelKey: 'normal',
              title: message.notification?.title,
              body: message.notification?.body));
    });
  }
}

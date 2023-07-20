import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaseapp/screens/auth/splashscreens.dart';
import 'package:firebaseapp/screens/localization/language_cubit.dart';
import 'package:firebaseapp/screens/notification/notificationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationServiceData().initNotification();

  await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'normal',
            channelName: 'Normal',
            channelDescription: 'Notification tests as alerts',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
            defaultColor: Colors.deepPurple,
            ledColor: Colors.deepPurple)
      ],
      debug: true);

  FirebaseMessaging.onMessage.listen(showFlutterNotification);



  runApp(const MyApp());
}
void showFlutterNotification(RemoteMessage message) async{
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    var title = notification.title.toString();
    var body = notification.body.toString();
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 2,
            channelKey: 'normal',
            title: title,
            body: body));
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => LanguageCubit(),
  child: BlocBuilder<LanguageCubit, LanguageState>(
  builder: (context, state) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("en", "US"),
          Locale("fr", "FR"),
          Locale("ar", "SA"),
        ],locale: state.locale,
        onGenerateTitle: (BuildContext context) =>
        S.of(context).homePageMainFormTitle,

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreens()
    );
  },
),
);
  }
}



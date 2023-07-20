import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebaseapp/screens/auth/ragistar/ragistar_cubit.dart';
import 'package:firebaseapp/screens/location/locationscreens.dart';
import 'package:firebaseapp/screens/profilescreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cloud_notification/cloudnotificationscreens.dart';
import '../forminsert/forminsertscreens.dart';
import '../formview/formviewscreens.dart';
import '../localization/languagescreens.dart';
import '../notification/notificationscreens.dart';
import '../search/serchscreens.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final List _widgetOptions = [
    const FormViewScreens(),
    FormInsertScreens(),
    const LocationScreens(),
    const SearchScreens(),
    const ProfileScreens(),
     const NotificationScreens(),
    const CloudNotificationScreens(),
     const LanguageScreens()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RagistarCubit(),
      child: BlocBuilder<RagistarCubit, RagistarState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Home"),
              iconTheme: const IconThemeData(
                color: Colors.red,
              ),
              actions:  [
                TextButton(
                  onPressed: () {
                    context.read<RagistarCubit>().logout(context);
                  },
                  child: const Text('Log out',style: TextStyle(fontSize: 17.0,color: Colors.red),),
                ),
              ],
            ),
            drawer: const Drawer(),
            body: _widgetOptions.elementAt(state.selectedIndex),
            bottomNavigationBar: CustomNavigationBar(
              iconSize: 30.0,
              selectedColor: Colors.white,
              strokeColor: const Color(0x30040307),
              unSelectedColor: const Color(0xffFDB1C0),
              backgroundColor: const Color(0xffFA5075),
              items: [
                CustomNavigationBarItem(
                  icon: const Icon(Icons.home),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(
                    Icons.event_note,
                  ),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(
                    Icons.location_on,
                  ),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(Icons.search),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(Icons.account_circle),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(Icons.notification_add),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(Icons.notifications_active),
                ),
                CustomNavigationBarItem(
                  icon: const Icon(Icons.language),
                ),
              ],
              currentIndex: state.selectedIndex,
              onTap: (index) {

                try{
                  BlocProvider.of<RagistarCubit>(context).onItemTapped(index);
                }catch(e){
                  print("error");
                  print(e.toString());
                }

              },
            ),
          );
        },
      ),
    );
  }
}

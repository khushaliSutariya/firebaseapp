import 'package:firebaseapp/screens/auth/ragistar/ragistar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreens extends StatelessWidget {
  const SplashScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffFA5075),
      body: BlocProvider(
        create: (context) => RagistarCubit()..resetNewLaunch(context),
        child: BlocBuilder<RagistarCubit, RagistarState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Column(
                  children: [
                    const Text(
                      "Game Time",
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontFamily: "Poppins"),
                    ),
                    Image.asset(
                      "assets/img/chat.png",
                      width: size.width * 0.25,
                      height: size.height * 0.15,
                      color: Colors.white,
                    ),
                  ],
                )),
              ],
            );
          },
        ),
      ),
    );
  }
}

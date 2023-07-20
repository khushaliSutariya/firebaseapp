import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/screens/auth/ragistar/ragistarscreens.dart';
import 'package:firebaseapp/screens/home/HomeScreens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../loginscreens.dart';

part 'ragistar_state.dart';

class RagistarCubit extends Cubit<RagistarState> {
  RagistarCubit()
      : super(RagistarState(
            email: TextEditingController(),
            confirmPassword: TextEditingController(),
            fullName: TextEditingController(),
            lastName: TextEditingController(),
            password: TextEditingController(),
            phone: TextEditingController(),
            formKey: GlobalKey<FormState>(),
            selectedIndex: 0));

  void onItemTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void resetNewLaunch(BuildContext context) async {
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences prefs =
      await SharedPreferences.getInstance();
      bool? isLoggedIn = prefs.getBool("isLogin");
      if(isLoggedIn != null && isLoggedIn) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreens()));
      }
      else
      {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) =>  const LoginScreens()));
      }
    });
  }

  void signup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
      UserCredential result = await state.auth.signInWithCredential(authCredential);
      User? user = result.user;
      var name = user!.displayName.toString();
      var email = user.email.toString();
      var photo = user.photoURL.toString();
      var googleId = user.uid.toString();
      var fullName = name.split(" ");
      SharedPreferences prefs =
      await SharedPreferences.getInstance();
      await FirebaseFirestore.instance.collection("users").add({
              "fullName": fullName[0],
              "lastName": fullName[1],
              "phone": "",
              "email": email,
              "photo": photo,
              "googleId": googleId,
              "password": "",
              "confirmPassword": ""
            }).then((value) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomeScreens(),
              ));
            });
          }
  }

  void ragistar(BuildContext context) async {
    if(state.formKey.currentState?.validate()  ?? false){
      try {
        await FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: state.email.text)
            .get()
            .then((document) async {
          if (document.size <= 0) {
            await FirebaseFirestore.instance.collection("users").add({
              "fullName": state.fullName.text,
              "lastName": state.lastName.text,
              "phone": state.phone.text,
              "email": state.email.text,
              "photo": "",
              "googleId": "",
              "password": state.password.text,
              "confirmPassword": state.confirmPassword.text,
            }).then((document) async {
              if (state.email.text.isNotEmpty || state.password.text.isNotEmpty) {
                await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(email: state.email.text, password: state.password.text)
                    .then((value) async {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreens(),
                  ));
                });
              }
            });
          } else {
            Fluttertoast.showToast(
                msg: "This email already exist",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        });
      } catch (e) {
        print("error$e");
      }
    }

    }


  void login(BuildContext context) async {
    if (state.formKey.currentState?.validate() ?? false) {
      try {
        if (state.email.text.isNotEmpty || state.password.text.isNotEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("isLogin", true);
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: state.email.text, password: state.password.text)
              .then((value) async {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HomeScreens(),
            ));

          });
        } else {
         print("errors");
        }
      } catch (err) {
        Fluttertoast.showToast(
            msg: "Please valid email - password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLogin');
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginScreens(),
    ));
  }
}

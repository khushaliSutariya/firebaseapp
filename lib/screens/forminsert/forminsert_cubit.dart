import 'dart:convert';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:firebaseapp/model/formmodel.dart';
import 'package:firebaseapp/screens/home/HomeScreens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/hobbymodellist.dart';

part 'forminsert_state.dart';

class FormInsertCubit extends Cubit<FormInsertState> {
  final BuildContext? context;

  FormInsertCubit({this.context})
      : super(FormInsertState(
          name: TextEditingController(),
          birthDate: TextEditingController(),
          phone: TextEditingController(),
          pinCode: TextEditingController(),
          email: TextEditingController(),
          country: "",
          state: "",
          selectedDate: DateTime.now(),
          selectedHobbys: const [],
          gender: "M",
          hobby: [
            HobbyModelList(value: false, text: "Drawing"),
            HobbyModelList(value: false, text: "Singing"),
            HobbyModelList(value: false, text: "Writting"),
            HobbyModelList(value: false, text: "Reading"),
          ],
          city: "",
        ));

  void handleGender(value) {
    emit(state.copyWith(gender: value));
  }

  void handleCity(value) => emit(state.copyWith(city: value));

  void handleCountry(value) => emit(state.copyWith(country: value));

  void handleState(value) => emit(state.copyWith(state: value));

  void handleHobby(int index, bool? newValue, List list) {
    List<HobbyModelList>? data = List.from(list)..[index].value = newValue!;
    List<HobbyModelList>? tempdata = data.where((element) => element.value == true).toList();
    emit(
      state.copyWith(
        selectedHobbys: tempdata,
      ),
    );
  }


  void birthDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
    if (pickedDate != null) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        state.birthDate.text = formattedDate;
      print("stateDate${state.birthDate.text}");
    } else {
      print("Date is not selected");
    }
  }

  void insertFormData(BuildContext context) async {
    final docUser = FirebaseFirestore.instance.collection("form").doc();
    String hobby = state.selectedHobbys.where((element) => element.value == true).map((e) => e.text).join(",");
    final user = FormModel(
      id: docUser.id,
      name: state.name.text,
      phone: state.phone.text,
      birthdate: state.birthDate.text,
      email: state.email.text,
      gender: state.gender,
      hobby: hobby,
      address: Address(city: state.city, country: state.country, state: state.state, zipcode: state.pinCode.text),
    );
    final json = user.toJson();
    await docUser.set(json).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HomeScreens(),
      ));
    });
  }

  void deleteFormData(BuildContext context, String id) async {
    FirebaseFirestore.instance.collection("form").doc(id).delete().then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HomeScreens(),
      ));
    });
  }

  void getSingleData(String? id) async {
    if (id != null) {
      await FirebaseFirestore.instance.collection("form").doc(id).get().then((document) async {
        DateTime myDateTime = DateTime.parse(document["birthdate"].toString());
        String formattedDateTime = DateFormat('yyyy-MM-dd').format(myDateTime);
        state.name.text = document["name"].toString();
        state.phone.text = document["phone"].toString();
        state.email.text = document["email"].toString();
        state.pinCode.text = document["address"]["zipcode"].toString();
        state.birthDate.text = formattedDateTime;
        String hobby = document["hobby"];
        List<String> addHobby = hobby.split(",");
        List<HobbyModelList> tempList = state.hobby;
        for (var newValue in addHobby) {
          int index = tempList.indexWhere((element) => element.text == newValue);
          if (index != -1) {
            tempList[index] = tempList[index].copyWith(value: true);
          }
        }
        emit(state.copyWith(gender: document["gender"].toString(), selectedHobbys: tempList));
      });
    }
  }

  void updateFormData(BuildContext context, String id) async {
    var hobbyData =
        state.selectedHobbys.where((element) => element.value == true).map((e) => e.text).toList().join(",");
    await FirebaseFirestore.instance.collection("form").doc(id).update({
      "name": state.name.text,
      "phone": state.phone.text,
      "birthdate": state.birthDate.text,
      "email": state.email.text,
      "hobby": hobbyData,
      "address": {"country": state.country, "state": state.state, "city": state.city, "zipcode": state.pinCode.text},
      "gender": state.gender,
    }).then((value) {
      print("date${state.birthDate.text}");
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HomeScreens(),
      ));
    });
  }


}

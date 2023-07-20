import 'package:country_code_picker/country_code_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebaseapp/screens/widgets/mybuttons.dart';
import 'package:firebaseapp/screens/widgets/mytextbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forminsert_cubit.dart';

class FormInsertScreens extends StatefulWidget {
  String? updateId;
  FormInsertScreens({Key? key, this.updateId}) : super(key: key);

  @override
  State<FormInsertScreens> createState() => _FormInsertScreensState();
}

class _FormInsertScreensState extends State<FormInsertScreens> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        create: (context) => FormInsertCubit()..getSingleData(widget.updateId),
        child: BlocBuilder<FormInsertCubit, FormInsertState>(
          builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0, bottom: 20.0, top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 13.0),
                      child: Text("Fill your details",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              color: Color(0xffFC6281))),
                    ),
                    const Text("Name:",
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontFamily: "Poppins")),
                    MyTextBox(
                        hintText: "Your name",
                        onTap: () {},
                        controller: state.name,
                        validator: (value) {},
                        keyboardType: TextInputType.name),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text("Gender:",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontFamily: "Poppins")),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 15.0),
                          child: Radio(
                            value: "M",
                            visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity,),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            groupValue: state.gender,
                            fillColor: MaterialStateColor.resolveWith((states) => const Color(0xffFC6281)),
                            onChanged: (newValue) {
                              BlocProvider.of<FormInsertCubit>(context).handleGender(newValue);
                            },
                          ),
                        ),
                        const Text("male",
                            style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: "Poppins",
                                color: Color(0xffA8A8A8),
                                fontWeight: FontWeight.w600)),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 20.0,end: 15.0),
                          child: Radio(
                            value: "F",
                            visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity,),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            fillColor: MaterialStateColor.resolveWith((states) => const Color(0xffFC6281)),
                            groupValue: state.gender,
                            onChanged: (newValue) {
                              BlocProvider.of<FormInsertCubit>(context).handleGender(newValue);
                            },
                          ),
                        ),
                        const Text("female",
                            style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: "Poppins",
                                color: Color(0xffA8A8A8),
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text("Phone number:",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontFamily: "Poppins")),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: MyTextBox(
                              validator: (phone) {},
                              onTap: () {},
                              hintText: "+91",
                              prefix: const CountryCodePicker(
                                onChanged: print,
                                hideMainText: true,
                                showFlagMain: false,
                                showFlag: false,
                                initialSelection: 'in',
                                hideSearch: false,
                                showCountryOnly: true,
                                showOnlyCountryWhenClosed: true,
                                alignLeft: true,
                              ),
                              keyboardType: TextInputType.number),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          flex: 4,
                          child: MyTextBox(
                              validator: (phone) {},
                              hintText: "99999 99999",
                              onTap: () {},
                              controller: state.phone,
                              keyboardType: TextInputType.number),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 25.0, bottom: 8.0),
                      child: Text("Email:",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontFamily: "Poppins")),
                    ),
                    MyTextBox(
                        hintText: "Enter you email",
                        onTap: () {},
                        controller: state.email,
                        validator: (value) {},
                        keyboardType: TextInputType.emailAddress),
                    const Padding(
                      padding: EdgeInsets.only(top: 25.0, bottom: 8.0),
                      child: Text("Date of Birth:",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontFamily: "Poppins")),
                    ),
                    MyTextBox(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        context.read<FormInsertCubit>().birthDate(context);
                      },
                      validator: (value) {},
                      controller: state.birthDate,
                      hintText: "Select your date of birth",
                      suffixIcon: IconButton(
                          onPressed: () async {
                            context.read<FormInsertCubit>().birthDate(context);
                          },
                          icon: const Icon(
                            Icons.date_range,
                            color: Colors.black,
                            size: 25.0,
                          )),
                      keyboardType: TextInputType.datetime,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
                      child: Text("Select your hobbies:",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontFamily: "Poppins")),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.hobby.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(
                            state.hobby[index].text.toString(),
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12.0,
                                color: Color(0xffA8A8A8),
                                fontWeight: FontWeight.w600),
                          ),
                          value: state.hobby[index].value,
                          onChanged: (newValue) {
                            context.read<FormInsertCubit>().handleHobby(index, newValue, state.hobby);
                          },
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: Text("Address:",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontFamily: "Poppins")),
                    ),
                    CSCPicker(
                      layout: Layout.vertical,
                      flagState: CountryFlag.DISABLE,
                      cityDropdownLabel: "*city",
                      countryDropdownLabel: "*country",
                      stateDropdownLabel: "*state",
                      dropdownDialogRadius: 30.0,
                      searchBarRadius: 30.0,
                      dropdownHeadingStyle: const TextStyle(
                        color: Color(0xffA8A8A8),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      dropdownItemStyle: const TextStyle(
                        color: Color(0xffA8A8A8),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      selectedItemStyle: const TextStyle(
                        color: Color(0xffA8A8A8),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      dropdownDecoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(width: 2, color: Color(0xffFC6281)),
                        ),
                      ),
                      disabledDropdownDecoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(width: 2, color: Color(0xffFC6281)),
                        ),
                      ),
                      onCityChanged: (city) {
                        BlocProvider.of<FormInsertCubit>(context).handleCity(city);
                      },
                      onCountryChanged: (country) {
                        BlocProvider.of<FormInsertCubit>(context).handleCountry(country);
                      },
                      onStateChanged: (state) {
                        BlocProvider.of<FormInsertCubit>(context).handleState(state);
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text("Zip code:",
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontFamily: "Poppins")),
                    ),
                    MyTextBox(
                        onTap: () {},
                        hintText: "Postal/Zip code",
                        controller: state.pinCode,
                        validator: (value) {},
                        keyboardType: TextInputType.number),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: MyButtons(
                        width: size.width*double.infinity,
                          onPressed: () {
                            if (widget.updateId != null) {
                              context.read<FormInsertCubit>().updateFormData(context, widget.updateId.toString());
                              return;
                            }
                            context.read<FormInsertCubit>().insertFormData(context);
                          },
                          text: widget.updateId != null ? "Update" : "Submit"),
                    ),
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

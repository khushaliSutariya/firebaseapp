import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebaseapp/screens/auth/loginscreens.dart';
import 'package:firebaseapp/screens/widgets/mybuttons.dart';
import 'package:firebaseapp/screens/widgets/mypasswordtextbox.dart';
import 'package:firebaseapp/screens/widgets/mytextbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ragistar_cubit.dart';

class RagistarScreens extends StatefulWidget {
  const RagistarScreens({Key? key}) : super(key: key);

  @override
  State<RagistarScreens> createState() => _RagistarScreensState();
}

class _RagistarScreensState extends State<RagistarScreens> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: BlocProvider(
        create: (context) => RagistarCubit(),
        child: BlocBuilder<RagistarCubit, RagistarState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: state.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(child: Image.asset("assets/img/Image1.png")),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                              color: Color(0xffFA5075),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Text("Hi, kindly fill the form to proceed combat",
                            style: TextStyle(fontSize: 15.0, fontFamily: "Poppins")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyTextBox(
                                validator: (fullName) {
                                  if (fullName!.length <= 0) {
                                    return "Please enter your full name";
                                  } else {
                                    bool fullNameValid = RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(fullName);
                                    if (!fullNameValid) {
                                      return "Please enter your valid full name";
                                    }
                                  }
                                  return null;
                                },
                                hintText: "Full Name",
                                onTap: () {},
                                controller: state.fullName,
                                keyboardType: TextInputType.name),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: MyTextBox(
                                  validator: (lastName) {
                                    if (lastName!.length <= 0) {
                                      return "Please enter your full name";
                                    } else {
                                      bool lastNameValid = RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(lastName);
                                      if (!lastNameValid) {
                                        return "Please enter your valid full name";
                                      }
                                    }
                                    return null;
                                  },
                                  hintText: "Last Name",
                                  onTap: () {},
                                  controller: state.lastName,
                                  keyboardType: TextInputType.name),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: MyTextBox(
                                      validator: (phone) {},
                                      onTap: () {},
                                      prefix: const CountryCodePicker(
                                        onChanged: print,
                                        hideMainText: true,
                                        showFlagMain: true,
                                        showFlag: false,
                                        initialSelection: 'TF',
                                        hideSearch: true,
                                        showCountryOnly: true,
                                        showOnlyCountryWhenClosed: true,
                                        alignLeft: true,
                                      ),
                                      keyboardType: TextInputType.number),
                                ),
                                const SizedBox(width: 20.0),
                                Expanded(
                                  flex: 5,
                                  child: MyTextBox(
                                      validator: (phone) {
                                        if (phone!.length <= 0) {
                                          return "Please enter your mobile number";
                                        } else {
                                          bool phoneValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phone);
                                          if (!phoneValid) {
                                            return "Please enter your valid mobile number";
                                          }
                                        }
                                        return null;
                                      },
                                      hintText: "Phone",
                                      onTap: () {},
                                      controller: state.phone,
                                      keyboardType: TextInputType.number),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: MyTextBox(
                                  validator: (email) {
                                    if (email!.length <= 0) {
                                      return "Please enter your email";
                                    } else {
                                      bool emailValid = RegExp(
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                          .hasMatch(email);
                                      if (!emailValid) {
                                        return "Please enter your valid email";
                                      }
                                    }
                                    return null;
                                  },
                                  hintText: "Email",
                                  onTap: () {},
                                  controller: state.email,
                                  keyboardType: TextInputType.emailAddress),
                            ),
                            MyPasswordTextBox(
                              passhintText: "Password",
                              keyboardType: TextInputType.text,
                              passcontroller: state.password,
                              passvalidator: (password) {
                                if (password!.length <= 0) {
                                  return "Please enter  password";
                                } else {
                                  bool passwordValid = RegExp(
                                      r'^((?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%&*]{6,20})$') //0 to 9,A to Z,a to z, not equle to @#$%*&
                                      .hasMatch(password);
                                  if (!passwordValid) {
                                    return "Please enter valid password";
                                  }
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              child: MyPasswordTextBox(
                                passhintText: "Confirm Password",
                                keyboardType: TextInputType.text,
                                passcontroller: state.confirmPassword,
                                passvalidator: (confirmPassword) {
                                  if (confirmPassword.isEmpty) {
                                    return 'Please enter confirm password';
                                  }
                                  if (confirmPassword != state.password.text) {
                                    return 'Not Match';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25.0),
                              child: MyButtons(
                                width: MediaQuery.of(context).size.width * 0.5,
                                  onPressed: () {
                                    context.read<RagistarCubit>().ragistar(context);
                                  },
                                  text: "Create Account"),
                            ),
                            const Text(
                              "Connect With:",
                              style: TextStyle(
                                  color: Color(0xffFA5075),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins"),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => context.read<RagistarCubit>().signup(context),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.deepOrange,
                                    radius: 20.0,
                                    child: Image.asset(
                                      "assets/img/googleicon.png",
                                      height: 100.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 20.0,
                                    child: Image.asset("assets/img/call.png",
                                        height: size.height * 0.03, width: size.width * 0.03, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            const Text(
                              "Already have an account?",
                              style: TextStyle(fontSize: 15.0, fontFamily: "Poppins"),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginScreens(),
                                  ));
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Color(0xffFA5075),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

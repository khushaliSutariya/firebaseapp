import 'package:firebaseapp/screens/auth/ragistar/ragistar_cubit.dart';
import 'package:firebaseapp/screens/auth/ragistar/ragistarscreens.dart';
import 'package:firebaseapp/screens/widgets/mybuttons.dart';
import 'package:firebaseapp/screens/widgets/mytextbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/mypasswordtextbox.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({Key? key}) : super(key: key);

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
  create: (context) => RagistarCubit(),
  child: BlocBuilder<RagistarCubit, RagistarState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/img/Image.png"),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    child: Text(
                      "Welcome Back!",
                      style: TextStyle(
                          color: Color(0xffFA5075), fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("Hi, kindly login to continue battle",
                        style: TextStyle(fontSize: 15.0, fontFamily: "Poppins")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {},
                                child: const Text(
                                  "Forgat password?",
                                  style: TextStyle(fontSize: 15.0),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: MyButtons(
                            width: MediaQuery.of(context).size.width * 0.5,
                              onPressed: (){
                                context.read<RagistarCubit>().login(context);
                              } ,
                              text: "Let's Combat!"),
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
                              onTap: () {
                                context.read<RagistarCubit>().signup(context);
                              },
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
                          "Don't have an account?",
                          style: TextStyle(fontSize: 15.0, fontFamily: "Poppins"),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BlocProvider<RagistarCubit>(
                                    create: (context) => RagistarCubit(), child: const RagistarScreens()),
                              ));
                            },
                            child: const Text(
                              "Create Account",
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
          );
        },
      ),
),
    );
  }
}

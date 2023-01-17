import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_car/screens/login_screen.dart';
import 'package:tap_car/screens/nav_bar_screen.dart';
import 'package:tap_car/services/auth_methods.dart';
import 'package:tap_car/utils/utils.dart';
import 'package:tap_car/widgets/loading_indicator.dart';

import 'package:tap_car/widgets/primary_app_bar.dart';
import 'package:tap_car/widgets/primary_button.dart';
import 'package:tap_car/widgets/text_field_input.dart';

import 'package:tap_car/utils/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reenterPasswordController = TextEditingController();

  String usernameErrorMsg = "";
  String emailErrorMsg = "";
  String passwordErrorMsg = "";
  String reenterPasswordErrorMsg = "";


  void submitRegister() async {
    setState(() {
      isLoading = true;
      usernameErrorMsg = "";
      emailErrorMsg = "";
      passwordErrorMsg = "";
      reenterPasswordErrorMsg = "";
    });

    bool usernameFormatCorrected = false;
    bool emailFormatCorrected = false;
    bool passwordFormatCorrected = false;
    bool reenterPasswordFormatCorrected = false;

    if (usernameController.text == "") {
      setState(() {
        usernameErrorMsg = "The field cannot be empty.";
      });
    } else {
      usernameFormatCorrected = true;
    }

    if (emailController.text == "") {
      setState(() {
        emailErrorMsg = "The field cannot be empty.";
      });
    } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      setState(() {
        emailErrorMsg = "Incorrect email format.\nE.g. correct email: name@email.com.";
      });
    } else {
      emailFormatCorrected = true;
    }

    if (passwordController.text == "") {
      setState(() {
        passwordErrorMsg = "The field cannot be empty.";
      });
    } else if (passwordController.text.length < 6) {
      setState(() {
        passwordErrorMsg = "Please enter at least 6 or more characters.";
      });
    } else {
      passwordFormatCorrected = true;
    }

    if (reenterPasswordController.text == "") {
      setState(() {
        reenterPasswordErrorMsg = "The field cannot be empty.";
      });
    } else if (reenterPasswordController.text.length < 6) {
      setState(() {
        reenterPasswordErrorMsg = "Please enter at least 6 or more characters.";
      });
    } else if (passwordController.text != reenterPasswordController.text) {
      setState(() {
        reenterPasswordErrorMsg = "The password doesn't match the password entered above.";
      });
    } else {
      reenterPasswordFormatCorrected = true;
    }

    print(usernameFormatCorrected);
    print(emailFormatCorrected);
    print(passwordFormatCorrected);
    print(reenterPasswordFormatCorrected);

    if (usernameFormatCorrected && emailFormatCorrected
        && passwordFormatCorrected && reenterPasswordFormatCorrected) {
      print("object");
      String res = await AuthMethods().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,);

      // if string returned is success, user has been created
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        // navigate to the home screen
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const NavBarScreen()
            ),
                (route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
        // show the error
        showSnackBar(context, res);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator() : Scaffold(
      appBar: PrimaryAppBar(
          title: ""
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40,),
                Text(
                  "REGISTER",
                  style: TextStyle(
                    color: Color(0xFFF2AA4C),
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
                ),

                Divider(),

                const SizedBox(height: 20,),

                TextFieldInput(
                  textEditingController: usernameController,
                  hintText: "Username",
                  textInputType: TextInputType.text,
                  errorMsg: usernameErrorMsg,
                  iconData: Icons.person,
                ),

                const SizedBox(height: 20,),

                TextFieldInput(
                  textEditingController: emailController,
                  hintText: "Email",
                  textInputType: TextInputType.emailAddress,
                  iconData: Icons.email_outlined,
                  errorMsg: emailErrorMsg,),

                const SizedBox(height: 20,),

                TextFieldInput(
                  textEditingController: passwordController,
                  hintText: "Password",
                  isPass: true,
                  textInputType: TextInputType.text,
                  iconData: Icons.lock_open_sharp,
                  errorMsg: passwordErrorMsg,),

                const SizedBox(height: 20.0),
                // password textfield
                TextFieldInput(
                  textEditingController: reenterPasswordController,
                  hintText: "Re-enter Password",
                  isPass: true,
                  textInputType: TextInputType.text,
                  errorMsg: reenterPasswordErrorMsg,
                  iconData: Icons.lock_open_sharp,
                ),

                const SizedBox(height: 30,),

                PrimaryButton(
                  onPressed: submitRegister,
                  childText: "Register",
                ),

                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      ),
                      child: Text(
                        " Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_car/screens/login_screen.dart';

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

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String emailErrorMsg = "";
  String passwordErrorMsg = "";



  void submitLogin() async {

  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    ) : Scaffold(
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
                  "Register",
                  style: TextStyle(
                    color: Color(0xFFF2AA4C),
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
                ),

                Divider(),

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

                const SizedBox(height: 30,),

                PrimaryButton(
                  onPressed: submitLogin,
                  childText: "Login",
                ),

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
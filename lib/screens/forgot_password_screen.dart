import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_car/screens/login_screen.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
import 'package:tap_car/widgets/primary_button.dart';
import 'package:tap_car/widgets/text_field_input.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isLoading = false;
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final newPwdController = TextEditingController();
  final confirmNewPwdController = TextEditingController();
  String emailErrorMsg = "";
  String codeErrorMsg = "";
  String newPwdErrorMsg = "";
  String confirmNewPwdErrorMsg = "";
  int status = 1;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator() : Scaffold(
      appBar: PrimaryAppBar(
          title: "Forgot Password"
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100,),
              Image(
                height: 165,
                image: AssetImage(
                  "assets/forgot-password-pic.png"
                ),
              ),
              const SizedBox(height: 40,),
              status == 1 ?
              Column(
                children: [
                  Text("Please enter your email address,"),
                  Text("A verification code will be sent to your email."),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFieldInput(
                      textEditingController: emailController,
                      hintText: "Email",
                      textInputType: TextInputType.emailAddress,
                      errorMsg: emailErrorMsg,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: PrimaryButton(
                        onPressed: () => setState(() {
                          status = 2;
                        }),
                        childText: "Submit",
                      )
                  ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Text(
                      "Return to login page",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                      ),
                    ),
                  ),
                ],
              ) :
              status == 2 ?
              Column(
                children: [
                  Text("Code has been sent to your email address."),
                  Text("Please enter the code from email."),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFieldInput(
                      textEditingController: codeController,
                      hintText: "Code",
                      textInputType: TextInputType.text,
                      errorMsg: codeErrorMsg,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: PrimaryButton(
                        onPressed: () => setState(() {
                          status = 3;
                        }),
                        childText: "Submit",
                      )
                  ),
                ],
              ) :
              Column(
                children: [
                  Text("Please create a new password."),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFieldInput(
                      textEditingController: newPwdController,
                      hintText: "New Password",
                      isPass: true,
                      textInputType: TextInputType.text,
                      errorMsg: newPwdErrorMsg,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFieldInput(
                      textEditingController: confirmNewPwdController,
                      hintText: "Confirm New Password",
                      textInputType: TextInputType.text,
                      isPass: true,
                      errorMsg: confirmNewPwdErrorMsg,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: PrimaryButton(
                        onPressed: () => setState(() {
                          status = 1;
                        }),
                        childText: "Submit",
                      )
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

}
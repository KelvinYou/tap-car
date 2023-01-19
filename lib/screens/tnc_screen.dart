import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
// import 'package:tap_car/widget/app_bar/secondary_app_bar.dart';

class TncScreen extends StatefulWidget {
  const TncScreen({super.key});

  @override
  State<TncScreen> createState() => _TncScreenState();
}

class _TncScreenState extends State<TncScreen> {
  bool isLoading = false;

  Widget titleText(String content) {
    return Text(
      content,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  Widget contentText(String content) {
    return Text(
      content,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator() : Scaffold(
      appBar: PrimaryAppBar(
          title: "Terms & Conditions"
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                titleText("Important"),
                contentText("Please read these General Terms and Conditions (“Terms”) carefully. By using the Services (as defined below), you agree that you have read, understood, accepted and agreed with these Terms. You further agree that the representations below are true and accurate. If you do not agree to any of the terms and conditions stated herein and wish to discontinue using the Services, please do not continue using the Application (as defined below) and/or the Services."),

                const SizedBox(height: 20,),
                titleText("Prohibition of Use of Vehicle"),
                contentText("Vehicles shall not be used for the purposes below:"),
                contentText("1. for any illegal or unlawful purposes;"),
                contentText("2. for any morally-objectionable purposes;"),
                contentText("3. in contravention with these Terms;"),
                contentText("4. in a manner which will cause damage to the Vehicle;"),
                contentText("5. to be driven to a place outside of Malaysia;"),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
// import 'package:tap_car/widget/app_bar/secondary_app_bar.dart';

class UserCarScreen extends StatefulWidget {
  const UserCarScreen({super.key});

  @override
  State<UserCarScreen> createState() => _UserCarScreenState();
}

class _UserCarScreenState extends State<UserCarScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator() : Scaffold(
      // appBar: SecondaryAppBar(
      //     title: "Coming Soon"
      // ),
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
              Text("Home"),
            ],
          ),
        ),
      ),
    );
  }

}
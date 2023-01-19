import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
// import 'package:tap_car/widget/app_bar/secondary_app_bar.dart';

class ChangeProfileScreen extends StatefulWidget {
  const ChangeProfileScreen({super.key});

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator() : Scaffold(
      appBar: PrimaryAppBar(
          title: "Change Profile"
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
              Text("Login"),
            ],
          ),
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
// import 'package:tap_car/widget/app_bar/secondary_app_bar.dart';

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({super.key});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator() : Scaffold(
      appBar: PrimaryAppBar(
          title: "Car Detail"
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
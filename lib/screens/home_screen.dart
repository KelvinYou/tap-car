import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
// import 'package:tap_car/widget/app_bar/secondary_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  Widget titleText(String content) {
    return Text(
      content,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget subtitleText(String content) {
    return Text(
      content,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator() : Scaffold(
      appBar: PrimaryAppBar(
          title: "TapCar"
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Container(
          padding: EdgeInsets.only(left: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),

                titleText("Choose your car"),

                const SizedBox(height: 10,),

                subtitleText("Car brand"),

                const SizedBox(height: 10,),



                const SizedBox(height: 10,),

                subtitleText("Most rented"),

                const SizedBox(height: 10,),


              ],
            ),
          ),
        ),
      ),
    );
  }

}
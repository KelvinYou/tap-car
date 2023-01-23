import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  bool isLoading = false;
  bool helpDropDown = false, rateUsDropDown = false;
  double rtg = 0;

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

  Widget dropDownControl(String title, VoidCallback onTap, bool isTrue) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            isTrue
                ? Icon(Icons.keyboard_arrow_up)
                : Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator()
        : Scaffold(
            appBar: PrimaryAppBar(title: "More"),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      dropDownControl("Help", () {
                        setState(() {
                          helpDropDown = !helpDropDown;
                        });
                      }, helpDropDown),
                      Divider(),
                      helpDropDown
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titleText("Frequently Asked Questions (FAQ)"),
                                const SizedBox(
                                  height: 20,
                                ),
                                titleText("How do I change my address?"),
                                contentText(
                                    "To change your address through the App, follow these steps:"),
                                contentText(
                                    "1. Account > View and edit profile"),
                                contentText("2. Click on ‘Edit’ address"),
                                contentText("3. Input new address"),
                                const SizedBox(
                                  height: 20,
                                ),
                                titleText("How do I change my password?"),
                                contentText(
                                    "To change your password through the App, follow these steps:"),
                                contentText(
                                    "1. Account > View and edit profile"),
                                contentText("2. Click on ‘Edit’ password"),
                                contentText(
                                    "3. Input current password, new password and retype password to confirm."),
                                contentText("4. Reset password"),
                                const SizedBox(
                                  height: 20,
                                ),
                                titleText(
                                    "How do I pay for TapCar’s services?"),
                                contentText(
                                    "You can pay for TapCar’s services directly to the renter by cash only."),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            )
                          : const SizedBox(),
                      dropDownControl("Rate Us", () {
                        setState(() {
                          rateUsDropDown = !rateUsDropDown;
                        });
                      }, rateUsDropDown),
                      Divider(),
                      rateUsDropDown
                          ? RatingBar.builder(
                              initialRating: rtg,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 24.0,
                              direction: Axis.horizontal,
                              onRatingUpdate: (rating) {
                                setState(() {
                                  rtg = rating;
                                });
                              },
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Country"),
                          Text("Malaysia"),
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

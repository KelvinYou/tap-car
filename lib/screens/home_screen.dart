import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/widgets/car_card.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';

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

  List<String> documents = ["he", "ha"];

  List<String> carBrands = [
    "assets/honda-logo.png",
    "assets/perodua-logo.png",
    "assets/proton-logo.png",
    "assets/bmw-logo.png",
    "assets/ford-logo.png",
    "assets/rollsroyce-logo.png",
    "assets/toyota-logo.png"
  ];

  List<DocumentSnapshot> carDocuments = [];

  CollectionReference carCollection =
      FirebaseFirestore.instance.collection('cars');

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator()
        : Scaffold(
            // appBar: PrimaryAppBar(
            //     title: "TapCar"
            // ),
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
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        "assets/logo.png",
                        height: 36,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      titleText("Choose your car"),
                      const SizedBox(
                        height: 20,
                      ),
                      subtitleText("Car Brands"),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: carBrands.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F8FF),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image(
                                width: 50,
                                height: 50,
                                image: AssetImage(carBrands[index]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      subtitleText("Cars Available to Rent"),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 400,
                        child: StreamBuilder(
                          stream: carCollection
                              .orderBy('createdDate', descending: false)
                              .snapshots(),
                          builder: (context, streamSnapshot) {
                            if (streamSnapshot.hasData) {
                              carDocuments = streamSnapshot.data!.docs;
                            }
                            return ListView.builder(
                              itemCount: carDocuments.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) => Container(
                                padding: EdgeInsets.only(right: 25),
                                child: CarCard(
                                  snap: carDocuments[index].data(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

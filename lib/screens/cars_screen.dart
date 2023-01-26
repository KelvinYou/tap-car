import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tap_car/widgets/second_car_card.dart';
import 'package:tap_car/widgets/text_field_input.dart';
// import 'package:tap_car/widget/app_bar/secondary_app_bar.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  bool isLoading = false;

  List<DocumentSnapshot> carDocuments = [];
  CollectionReference carCollection =
      FirebaseFirestore.instance.collection('cars');

  TextEditingController searchController = TextEditingController();
  String searchText = '';
  bool isDescending = true;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator()
        : Scaffold(
            appBar: PrimaryAppBar(title: "Car List"),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFieldInput(
                            textEditingController: searchController,
                            hintText: "Search",
                            onChanged: (value) {
                              setState(() {
                                searchText = value;
                              });
                            },
                            textInputType: TextInputType.text,
                            iconData: Icons.search_outlined,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => setState(() {
                              isDescending = !isDescending;
                            }),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                    height: 5,
                                  ),
                                  Icon(
                                    isDescending
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: carCollection
                            .orderBy('pricePerDay', descending: isDescending)
                            .snapshots(),
                        builder: (context, streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            carDocuments = streamSnapshot.data!.docs;

                            if (searchText.isNotEmpty) {
                              carDocuments = carDocuments.where((element) {
                                return element
                                    .get('carName')
                                    .toLowerCase()
                                    .contains(searchText.toLowerCase());
                              }).toList();
                            }
                          }
                          return ListView.builder(
                            itemCount: carDocuments.length,
                            // shrinkWrap: true,
                            // scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index) => Container(
                              padding: EdgeInsets.only(bottom: 20),
                              child: SecondCarCard(
                                snap: carDocuments[index].data(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_car/screens/add_car_screen.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tap_car/widgets/primary_button.dart';
import 'package:tap_car/widgets/second_car_card.dart';
// import 'package:tap_car/widget/app_bar/secondary_app_bar.dart';

class UserCarScreen extends StatefulWidget {
  const UserCarScreen({super.key});

  @override
  State<UserCarScreen> createState() => _UserCarScreenState();
}

class _UserCarScreenState extends State<UserCarScreen> {
  bool isLoading = false;

  List<DocumentSnapshot> carDocuments = [];
  CollectionReference carCollection =
  FirebaseFirestore.instance.collection('cars');

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator() : Scaffold(
      appBar: PrimaryAppBar(
          title: "Your Car"
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              PrimaryButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddCarScreen(),
                  ),
                ),
                childText: "Add",
              ),

              const SizedBox(height: 20,),
              Text("My Cars"),
              Expanded(
                child: StreamBuilder(
                  stream: carCollection
                      .orderBy('createdDate', descending: true)
                      .snapshots(),
                  builder: (context, streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      carDocuments = streamSnapshot.data!.docs;

                      carDocuments = carDocuments.where((element) {
                        return element
                            .get('ownerId')
                            .contains(FirebaseAuth.instance.currentUser!.uid);
                      }).toList();

                    }
                    return ListView.builder(
                      itemCount: carDocuments.length,
                      // shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) =>
                          Container(
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
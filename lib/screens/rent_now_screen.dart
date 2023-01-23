import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/utils/utils.dart';
import 'package:tap_car/widgets/image_full_screen.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tap_car/widgets/primary_button.dart';

class RentNowScreen extends StatefulWidget {
  final snap;

  const RentNowScreen({
    Key? key,
    required this.snap,
  }) : super(key: key);
  @override
  State<RentNowScreen> createState() => _RentNowScreenState();
}

class _RentNowScreenState extends State<RentNowScreen> {
  bool isLoading = false;
  var ownerData = {};

  @override
  void initState() {
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var ownerSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.snap["ownerId"])
          .get();

      ownerData = ownerSnap.data()!;
      print(ownerData);

      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator()
        : Scaffold(
            appBar: PrimaryAppBar(title: "Rent Now"),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 25.0),
                      decoration: BoxDecoration(
                          // color: Theme.of(context).colorScheme.secondaryContainer,
                          ),
                      child: GestureDetector(
                        child: Hero(
                          tag: 'imageHero',
                          child: Image(
                            height: 200,
                            width: double.infinity,
                            // width: double.infinity - 20,
                            image: NetworkImage(widget.snap["photoUrl"]),
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return ImageFullScreen(
                              imageUrl: widget.snap["photoUrl"],
                            );
                          }));
                        },
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F8FF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Call the owner right now!",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.error_outline),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text(
                                  "All the transactions are between the user and the car owner only.",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: Color(0xFF252525),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person_pin,
                                      color: Color(0xFFF5F5F5),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      ownerData["username"],
                                      style: TextStyle(
                                        color: Color(0xFFF5F5F5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                    color: Color(0xFFF5F5F5),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "+(60) 13-3458 678",
                                  style: TextStyle(
                                    color: Color(0xFFF5F5F5),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    color: Color(0xFFF5F5F5),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  ownerData["email"],
                                  style: TextStyle(
                                    color: Color(0xFFF5F5F5),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          PrimaryButton(
                            onPressed: () {},
                            childText: "Call Now",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

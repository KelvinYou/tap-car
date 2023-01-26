import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_car/screens/rent_now_screen.dart';
import 'package:tap_car/services/firestore_methods.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/utils/utils.dart';
import 'package:tap_car/widgets/dialogs.dart';
import 'package:tap_car/widgets/image_full_screen.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
// import 'package:tap_car/widget/app_bar/secondary_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tap_car/widgets/primary_button.dart';

class CarDetailScreen extends StatefulWidget {
  final snap;

  const CarDetailScreen({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  bool isLoading = false;

  Widget subtitleText(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget contentText(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  deleteSubmit() async {
    final action = await Dialogs.yesAbortDialog(context, 'Confirm to delete?',
        'Once confirmed, it cannot be modified anymore', 'Delete');

    if (action == DialogAction.yes) {
      String res = await FireStoreMethods().deleteCar(widget.snap["carId"]);

      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
        showSnackBar(context, "Car removed successfully  ");
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, res);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator()
        : Scaffold(
            appBar: PrimaryAppBar(title: "Car Details"),
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
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        // color: Color(0xFFF1F8FF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.snap["carName"],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: subtitleText("Year"),
                              ),
                              Expanded(
                                child: subtitleText("Brand"),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child:
                                    contentText(widget.snap["year"].toString()),
                              ),
                              Expanded(
                                child: contentText(widget.snap["brand"]),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          subtitleText("Model"),
                          contentText(widget.snap["model"]),
                          const SizedBox(
                            height: 20,
                          ),
                          subtitleText("Seats"),
                          contentText(widget.snap["seat"].toString()),
                          const SizedBox(
                            height: 20,
                          ),
                          subtitleText("Transmission"),
                          contentText(widget.snap["transmission"]),
                          const SizedBox(
                            height: 20,
                          ),
                          FirebaseAuth.instance.currentUser!.uid ==
                                  widget.snap["ownerId"]
                              ? Container(
                                  child: PrimaryButton(
                                    onPressed: deleteSubmit,
                                    childText: "Delete",
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "RM ${widget.snap["pricePerDay"].toStringAsFixed(2)} ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "/ Day",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return RentNowScreen(
                                              snap: widget.snap,
                                            );
                                          }));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFEBE3F),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Text(
                                            "Rent Now",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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

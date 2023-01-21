import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/screens/car_detail_screen.dart';
import 'package:tap_car/widgets/image_full_screen.dart';
import 'package:intl/intl.dart';

class SecondCarCard extends StatefulWidget {
  final snap;

  const SecondCarCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<SecondCarCard> createState() => _SecondCarCardState();
}

class _SecondCarCardState extends State<SecondCarCard> {
  @override
  void initState() {
    super.initState();
  }

  final DateFormat formatter = DateFormat('dd MMM y');

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFF252525),
        // boxShadow: [
        //   BoxShadow(
        //     color: Theme.of(context).colorScheme.shadow,
        //     offset: const Offset( 0.0, 1.0, ),
        //     blurRadius: 10.0,
        //     spreadRadius: 0.5,
        //   ),
        // ],
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CarDetailScreen(
              snap: widget.snap,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.snap["carName"],
                    style: TextStyle(
                      color: Color(0xFFF5F5F5),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    "RM ${widget.snap["pricePerDay"].toStringAsFixed(2)} / Day",
                    style: TextStyle(
                      color: Color(0xFFF5F5F5),
                    ),
                  ),

                ],
              ),
            ),
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Image(
                  width: 120,
                  fit: BoxFit.fitHeight,
                  image: NetworkImage( widget.snap["photoUrl"]),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),

          ],
        ),

      ),
    );
  }
}
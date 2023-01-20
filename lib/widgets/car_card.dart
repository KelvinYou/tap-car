import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/screens/car_detail_screen.dart';
import 'package:tap_car/widgets/image_full_screen.dart';
import 'package:intl/intl.dart';

class CarCard extends StatefulWidget {
  final snap;

  const CarCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  void initState() {
    super.initState();
  }

  final DateFormat formatter = DateFormat('dd MMM y');

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Text(widget.snap["carName"]),
        ],
      ),
    );
  }
}
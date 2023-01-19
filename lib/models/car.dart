import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  final String carId;
  final String ownerId;
  final String carName;
  final String pricePerDay;
  final String year;
  final String brand;
  final String model;
  final String seat;
  final String transmission;
  final Map<String, dynamic> photoUrls;

  const Car(
    {required this.carId,
      required this.ownerId,
      required this.carName,
      required this.pricePerDay,
      required this.year,
      required this.brand,
      required this.model,
      required this.seat,
      required this.transmission,
      required this.photoUrls,
    });

  static Car fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Car(
      carId: snapshot["carId"],
      ownerId: snapshot["ownerId"],
      carName: snapshot["carName"],
      pricePerDay: snapshot["pricePerDay"],
      year: snapshot["year"],
      brand: snapshot["brand"],
      model: snapshot["model"],
      seat: snapshot["seat"],
      transmission: snapshot["transmission"],
      photoUrls: snapshot["photoUrls"],
    );
  }

  Map<String, dynamic> toJson() => {
    "carId": carId,
    "ownerId": ownerId,
    "carName": carName,
    "pricePerDay": pricePerDay,
    "year": year,
    "brand": brand,
    "seat": seat,
    "transmission": transmission,
    "photoUrls": photoUrls,
  };
}
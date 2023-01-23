import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tap_car/models/car.dart';
import 'package:tap_car/services/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addCar(String uid, String carName, double pricePerDay,
      int year, String brand, String model, int seat,
      Uint8List? image, String transmission) async {
    String res = "Some error occurred";
    String carId = const Uuid().v1();

    try {
      if (image != null) {
        String photoUrl = await StorageMethods().uploadImageToStorageList('CarPics', carId, image, false);
        // String photoUrl = await
        Car car = Car(
          carId: carId,
          ownerId: uid,
          carName: carName,
          pricePerDay: pricePerDay,
          year: year,
          brand: brand,
          model: model,
          seat: seat,
          photoUrl: photoUrl,
          transmission: transmission,
          createdDate: DateTime.now(),
        );
        _firestore.collection('cars').doc(carId).set(car.toJson());
        res = "success";
      } else {
        res = "Please select an image";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> deleteCar(String carId) async {
    String res = "Some error occurred";
    try {
      _firestore.collection('cars').doc(carId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}

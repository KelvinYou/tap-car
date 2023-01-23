import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_car/services/firestore_methods.dart';

import 'package:tap_car/utils/utils.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
import 'package:tap_car/widgets/primary_button.dart';
import 'package:tap_car/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  bool isLoading = false;

  Uint8List? image;

  final carNameController = TextEditingController();
  final yearController = TextEditingController();
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final priceController = TextEditingController();
  final seatController = TextEditingController();
  final transmissionController = TextEditingController();

  String carNameErrorMsg = "";
  String yearErrorMsg = "";
  String brandErrorMsg = "";
  String modelErrorMsg = "";
  String priceErrorMsg = "";
  String seatErrorMsg = "";
  String transmissionErrorMsg = "";

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      image = im;
    });
  }

  addCarSubmit() async {
    setState(() {
      isLoading = true;
      carNameErrorMsg = "";
      yearErrorMsg = "";
      brandErrorMsg = "";
      modelErrorMsg = "";
      priceErrorMsg = "";
      seatErrorMsg = "";
      transmissionErrorMsg = "";
    });

    try {
      String res = await FireStoreMethods().addCar(
        FirebaseAuth.instance.currentUser!.uid,
        carNameController.text,
        double.parse(priceController.text),
        int.parse(yearController.text),
        brandController.text,
        modelController.text,
        int.parse(seatController.text),
        image,
        transmissionController.text,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Added!',
        );
        Navigator.of(context).pop();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
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
            appBar: PrimaryAppBar(title: "Add New Car"),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldInput(
                        textEditingController: carNameController,
                        hintText: "Car Name",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldInput(
                        textEditingController: yearController,
                        hintText: "Year",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldInput(
                        textEditingController: brandController,
                        hintText: "Brand",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldInput(
                        textEditingController: modelController,
                        hintText: "Model",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldInput(
                        textEditingController: priceController,
                        hintText: "Price Per Day (RM)",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldInput(
                        textEditingController: seatController,
                        hintText: "No. of Seat",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldInput(
                        textEditingController: transmissionController,
                        hintText: "Transmission",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Photo",
                        style: TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: selectImage,
                        child: Icon(
                          Icons.add_box_outlined,
                          size: 55.0,
                        ),
                      ),
                      image != null ? Image.memory(image!) : SizedBox(),
                      const SizedBox(
                        height: 30,
                      ),
                      PrimaryButton(
                          onPressed: addCarSubmit, childText: "Confirm"),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
  // final String carId;
  // final String ownerId;
  // final String carName;
  // final String pricePerDay;
  // final String year;
  // final String brand;
  // final String model;
  // final String seat;
  // final String transmission;
  // final Map<String, dynamic> photoUrls;
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tap_car/utils/utils.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
import 'package:tap_car/widgets/primary_button.dart';
import 'package:tap_car/widgets/text_field_input.dart';

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

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      image = im;
    });
  }

  addCarSubmit() async {

  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator() : Scaffold(
      appBar: PrimaryAppBar(
          title: "Add New Car"
      ),
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
                const SizedBox(height: 30,),
                TextFieldInput(
                    textEditingController: carNameController,
                    hintText: "Car Name",
                    textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20,),
                TextFieldInput(
                  textEditingController: carNameController,
                  hintText: "Year",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20,),
                TextFieldInput(
                  textEditingController: carNameController,
                  hintText: "Brand",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20,),
                TextFieldInput(
                  textEditingController: carNameController,
                  hintText: "Model",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20,),
                TextFieldInput(
                  textEditingController: carNameController,
                  hintText: "Price Per Day (RM)",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20,),
                TextFieldInput(
                  textEditingController: carNameController,
                  hintText: "No. of Seat",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20,),
                TextFieldInput(
                  textEditingController: carNameController,
                  hintText: "Transmission",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20,),
                Text("photo"),

                GestureDetector(
                  onTap: selectImage,
                  child: Icon(Icons.add_box_outlined),
                ),

                image != null? Image.memory(
                  image!
                ) : SizedBox(),


                const SizedBox(height: 20,),
                PrimaryButton(
                    onPressed: addCarSubmit,
                    childText: "Confirm"
                ),
                const SizedBox(height: 40,),
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
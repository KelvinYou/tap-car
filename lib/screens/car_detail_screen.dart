import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/widgets/image_full_screen.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
// import 'package:tap_car/widget/app_bar/secondary_app_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator() : Scaffold(
      appBar: PrimaryAppBar(
          title: "Car Details"
      ),
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
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ImageFullScreen(imageUrl: widget.snap["photoUrl"],);
                    }));
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                decoration: BoxDecoration(
                  color: Color(0xFFF1F8FF),
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
                          child: contentText(widget.snap["year"].toString()),
                        ),
                        Expanded(
                          child: contentText(widget.snap["brand"]),
                        ),

                      ],
                    ),
                    subtitleText("Model"),
                    contentText(widget.snap["model"]),

                    subtitleText("Seats"),
                    contentText(widget.snap["seat"].toString()),

                    subtitleText("Transmission"),
                    contentText(widget.snap["transmission"]),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30,),
                            child: Row(
                              children: [
                                Text(
                                  "RM ${widget.snap["pricePerDay"]} ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "/ Day",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                              color: Color(0xFFFEBE3F),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              "Rent Now",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          )
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
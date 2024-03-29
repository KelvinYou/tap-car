import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_car/screens/login_screen.dart';
import 'package:tap_car/screens/change_profile_screen.dart';
import 'package:tap_car/screens/more_screen.dart';
import 'package:tap_car/screens/theme_mode_screen.dart';
import 'package:tap_car/screens/tnc_screen.dart';
import 'package:tap_car/services/auth_methods.dart';

import 'package:tap_car/utils/app_theme.dart';
import 'package:tap_car/utils/utils.dart';
import 'package:tap_car/widgets/dialogs.dart';
import 'package:tap_car/widgets/loading_indicator.dart';
import 'package:tap_car/widgets/primary_app_bar.dart';
// import 'package:tap_car/widget/app_bar/secondary_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  var userData = {};

  void initState() {
    super.initState();
    getData();
// logoutSubmit();
    // AuthMethods().signOut();
    // Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) =>
    //       const Login(),
    //     ),
    // );
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = userSnap.data()!;

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
    // print(userData);
  }

  Widget selectionView(IconData icon, String title, Color color) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: color,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: color,
                    ),
                  ),
                ],
              ),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      ],
    );
  }

  void logoutSubmit() async {
    await AuthMethods().signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  Widget titleText(String content) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        content,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget subtitleText(String content) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        content,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget contentText(String content) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 0.5, color: Colors.black),
      )),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingIndicator()
        : Scaffold(
            // appBar: PrimaryAppBar(
            //     title: ""
            // ),
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
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      height: 60,
                    ),
                    Container(
                      // height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ChangeProfileScreen(),
                              ),
                            ),
                            child: userData["photoUrl"] == ""
                                ? CircleAvatar(
                                    radius: 44.0,
                                    backgroundImage: AssetImage(
                                        'assets/default-profile-pic.jpeg'),
                                    backgroundColor: Colors.grey,
                                  )
                                : CircleAvatar(
                                    radius: 44.0,
                                    backgroundImage:
                                        NetworkImage(userData["photoUrl"]),
                                    backgroundColor: Colors.grey,
                                  ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            userData["username"],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    titleText("Profile Details"),
                    const SizedBox(
                      height: 15,
                    ),
                    subtitleText("Email"),
                    contentText(userData["email"]),
                    const SizedBox(
                      height: 15,
                    ),
                    subtitleText("Mobile Number"),
                    contentText("+(60) 12-3456 789"),
                    const SizedBox(
                      height: 15,
                    ),
                    subtitleText("Password"),
                    contentText("******"),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ThemeModeScreen(),
                        ),
                      ),
                      child: selectionView(
                          Icons.dark_mode_outlined,
                          "Light / Dark Mode",
                          Theme.of(context).colorScheme.onPrimary),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TncScreen(),
                        ),
                      ),
                      child: selectionView(
                          Icons.policy_outlined,
                          "Terms & Conditions",
                          Theme.of(context).colorScheme.onPrimary),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MoreScreen(),
                        ),
                      ),
                      child: selectionView(Icons.more_outlined, "More",
                          Theme.of(context).colorScheme.onPrimary),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final action = await Dialogs.yesAbortDialog(
                            context, 'Confirm to logout?', '', 'Logout');
                        if (action == DialogAction.yes) {
                          logoutSubmit();
                        }
                      },
                      child: selectionView(Icons.logout, "Logout", Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

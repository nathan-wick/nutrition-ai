import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_ai/screens/authenticated/settings.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../models/user.dart';
import '../../widgets/button_input.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 189, 226, 130),
                Color.fromARGB(255, 220, 236, 195),
                Color.fromARGB(9, 227, 222, 79),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(
                      duration: const Duration(milliseconds: 400),
                      child: const Text(
                        "My Profile",
                        style: TextStyle(
                            color: Color.fromARGB(255, 28, 77, 0),
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(13, 131, 78, 0.298),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 20), // Adjust the height as needed
                              Center(
                                child: Image.network(
                                  user.photo ?? '',
                                  width: 100,
                                  height: 100,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return const Icon(
                                      Icons.account_circle,
                                      size: 100,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  "Welcome ${user.name?.split(' ')[0] ?? ''}",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 28, 77, 0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: 20), // Adjust the height as needed
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
  child: Column(
    children: <Widget>[
      const SizedBox(height: 5),
      Container(
        // decoration: const BoxDecoration(
        //   color: Color.fromARGB(255, 255, 255, 255),
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(60),
        //     topRight: Radius.circular(60),
        //   ),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Color.fromRGBO(13, 131, 78, 0.298),
        //       blurRadius: 20,
        //       offset: Offset(0, 10),
        //     ),
        //   ],
        // ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15, // Adjust horizontal padding
            vertical: 10,   // Adjust vertical padding
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0, // Adjust the spacing between columns
                      mainAxisSpacing: 8.0, // Adjust the spacing between rows
                    ),
                    shrinkWrap: true, // Ensure the GridView takes only the required space
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 242, 242), // Set the color of grid items
                          borderRadius: BorderRadius.circular(10), // Set border radius
                           boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(13, 131, 78, 0.298),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text('$index', style: TextStyle(color: Color.fromARGB(255, 38, 58, 43))),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
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

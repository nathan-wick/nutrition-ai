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
    var gridTexts = [
      '${user.weightPounds}\nweight',
      '${user.heightInches}\nheight',
      '${user.exerciseFrequency}\nactive',
      '${user.sex}\nsex',
      '${user.allergies}\nallergies',
      '${user.goal}\ngoal',
    ]; // var gridTexts=['50kg','6ft','highly active','Male','1990-12-20','Lose Weight'];
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 189, 226, 130),
                Color.fromARGB(255, 192, 208, 168),
                Color.fromARGB(9, 227, 222, 79),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInUp(
                      duration: const Duration(milliseconds: 400),
                      child: Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsScreen(),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.settings),
                                tooltip: 'Settings',
                              ),
                            ],
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              " My Profile",
                              style: TextStyle(
                                color: Color.fromARGB(255, 28, 77, 0),
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(13, 131, 78, 0.298),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: [
                              const SizedBox(
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
                              const SizedBox(height: 10),
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
                              const SizedBox(height: 2),
                              Center(
                                child: Text(
                                  "${user.email}",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 100, 100, 100),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
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
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10, // Adjust horizontal padding
                          vertical: 15, // Adjust vertical padding
                        ),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 1),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1000),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing:
                                      8.0, // Adjust the spacing between columns
                                  mainAxisSpacing:
                                      8.0, // Adjust the spacing between rows
                                ),
                                shrinkWrap:
                                    true, // Ensure the GridView takes only the required space
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 6,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 243, 242,
                                          242), // Set the color of grid items
                                      borderRadius: BorderRadius.circular(
                                          10), // Set border radius
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              13, 131, 78, 0.298),
                                          blurRadius: 20,
                                          offset: Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        gridTexts[
                                            index], // Replace this with your text content
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 38, 58, 43),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // ),
                            const SizedBox(height: 30),
                            ButtonInput(
                              onTap: () {
                                FirebaseAuth.instance.signOut();
                              },
                              icon: Icons.arrow_back,
                              message: 'Sign Out',
                              theme: ButtonInputTheme.secondary,
                            ),
                            const SizedBox(height: 5),
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

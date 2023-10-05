import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import '../../widgets/my_button.dart'; // Make sure you have this widget imported if you plan to use it.

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final user = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 207, 253, 154),
        appBar: AppBar(
          title: Text("My Profile"),
          backgroundColor: Colors.lightGreen,
        ),
        body: Center(
          child: Container(
            height: 500.0,
            width: 300.0,
            color: Colors.lightGreen,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Age'),
                  items: List.generate(100, (index) => index + 1)
                      .map((e) => DropdownMenuItem(value: e.toString(), child: Text(e.toString())))
                      .toList(),
                  onChanged: (value) {},
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Sex'),
                  items: [
                    DropdownMenuItem(child: Text("Male"), value: "Male"),
                    DropdownMenuItem(child: Text("Female"), value: "Female"),
                  ],
                  onChanged: (value) {},
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Height (cm)'),
                  items: List.generate(251, (index) => index + 50)
                      .map((e) => DropdownMenuItem(value: e.toString(), child: Text(e.toString())))
                      .toList(),
                  onChanged: (value) {},
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Weight (kg)'),
                  items: List.generate(151, (index) => index + 40)
                      .map((e) => DropdownMenuItem(value: e.toString(), child: Text(e.toString())))
                      .toList(),
                  onChanged: (value) {},
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Habit'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Allergies'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

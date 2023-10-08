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
        backgroundColor: Color.fromARGB(255, 227, 255, 194),
        appBar: AppBar(
          title: Text("My Profile"),
          backgroundColor: Colors.lightGreen,
          leading: Icon(
            Icons.account_circle,
            size: 32.0,
          ),
        ),
        body: Center(
          child: Container(
            height: 608.0,
            width: 300.0,
            color: Colors.lightGreen,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Age'),
                  items: List.generate(100, (index) => index + 1)
                      .map((e) => DropdownMenuItem(
                          value: e.toString(), child: Text(e.toString())))
                      .toList(),
                  onChanged: (value) {},
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'Sex'),
                    items: [
                      DropdownMenuItem(child: Text("Male"), value: "Male"),
                      DropdownMenuItem(child: Text("Female"), value: "Female"),
                    ],
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'Height (cm)'),
                    items: List.generate(251, (index) => index + 50)
                        .map((e) => DropdownMenuItem(
                            value: e.toString(), child: Text(e.toString())))
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'Weight (kg)'),
                    items: List.generate(151, (index) => index + 40)
                        .map((e) => DropdownMenuItem(
                            value: e.toString(), child: Text(e.toString())))
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Habit'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Allergies'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

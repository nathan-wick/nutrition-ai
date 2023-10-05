import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/my_button.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final user = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
   const IconData account_circle = IconData(0xe043, fontFamily: 'MaterialIcons');

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 207, 253, 154),
           appBar: AppBar(
            title: Text("My Profile"),
            backgroundColor: Colors.lightGreen,
            
            ),
        body: Center(
          child:Container(
            height:500,
            width:300,
            color: Colors.lightGreen,
            
          ),
          
        ),
        )

        
        );
    
  }
}
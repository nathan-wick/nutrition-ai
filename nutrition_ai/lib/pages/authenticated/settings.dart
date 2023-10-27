import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrition_ai/services/database.dart';
import '../../widgets/select_input.dart';
import '../../contexts/authentication.dart';
import '../../widgets/button_input.dart';
import '../../widgets/text_input.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
  
}

class DatabaseService {
  static Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update(data);
  }
}
class _SettingsState extends State<Settings> {
  final user = FirebaseAuth.instance.currentUser!;
  late final nameController = TextEditingController();
  late final weightController = TextEditingController();
  late final heightController = TextEditingController();
  late final birthdayController = TextEditingController();
  late final sexController = TextEditingController();
  late final exerciseController = TextEditingController();
  late final goalController = TextEditingController();


  saveUserData() async {
    final newUser = await user;
    if (newUser != null){
      Map<String, dynamic> userData = {
        'name': nameController.text,
        'weight': weightController.text,
        'height': heightController.text,
        'birthday': birthdayController.text,
        'sex': sexController.text,
        'exerciseFrequency': exerciseController.text,
        'goal': goalController.text,
      };

      await DatabaseService.updateUserData(newUser.uid, userData);
    } 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              ButtonInput(
                onTap: () {
                  saveUserData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Authentication()),
                  );
                },
                icon: Icons.arrow_back,
                message: 'Save and Exit',
                theme: ButtonInputTheme.primary,
              ),
              const SizedBox(height: 40),
              TextInput(
                controller: nameController,
                name: 'Name',
              ),
              const SizedBox(height: 20),
              // TODO: Update TextInput with option to be numbers only
              TextInput(
                controller: weightController,
                name: 'Weight (lbs)',
              ),
              const SizedBox(height: 20),
              TextInput(
                controller: heightController,
                name: 'Height (in)',
              ),
              const SizedBox(height: 20),
              // TODO: Create a new widget for date input
              TextInput(
                controller: birthdayController,
                name: 'Birthday',
              ),
              const SizedBox(height: 20),
              SelectInput(
                controller: sexController,
                name: 'Sex',
                items: const [
                  DropdownMenuItem(
                    value: 'xy',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem(
                    value: 'xx',
                    child: Text('Female'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SelectInput(
                controller: exerciseController,
                name: 'Exercise Frequency',
                items: const [
                  DropdownMenuItem(
                    value: 'none',
                    child: Text('Never'),
                  ),
                  DropdownMenuItem(
                    value: 'light',
                    child: Text('1-2 Times Per Week'),
                  ),
                  DropdownMenuItem(
                    value: 'moderate',
                    child: Text('3-6 Times Per Week'),
                  ),
                  DropdownMenuItem(
                    value: 'very',
                    child: Text('1 Time Per Day'),
                  ),
                  DropdownMenuItem(
                    value: 'extra',
                    child: Text('2+ Times Per Day'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SelectInput(
                controller: exerciseController,
                name: 'Goal',
                items: const [
                  DropdownMenuItem(
                    value: 'loseWeight',
                    child: Text('Lose Weight'),
                  ),
                  DropdownMenuItem(
                    value: 'maintainWeight',
                    child: Text('Maintain Weight'),
                  ),
                  DropdownMenuItem(
                    value: 'gainWeight',
                    child: Text('Gain Weight'),
                  ),
                  DropdownMenuItem(
                    value: 'gainMuscle',
                    child: Text('Gain Muscle'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
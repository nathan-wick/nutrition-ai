import 'package:flutter/material.dart';
import 'package:nutrition_ai/models/user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../services/database.dart';
import '../../widgets/select_input.dart';
import '../../contexts/authentication.dart';
import '../../widgets/button_input.dart';
import '../../widgets/text_input.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final nameController = TextEditingController();
  late final weightController = TextEditingController();
  late final heightController = TextEditingController();
  late final birthdayController = TextEditingController();
  late final sexController = TextEditingController();
  late final exerciseFrequencyController = TextEditingController();
  late final goalController = TextEditingController();

  void exit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Authentication()),
    );
  }

  void save(UserModel newUser) async {
    newUser.name = nameController.text;
    newUser.weightPounds = double.parse(weightController.text);
    newUser.heightInches = double.parse(heightController.text);
    newUser.birthday = DateTime.parse(birthdayController.text);
    newUser.sex = sexController.text;
    newUser.exerciseFrequency = exerciseFrequencyController.text;
    newUser.goal = goalController.text;
    await DatabaseService().updateUser(newUser);
    exit();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
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
                  save(user);
                },
                icon: Icons.arrow_back,
                message: 'Save and Exit',
                theme: ButtonInputTheme.primary,
              ),
              const SizedBox(height: 40),
              TextInput(
                controller: nameController,
                defaultValue: user.name,
                name: 'Name',
              ),
              const SizedBox(height: 20),
              // TODO: Update TextInput with option to be numbers only
              TextInput(
                controller: weightController,
                defaultValue: user.weightPounds.toString(),
                name: 'Weight (pounds)',
              ),
              const SizedBox(height: 20),
              // TODO: Update TextInput with option to be numbers only
              TextInput(
                controller: heightController,
                defaultValue: user.heightInches.toString(),
                name: 'Height (inches)',
              ),
              const SizedBox(height: 20),
              // TODO: Create a new widget for date input
              TextInput(
                controller: birthdayController,
                defaultValue: DateFormat('yyyy-M-dd').format(user.birthday),
                name: 'Birthday (yyyy-mm-dd)',
              ),
              const SizedBox(height: 20),
              SelectInput(
                controller: sexController,
                defaultValue: (user.sex ?? '').isNotEmpty ? user.sex : 'XX',
                name: 'Sex',
                items: const [
                  DropdownMenuItem(
                    value: 'XX',
                    child: Text('Female'),
                  ),
                  DropdownMenuItem(
                    value: 'XY',
                    child: Text('Male'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SelectInput(
                controller: exerciseFrequencyController,
                defaultValue: (user.exerciseFrequency).isNotEmpty ? user.exerciseFrequency : 'none',
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
                controller: goalController,
                defaultValue: (user.goal).isNotEmpty ? user.goal : 'none',
                name: 'Goal',
                items: const [
                  DropdownMenuItem(
                    value: 'none',
                    child: Text('No Goal'),
                  ),
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
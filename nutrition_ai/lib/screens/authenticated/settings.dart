import 'package:flutter/material.dart';
import 'package:nutrition_ai/models/user.dart';
import 'package:intl/intl.dart';
import 'package:nutrition_ai/providers/user.dart';
import 'package:provider/provider.dart';

import '../../widgets/select_input.dart';
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
    Navigator.popAndPushNamed(context, '/profile');
  }

  void save(UserProvider userProvider, UserModel? newUser) async {
    if (newUser != null) {
      newUser.name = nameController.text;
      newUser.weightPounds = double.parse(weightController.text);
      newUser.heightInches = double.parse(heightController.text);
      newUser.birthday = DateTime.parse(birthdayController.text);
      newUser.sex = sexController.text;
      newUser.exerciseFrequency = exerciseFrequencyController.text;
      newUser.goal = goalController.text;
      await userProvider.updateUser(newUser);
    }
    exit();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final UserModel? newUser = userProvider.user;
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
                  save(userProvider, newUser);
                },
                icon: Icons.arrow_back,
                message: 'Save and Exit',
                theme: ButtonInputTheme.primary,
              ),
              const SizedBox(height: 40),
              TextInput(
                controller: nameController,
                defaultValue: newUser?.name,
                name: 'Name',
              ),
              const SizedBox(height: 20),
              // TODO: Update TextInput with option to be numbers only
              TextInput(
                controller: weightController,
                defaultValue: newUser?.weightPounds.toString(),
                name: 'Weight (pounds)',
              ),
              const SizedBox(height: 20),
              // TODO: Update TextInput with option to be numbers only
              TextInput(
                controller: heightController,
                defaultValue: newUser?.heightInches.toString(),
                name: 'Height (inches)',
              ),
              const SizedBox(height: 20),
              // TODO: Create a new widget for date input
              TextInput(
                controller: birthdayController,
                defaultValue: DateFormat('yyyy-M-dd')
                    .format(newUser?.birthday ?? DateTime.now()),
                name: 'Birthday (yyyy-mm-dd)',
              ),
              const SizedBox(height: 20),
              SelectInput(
                controller: sexController,
                defaultValue: newUser?.sex ?? 'XX',
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
                defaultValue: newUser?.exerciseFrequency ?? 'none',
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
                defaultValue: newUser?.goal ?? 'none',
                name: 'Goal',
                items: const [
                  DropdownMenuItem(
                    value: 'none',
                    child: Text('No Goal'),
                  ),
                  DropdownMenuItem(
                    value: 'gainMuscle',
                    child: Text('Gain Muscle'),
                  ),
                  DropdownMenuItem(
                    value: 'loseWeight',
                    child: Text('Lose Weight'),
                  ),
                  DropdownMenuItem(
                    value: 'gainWeight',
                    child: Text('Gain Weight'),
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

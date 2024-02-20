import 'package:flutter/material.dart';
import 'package:nutrition_ai/widgets/date_input.dart';
import 'package:provider/provider.dart';

import '../../models/measurement.dart';
import '../../models/user.dart';
import '../../providers/user.dart';
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
  late final birthdayController = TextEditingController();
  late final sexController = TextEditingController();
  late final heightController = TextEditingController();
  late final weightController = TextEditingController();
  late final exerciseFrequencyController = TextEditingController();
  late final goalController = TextEditingController();

  void exit() {
    Navigator.popAndPushNamed(context, '/profile');
  }

  void save(UserProvider userProvider, UserModel? user) async {
    if (user != null) {
      user.name = nameController.text;
      user.profile.birthday = DateTime.parse(birthdayController.text);
      user.profile.sex = sexController.text;
      user.profile.height = MeasurementModel(
          amount: double.parse(heightController.text), unit: 'inches');
      user.profile.weight = MeasurementModel(
          amount: double.parse(weightController.text), unit: 'pounds');
      user.profile.exerciseFrequency = exerciseFrequencyController.text;
      user.profile.goal = goalController.text;
      await userProvider.updateUser(user);
    }
    exit();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final UserModel? user = userProvider.user;
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
                  save(userProvider, user);
                },
                icon: Icons.arrow_back,
                message: 'Save and Exit',
                theme: ButtonInputTheme.primary,
              ),
              const SizedBox(height: 40),
              TextInput(
                controller: nameController,
                defaultValue: user?.name,
                name: 'Name',
              ),
              const SizedBox(height: 20),
              DateInput(
                  onSelectedDateChanged: (DateTime selectedDate) =>
                      {birthdayController.text = selectedDate.toString()},
                  defaultValue: user?.profile.birthday,
                  name: 'Birthday'),
              const SizedBox(height: 20),
              SelectInput(
                controller: sexController,
                defaultValue: user?.profile.sex ?? 'XX',
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
              // TODO: Update TextInput with option to be numbers only
              TextInput(
                controller: heightController,
                defaultValue: user?.profile.height.amount.toString() ?? '67',
                name: 'Height (inches)',
              ),
              const SizedBox(height: 20),
              // TODO: Update TextInput with option to be numbers only
              TextInput(
                controller: weightController,
                defaultValue: user?.profile.weight.amount.toString() ?? '150',
                name: 'Weight (pounds)',
              ),
              const SizedBox(height: 20),
              SelectInput(
                controller: exerciseFrequencyController,
                defaultValue: user?.profile.exerciseFrequency ?? 'sometimes',
                name: 'Exercise Frequency',
                items: const [
                  DropdownMenuItem(
                    value: 'never',
                    child: Text('Never'),
                  ),
                  DropdownMenuItem(
                    value: 'sometimes',
                    child: Text('Sometimes'),
                  ),
                  DropdownMenuItem(
                    value: 'often',
                    child: Text('Often'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SelectInput(
                controller: goalController,
                defaultValue: user?.profile.goal ?? 'maintain',
                name: 'Goal',
                items: const [
                  DropdownMenuItem(
                    value: 'maintain',
                    child: Text('Maintain (No Goal)'),
                  ),
                  DropdownMenuItem(
                    value: 'lose_fat',
                    child: Text('Lose Fat'),
                  ),
                  DropdownMenuItem(
                    value: 'gain_fat',
                    child: Text('Gain Fat'),
                  ),
                  DropdownMenuItem(
                    value: 'gain_muscle',
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

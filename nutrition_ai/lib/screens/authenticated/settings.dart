import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/measurement.dart';
import '../../models/user.dart';
import '../../providers/user.dart';
import '../../widgets/select_input.dart';
import '../../widgets/button_input.dart';
import '../../widgets/text_input.dart';
import '../../widgets/date_input.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final nameController = TextEditingController();
  DateTime birthday = DateTime.now();
  final sexController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final exerciseFrequencyController = TextEditingController();
  final goalController = TextEditingController();

  void exit() {
    Navigator.popAndPushNamed(context, '/profile');
  }

  void save(UserProvider userProvider, UserModel? user) async {
    if (user != null) {
      user.name = nameController.text;
      user.profile.birthday = birthday;
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
    birthday = user?.profile.birthday ?? DateTime.now();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            save(userProvider, user);
          },
        ),
        shadowColor: Theme.of(context).shadowColor,
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TextInput(
                  controller: nameController,
                  defaultValue: user?.name ?? '',
                  name: 'Name',
                ),
                const SizedBox(height: 20),
                DateInput(
                    onSelectedDateChanged: (DateTime selectedDate) =>
                        birthday = selectedDate,
                    defaultValue: user?.profile.birthday ??
                        DateTime.now().subtract(const Duration(days: 7305)),
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
                TextInput(
                  controller: heightController,
                  defaultValue:
                      user?.profile.height.amount.toStringAsFixed(0) ?? '67',
                  name: 'Height (inches)',
                  numbersOnly: true,
                ),
                const SizedBox(height: 20),
                TextInput(
                  controller: weightController,
                  defaultValue:
                      user?.profile.weight.amount.toStringAsFixed(0) ?? '150',
                  name: 'Weight (pounds)',
                  numbersOnly: true,
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
                const SizedBox(height: 40),
                ButtonInput(
                  onTap: () {
                    save(userProvider, user);
                  },
                  icon: Icons.save_alt,
                  message: 'Save and Exit',
                  theme: ButtonInputTheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nutrition_ai/models/user.dart';
import 'package:intl/intl.dart';

import '../../services/database.dart';
import '../../widgets/select_input.dart';
import '../../contexts/authentication.dart';
import '../../widgets/button_input.dart';
import '../../widgets/text_input.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late Future<User> user;
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

  void save() async {
    final newUser = await user;
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
  void initState() {
    super.initState();
    user = DatabaseService().getUser();
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
          child: FutureBuilder<User>(
            future: user,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    ButtonInput(
                      onTap: save,
                      icon: Icons.arrow_back,
                      message: 'Save and Exit',
                      theme: ButtonInputTheme.primary,
                    ),
                    const SizedBox(height: 40),
                    TextInput(
                      controller: nameController,
                      defaultValue: snapshot.data?.name,
                      name: 'Name',
                    ),
                    const SizedBox(height: 20),
                    // TODO: Update TextInput with option to be numbers only
                    TextInput(
                      controller: weightController,
                      defaultValue: snapshot.data?.weightPounds.toString(),
                      name: 'Weight (pounds)',
                    ),
                    const SizedBox(height: 20),
                    // TODO: Update TextInput with option to be numbers only
                    TextInput(
                      controller: heightController,
                      defaultValue: snapshot.data?.heightInches.toString(),
                      name: 'Height (inches)',
                    ),
                    const SizedBox(height: 20),
                    // TODO: Create a new widget for date input
                    TextInput(
                      controller: birthdayController,
                      defaultValue: DateFormat('yyyy-mm-dd').format(snapshot.data?.birthday ?? DateTime.now()),
                      name: 'Birthday (yyyy-mm-dd)',
                    ),
                    const SizedBox(height: 20),
                    SelectInput(
                      controller: sexController,
                      defaultValue: snapshot.data?.sex.toString(),
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
                      controller: exerciseFrequencyController,
                      defaultValue: snapshot.data?.exerciseFrequency.toString(),
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
                      defaultValue: snapshot.data?.goal.toString(),
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
                );
              } else if (snapshot.hasError) {
                exit();
              } else {
                return const CircularProgressIndicator();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
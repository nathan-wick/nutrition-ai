import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrition_ai/models/nutrient.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import '../../models/user.dart';
import '../../screens/authenticated/settings.dart';
import '../../providers/user.dart';
import '../../widgets/button_input.dart';
import '../../widgets/main_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final UserModel? user = userProvider.user;
    var gridTexts = [
      '${user?.profile.bodyMassIndex}\nBody Mass Index',
      '${user?.profile.totalDailyEnergyExpenditure}\nTotal Daily Energy Expenditure',
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.green,
                Theme.of(context).primaryColor,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Center(
                                child: user?.photo != null
                                    ? Image.network(
                                        user?.photo ?? '',
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
                                      )
                                    : const Icon(
                                        Icons.account_circle,
                                        size: 100,
                                      ),
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      user?.name ?? "Anonymous User",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      user?.email ?? '',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Platform.isIOS || Platform.isMacOS
                                        ? ButtonInput(
                                            onTap: () =>
                                                Navigator.popAndPushNamed(
                                                    context, '/settings'),
                                            icon: Icons.settings,
                                            message: 'Settings',
                                            theme: ButtonInputTheme.primary,
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ButtonInput(
                                                onTap: () => userProvider
                                                    .signOut(context),
                                                icon: Icons.arrow_back,
                                                message: 'Sign Out',
                                                theme:
                                                    ButtonInputTheme.secondary,
                                              ),
                                              ButtonInput(
                                                onTap: () =>
                                                    Navigator.popAndPushNamed(
                                                        context, '/settings'),
                                                icon: Icons.settings,
                                                message: 'Settings',
                                                theme: ButtonInputTheme.primary,
                                              ),
                                            ],
                                          ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Birthday',
                                            textAlign: TextAlign.left),
                                        Text(
                                            DateFormat('MMMM d, y').format(
                                                user?.profile.birthday ??
                                                    DateTime.now()),
                                            textAlign: TextAlign.right),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Sex',
                                            textAlign: TextAlign.left),
                                        Text(
                                            user?.profile.sex == 'XX'
                                                ? 'female'
                                                : 'male',
                                            textAlign: TextAlign.right),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Height',
                                            textAlign: TextAlign.left),
                                        Text(
                                            '${user?.profile.height.amount.toStringAsFixed(0) ?? '?'} inches',
                                            textAlign: TextAlign.right),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Weight',
                                            textAlign: TextAlign.left),
                                        Text(
                                            '${user?.profile.weight.amount.toStringAsFixed(0) ?? '?'} pounds',
                                            textAlign: TextAlign.right),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Exercise Frequency',
                                            textAlign: TextAlign.left),
                                        Text(
                                            user?.profile.exerciseFrequency ??
                                                '?',
                                            textAlign: TextAlign.right),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Goal',
                                            textAlign: TextAlign.left),
                                        Text(user?.profile.goal ?? '?',
                                            textAlign: TextAlign.right),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Body Mass Index',
                                            textAlign: TextAlign.left),
                                        Text(
                                            user?.profile.bodyMassIndex
                                                    ?.toStringAsFixed(0) ??
                                                '?',
                                            textAlign: TextAlign.right),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                            'Total Daily Energy Expenditure',
                                            textAlign: TextAlign.left),
                                        Text(
                                            user?.profile
                                                    .totalDailyEnergyExpenditure
                                                    ?.toStringAsFixed(0) ??
                                                '?',
                                            textAlign: TextAlign.right),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Recommended Daily Nutrients",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ListView.builder(
                                  itemCount:
                                      user?.recommendedNutrients.length ?? 0,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext recommendedNutrientContext,
                                          int recommendedNutrientIndex) {
                                    List<NutrientModel> nutrients =
                                        user?.recommendedNutrients ?? [];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            nutrients[recommendedNutrientIndex]
                                                .name,
                                            textAlign: TextAlign.left),
                                        Text(
                                            '${nutrients[recommendedNutrientIndex].amount?.amount.toStringAsFixed(0) ?? 0} ${nutrients[recommendedNutrientIndex].amount?.unit}',
                                            textAlign: TextAlign.right),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MainNavigationBar(
        defaultIndex: 2,
      ),
    );
  }
}

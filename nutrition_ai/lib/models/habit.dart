enum HabitName {
  exercise,
}

enum HabitFrequency {
  none,
  light,
  moderate,
  very,
  extra
}

class Habit {
  final HabitName name;
  final HabitFrequency frequency;

  Habit({
    required this.name,
    required this.frequency,
  });
}
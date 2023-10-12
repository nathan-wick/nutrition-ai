enum HabitName {
  exercise,
}

enum HabitFrequency {
  never,
  sometimes,
  often,
}

class Habit {
  final HabitName name;
  final HabitFrequency frequency;

  Habit({
    required this.name,
    required this.frequency,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name.toString().split('.').last,
      'frequency': frequency.toString().split('.').last,
    };
  }
  
}
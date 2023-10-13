enum GoalName {
  loseWeight,
  maintainWeight,
  gainWeight,
  gainMuscle,
}

class Goal {
  final GoalName name;
  final double? targetWeight;

  Goal({
    required this.name,
    this.targetWeight
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name.toString().split('.').last,
      'targetWeight': targetWeight,
    };
  }
}
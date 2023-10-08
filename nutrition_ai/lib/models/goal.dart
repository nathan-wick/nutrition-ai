enum GoalName {
  lose,
  maintain,
  gain
}

class Goal {
  final GoalName goal;
  final double targetWeight;

  Goal({
    required this.goal,
    required this.targetWeight
  });
}
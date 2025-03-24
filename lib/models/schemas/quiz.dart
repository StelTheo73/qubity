class QuizSchema {
  const QuizSchema({
    required this.userId,
    required this.correct,
    required this.total,
    required this.date,
  });

  final String userId;
  final int correct;
  final int total;
  final DateTime date;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'correct': correct,
      'total': total,
      'date': date.toIso8601String(),
    };
  }
}

enum Type { multiple, boolean }

class Question {
  final String question;
  final String correctAnswer;
  final List<dynamic> incorrectAnswers = new List();
  final String incorrectAnswer1;
  final String incorrectAnswer2;
  final String incorrectAnswer3;

  Question(
      {this.question,
      this.correctAnswer,
      this.incorrectAnswer1,
      this.incorrectAnswer2,
      this.incorrectAnswer3});

  Question.fromMap(Map<String, dynamic> data)
      : question = data["Q"],
        correctAnswer = data["CA"],
        incorrectAnswer1 = data["ICA1"],
        incorrectAnswer2 = data["ICA2"],
        incorrectAnswer3 = data["ICA3"];

  static List<Question> fromData(List<Map<String, dynamic>> data) {
    return data.map((question) => Question.fromMap(question)).toList();
  }
}

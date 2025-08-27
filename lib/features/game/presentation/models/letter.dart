enum LetterState { none, posCorrect, posWrong, notInWord }

class Letter {
  final String value;
  final LetterState state;

  const Letter({required this.value, this.state = LetterState.none});

  const Letter.empty({this.value = "", this.state = LetterState.none});
}

typedef Word = List<Letter>;
typedef WordString = List<String>;

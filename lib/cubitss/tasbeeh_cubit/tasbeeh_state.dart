class TasbeehState {
  final int currentIndex;
  final int repeatCount;
  final List<int> counts; // يحتوي على التكرارات لكل صفحة
  final List<int> rounds; // يحتوي على الجولات لكل صفحة
  final List<String> azkar;

  TasbeehState({
    required this.currentIndex,
    required this.repeatCount,
    required this.counts,
    required this.rounds,
    required this.azkar,
  });

  factory TasbeehState.initial() {
    return TasbeehState(
      currentIndex: 0,
      repeatCount: 33, // افتراضي عدد التكرارات 33
      counts: List.generate(10, (index) => 0), // افتراضًا عدد الأذكار 10
      rounds: List.generate(10, (index) => 0), // افتراضًا الجولات 10
      azkar: List.generate(10, (index) => 'ذكر $index'), // افتراضًا الأذكار
    );
  }

  TasbeehState copyWith({
    int? currentIndex,
    int? repeatCount,
    List<int>? counts,
    List<int>? rounds,
    List<String>? azkar,
  }) {
    return TasbeehState(
      currentIndex: currentIndex ?? this.currentIndex,
      repeatCount: repeatCount ?? this.repeatCount,
      counts: counts ?? this.counts,
      rounds: rounds ?? this.rounds,
      azkar: azkar ?? this.azkar,
    );
  }
}

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
      counts: List.generate(12, (index) => 0), // عدد الأذكار 12
      rounds: List.generate(12, (index) => 0), // الجولات 12
      azkar: [
        'سُبْحَانَ اللَّهِ',
        'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
        'سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ',
        'سُبْحَانَ اللَّهِ الْعَظِيمِ وَبِحَمْدِهِ',
        'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ سُبْحَانَ اللَّهِ الْعَظِيمِ',
        'سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ وَلَا إِلٰهَ إِلَّا اللَّهُ وَاللَّهُ أَكْبَرُ',
        'لَا إِلٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
        'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
        'اللَّهُمَّ اغْفِرْ لِي وَارْحَمْنِي وَاهْدِنِي وَعَافِنِي وَارْزُقْنِي',
        'أَسْتَغْفِرُ اللَّهَ',
        'أَسْتَغْفِرُ اللَّهَ الْعَظِيمَ الَّذِي لَا إِلٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ وَأَتُوبُ إِلَيْهِ',
        'اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ عَلَىٰ سَيِّدِنَا مُحَمَّدٍ',
      ],
// الأذكار المطلوبة
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

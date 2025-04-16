extension ArabicNumberExtension on String {
  String get toArabicNumbers {
    Map<String, String> arabicMap = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };
    // ignore: unnecessary_this
    return this.split('').map((e) => arabicMap[e] ?? e).join('');
  }
}

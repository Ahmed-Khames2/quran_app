// allah_name_model.dart

class AllahName {
  final int number;
  final String name;
  final String description;

  AllahName({
    required this.number,
    required this.name,
    required this.description,
  });

  // تحويل من JSON إلى نموذج
  factory AllahName.fromJson(Map<String, dynamic> json) {
    return AllahName(
      number: json['number'] is int ? json['number'] : int.parse(json['number'].toString()),
      name: json['name'],
      description: json['description'],
    );
  }

  // تحويل من نموذج إلى JSON,
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'description': description,
    };
  }
}

// لتحميل كل أسماء الله الحسنى من ملف JSON
class AllahNamesRepository {
  // تحميل كل الأسماء من ملف json
  static List<AllahName> loadAllahNames(List<dynamic> jsonList) {
    return jsonList.map((json) => AllahName.fromJson(json)).toList();
  }
}
















/*
TextStyle(
            //fontFamily: 'quran',
            fontSize: 35,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 2.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
 */
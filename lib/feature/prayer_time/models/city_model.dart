class CityModel {
  final String name;
  final double lat;
  final double lng;

  CityModel({required this.name, required this.lat, required this.lng});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class City {
  int id;
  String name;

  City(this.id, this.name);

  factory City.fromJson(dynamic json) {
    return City(json['id'] as int, json['name'] as String);
  }
}

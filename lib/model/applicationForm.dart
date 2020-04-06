import 'city.dart';

class ApplicationForm {
  int id;
  String missionDate;
  City city;

  ApplicationForm(this.id, this.missionDate, this.city);

  factory ApplicationForm.fromJson(dynamic json) {
    return ApplicationForm(json['id'] as int, json['mission_date'] as String,
        City.fromJson(json['City']));
  }
}

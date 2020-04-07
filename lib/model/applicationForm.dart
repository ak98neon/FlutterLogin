import 'city.dart';

class ApplicationForm {
  int id;
  String missionDate;
  City departureCity;
  City destinationCity;

  ApplicationForm(
      this.id, this.missionDate, this.departureCity, this.destinationCity);

  factory ApplicationForm.fromJson(dynamic json) {
    return ApplicationForm(
        json['id'] as int,
        json['mission_date'] as String,
        City.fromJson(json['DepartureCity']),
        City.fromJson(json['DestinationCity']));
  }
}

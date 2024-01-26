import 'enums/daily.dart';
import 'enums/hourly.dart';
import 'exceptions/invalid_data.dart';

String createNullableParam(String paramName, dynamic value) {
  return value != null ? "&$paramName=$value" : "";
}

List<String> generateVaules(List<Enum>? values) {
  if (values != null) {
    return values.map((value) => value.name).toList();
  }
  return [];
}

throwCheckLatLng(double latitude, longitude) {
  if (latitude < -90 || latitude > 90) {
    throw InvalidDataException("Provided latitude must be in range -90 to 90");
  }
  if (longitude < -180 || longitude > 180) {
    throw InvalidDataException(
        "Provided longitude must be in range -180 to 180");
  }
}

String generateArgsDHBase(List<Hourly>? hourly, List<Daily>? daily) {
  List<String> hourlyArgs = [], dailyArgs = [];

  // Convert enums to standard values.
  hourlyArgs = generateVaules(hourly);
  dailyArgs = generateVaules(daily);

  if (hourlyArgs.isEmpty && dailyArgs.isEmpty) {
    throw InvalidDataException(
        "Please provide at least one of the two Hourly or Daily enum values.");
  }

  // Add and convert.
  String args = "";
  args += hourlyArgs.isNotEmpty ? "hourly=${hourlyArgs.join(",")}" : "";
  args += dailyArgs.isNotEmpty
      ? "${hourlyArgs.isNotEmpty ? "&" : ""}daily=${dailyArgs.join(",")}"
      : "";

  return args;
}

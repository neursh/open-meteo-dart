import 'enums/current.dart';
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

String generateArgsDHCBase(
    List<Daily>? daily, List<Hourly>? hourly, List<Current>? current) {
  List<String> dailyArgs = [], hourlyArgs = [], currentArgs = [];

  // Convert enums to standard values.
  dailyArgs = generateVaules(daily);
  hourlyArgs = generateVaules(hourly);
  currentArgs = generateVaules(current);

  if (dailyArgs.isEmpty && hourlyArgs.isEmpty && currentArgs.isEmpty) {
    throw InvalidDataException(
        "Empty URL arguments. Please check your implementation.");
  }

  // Add and convert.
  String args = "";
  args += dailyArgs.isNotEmpty
      ? "${args.isNotEmpty ? "&" : ""}daily=${dailyArgs.join(",")}"
      : "";
  args += hourlyArgs.isNotEmpty
      ? "${args.isNotEmpty ? "&" : ""}hourly=${hourlyArgs.join(",")}"
      : "";
  args += currentArgs.isNotEmpty
      ? "${args.isNotEmpty ? "&" : ""}current=${currentArgs.join(",")}"
      : "";

  return args;
}

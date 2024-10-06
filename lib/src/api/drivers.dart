import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:formula1_data/formula1_data.dart';

Future<List<Driver>> getDrivers({int? year}) async {
  year = year ?? DateTime.now().year;
  List<Driver> drivers = [];
  try {
    Dio dio = Dio();
    final Response response =
        await dio.get("https://ergast.com/api/f1/$year/drivers.json");
    final dynamic data = response.data;
    final List<dynamic> driversData = data["MRData"]["DriverTable"]["Drivers"];
    for (var data in driversData) {
      debugPrint(data.toString());
      final Driver driver = Driver(
        driverId: data["driverId"],
        permanentNumber: int.parse(data["permanentNumber"]),
        code: data["code"],
        url: data["url"],
        givenName: data["givenName"],
        familyName: data["familyName"],
        dateOfBirth: DateTime.parse(data["dateOfBirth"]),
        nationality: data["nationality"],
      );
      drivers.add(driver);
    }
  } on DioException catch (error) {
    debugPrint(error.message.toString());
  }
  return drivers;
}

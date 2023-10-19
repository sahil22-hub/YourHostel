import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:emulatorapp/models/hostel.dart';

class HostelService {
  Future<List<HostelModel>> fetchAllHostel() async {
    const String token = "89836958-7a87-410f-a07e-71b8d9bcd45d";
    const url = "https://www.yourhostel.com.np/api/hostel/featured";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final hostelData = json
          .map(
            (data) => HostelModel(
              id: data['id'],
              name: data['name'],
              logo: data['logo'],
              city: data['city'],
              gender: data['gender'],
              slug: data['slug'],
              phoneNumber: data['phone'],
              district: data['district'],
              startingPrice: data['starting_price'],
              ownerName: data['owner'],
            ),
          )
          .toList();
      return hostelData;
    }
    throw "Something went wrong";
  }
}

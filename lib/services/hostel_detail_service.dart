import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:emulatorapp/models/hostel_detail.dart';

class HostelDetailsService {
  Future<HostelDetailModel> fetchAllHostelData(String slug) async {
    const String token = "89836958-7a87-410f-a07e-71b8d9bcd45d";
    final url = 'https://www.yourhostel.com.np/api/hostel/$slug';
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final hostelDetailData = HostelDetailModel(
        id: data["id"],
        description: data["description"],
        gender: data["gender"],
        hostelName: data["name"],
        map: data["map"],
        phone: data["phone"],
        district: data["district"],
        city: data["city"],
        owner: data["owner"],
        features: data["features"],
        googleReviews: data["googleReviews"],
        starting_price: data["starting_price"],
        comments: data["comments"],
      );
      return hostelDetailData;
    }
    throw "Error";
  }
}

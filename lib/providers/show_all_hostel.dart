import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:emulatorapp/providers/featured_hostel.dart';

import '../models/http_extention.dart';

class ShowAllHostel with ChangeNotifier {
  final List<FeatureHostelData> _searchedHostelList = [];
  final List<FeatureHostelData> _genderHostelList = [];

  List<FeatureHostelData> get featuresHostel {
    return [..._searchedHostelList];
  }

  List<FeatureHostelData> get genderHostel {
    return [..._genderHostelList];
  }

  Map<String, dynamic> hostelData = {
    "id": 22,
    "name": "Boys hostel",
    "City": "Kathmandu",
    "gender": "male",
  };

  Future<void> allHostel(String genderIndex) async {
    const uri = "https://www.yourhostel.com.np/api/hostel/show-all";
    try {
      final response = await http.post(
        Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            "skip": 0,
            "limit": 4,
            "search": {
              "name": null,
              "city": null,
              "district": null,
              "gender": null,
              "category": null,
              "rating": null,
              "price": 9999,
              "sitter": null,
            },
            "flag": "FLUTTER",
          },
        ),
      );
      print('response.body:' + response.body);
      final responseData = json.decode(response.body);
      _searchedHostelList.clear();
      responseData.forEach(
        (data) {
          _searchedHostelList.add(
            FeatureHostelData(
              id: data['id'],
              name: data['name'],
              logo: data['banner'],
              city: data['city'],
              gender: data['gender'],
              slug: data['slug'],
            ),
          );
        },
      );
      _genderHostelList.clear();
      for (int i = 0; i < _searchedHostelList.length; i++) {
        if (_searchedHostelList[i].gender == genderIndex) {
          _genderHostelList.add(_searchedHostelList[i]);
        }
      }

      notifyListeners();
      if (response.statusCode == 401) {
        print('error 401');
        throw httpException('httpException');
      }
    } catch (e) {
      print('form catch error:$e');
      throw e;
    }
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

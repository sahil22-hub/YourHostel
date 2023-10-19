import 'dart:convert';

import 'package:emulatorapp/models/global_reg_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeatureHostelData with ChangeNotifier {
  final int id;
  final String name;
  final String logo;
  final String city;
  final String gender;
  final String slug;

  FeatureHostelData({
    required this.id,
    required this.name,
    required this.logo,
    required this.city,
    required this.gender,
    required this.slug,
  });
}

class FeaturedHostel with ChangeNotifier {
  final List<FeatureHostelData> _featuredHostelList = [];
  final List<FeatureHostelData> _genderHostelList = [];
  final List<FeatureHostelData> _hostelNamesList = [];

  List<FeatureHostelData> get featuresHostel {
    return [..._featuredHostelList];
  }

  List<FeatureHostelData> get genderHostel {
    return [..._genderHostelList];
  }

  List<FeatureHostelData> get hostelNamesList {
    return [..._hostelNamesList];
  }

  // List<String> get maitideviHostelList {
  //   return [..._maitideviHostel];
  // }

  Future<void> setFeaturedHostel(String genderIndex) async {
    final String token = "89836958-7a87-410f-a07e-71b8d9bcd45d";
    const uri = "https://www.yourhostel.com.np/api/hostel/featured";
    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      final responseData = json.decode(response.body);
      _featuredHostelList.clear();
      responseData.forEach(
        (data) {
          _featuredHostelList.add(
            FeatureHostelData(
              id: data['id'],
              name: data['name'],
              logo: data['logo'],
              city: data['city'],
              gender: data['gender'],
              slug: data['slug'],
            ),
          );
        },
      );
      _genderHostelList.clear();
      for (int i = 0; i < _featuredHostelList.length; i++) {
        if (_featuredHostelList[i].gender == genderIndex) {
          _genderHostelList.add(_featuredHostelList[i]);
        }
      }

      for (int i = 0; i < _featuredHostelList.length; i++) {
        if (_hostelNamesList.contains(_featuredHostelList[i].name)) {
          return;
        }
        _hostelNamesList.add(_featuredHostelList[i]);
      }

      // for (int i = 0; i < _featuredHostelList.length; i++) {
      //   if (_featuredHostelList[i].city == "Maitidevi")
      //     _maitideviHostel.add(_featuredHostelList[i].name);
      // }

      // Void searchHostel(address) {

      // }

      // print("from function: $_genderHostelList");
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
  // setGender(String genderIndex){
  //   return setFeaturedHostel(genderIndex);
  // }

}

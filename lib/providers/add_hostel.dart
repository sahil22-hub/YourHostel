import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/global_reg_data.dart' as globals;

import '../models/http_extention.dart';

class AddHostel with ChangeNotifier {
  Future<void> register() async {
    print("before sending add hostel api : ${globals.logo}");
    final String token = "89836958-7a87-410f-a07e-71b8d9bcd45d";
    const url = 'https://www.yourhostel.com.np/api/hostel/add';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      // 'Content-Type': 'multipart/form-data, application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Accept': "application/json",
    };
    try {
      print('top');
      // print('test : ' + globals.gallery0[0].toString());
      final response = http.MultipartRequest('POST', Uri.parse(url));
      response.headers.addAll(headers);
      // response.files.add(globals.gallery0[0]);
      // response.files.add(globals.gallery1[0]);
      // response.files.add(globals.gallery2[0]);
      response.fields['flag'] = "FLUTTER";
      response.fields['name'] = "Flutter Test12 Hostel";
      response.fields['email'] = 'sahilbhetwal22@gmail.com';
      response.fields['phone'] = '9861198933';
      response.fields['district'] = 'test';
      response.fields['city'] = 'test';
      response.fields['owner'] = 'test';
      response.fields['description'] = 'test';
      response.fields['total_rooms'] = "12";
      response.fields['total_students'] = "12";
      response.fields['gender'] = globals.gender;
      response.fields['starting_price'] = "12";
      response.files.add(globals.logo);
      for (String item in globals.features) {
        response.files.add(http.MultipartFile.fromString('features', item));
      }

      // for(String item in globals.features){
      //   response.files.add(http.MultipartFile.fromString('features', item));
      //   print('from features : $item');
      // }
      // response.fields['map'] = 'test';
      // response.fields['facebook'] = 'test';
      // response.fields['category_id'] = 'test'
      // response.fields['features'] = 'test';
      // response.fields['sah'] = 'test';
      // response.fields['registered'] = 'test';
      // response.fields['registered_year'] = 'test';
      // response.fields['address'] = 'test';
      // response.fields['key'] = 'test';
      //response.files.add(globals.gallery1[0]);
      // response.files.add(globals.gallery2[0]);
      var request = await response.send();
      print("hello after http send");
      print("status code from add hostel: ${request.statusCode}");
      var requested = await http.Response.fromStream(request);
      final requestedData = json.decode(requested.body);
      if (request.statusCode == 422) {
        print("unlinked");
        throw httpException(requestedData["errors"]["name"][0]);
      }
      print("Response before json.decode : ${requestedData}");
      print('Hostel registered');
      // if (response.statusCode == 401) {
      //   print('error in try');
      //   throw httpException('httpException');
      // }
    } catch (error) {
      print('This is the error in add hostel: $error');
      throw error;
    }
  }
}

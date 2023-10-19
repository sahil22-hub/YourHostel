library globals;

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

var name = TextEditingController();
var email = TextEditingController();
var phone = TextEditingController();
var district = TextEditingController();
var city = TextEditingController();
var owner = TextEditingController();
var total_rooms = TextEditingController();
var total_students = TextEditingController();
var gender = "1";
var category;
var map = TextEditingController();
var facebook = TextEditingController();
var instagram = TextEditingController();
var starting_price = TextEditingController();
var registered_year = TextEditingController();
var students_per_room = TextEditingController();
var description = TextEditingController();
var address = TextEditingController();
List<String> features=['1','2'];
List<http.MultipartFile> gallery0 = [];
List<http.MultipartFile> gallery1 = [];
List<http.MultipartFile> gallery2 = [];
late http.MultipartFile logo;
Map<dynamic, dynamic> sitters = {
  "1": false,
  "2": false,
  "3": false,
  "4": false,
  "5": false,
  "6": false,
};
var descriptionSitter1 = TextEditingController();
var descriptionSitter2 = TextEditingController();
var descriptionSitter3 = TextEditingController();
var descriptionSitter4 = TextEditingController();
var descriptionSitter5 = TextEditingController();
var descriptionSitter6 = TextEditingController();
List<http.MultipartFile> sitter1 = [];
List<http.MultipartFile> sitter2 = [];
List<http.MultipartFile> sitter3 = [];
List<http.MultipartFile> sitter4 = [];
List<http.MultipartFile> sitter5 = [];
List<http.MultipartFile> sitter6 = [];
var image;
var imageFile;
var favHostelNumber = 0;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/global_reg_data.dart' as globals;
import 'package:http/http.dart' as http;

class BasicInfoReg extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final Function setBasicInfo;
  final bool passData;

  BasicInfoReg(this.formKey, this.setBasicInfo, this.passData);

  @override
  State<BasicInfoReg> createState() => _BasicInfoRegState();
}

class _BasicInfoRegState extends State<BasicInfoReg> {
  final hostelType = ['Boys', 'Girls'];
  final hostelCategory = [
    'Five Star Hostel',
    'Four Star Hostel',
    'Three Star Hostel',
    'One Star Hostel',
    'Tourist Standard Hostel',
    'Standard Hostel'
  ];
  bool isLogo = false;
  final ImagePicker imagePicker = ImagePicker();
  final List<XFile>? imageFileList = [];
  final ImagePicker logoPicker = ImagePicker();
  late final XFile? logoImage;

  Future<void> selectImage(sitter) async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
      sitter.clear();
      for (int i = 0; i < imageFileList!.length; i++) {
        File imageFile = File(imageFileList![i].path);
        var stream = new http.ByteStream(imageFile.openRead());
        stream.cast();
        var length = await imageFile.length();
        var multiPartFile = http.MultipartFile('logo', stream, length);
        sitter.add(multiPartFile);
      }
    }
  }

  Future<void> selectLogo() async {
    final XFile? selectedImage =
        await logoPicker.pickImage(source: ImageSource.gallery);
        print(selectedImage);
    if (selectedImage != null) {
      setState(() {
        isLogo = true;
      });
      logoImage = selectedImage;
      File imageFile = File(logoImage!.path);
      print(imageFile);
      // var stream = new http.ByteStream(imageFile.openRead());
      var stream = imageFile.readAsBytes().asStream();
      // stream.cast();
      var length = await imageFile.length();
      var multiPartFile = http.MultipartFile('logo', stream, length,filename: imageFile.toString());
      globals.logo = multiPartFile;
      print("This is checking logo : $multiPartFile");
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _primaryColor = Theme.of(context).primaryColor;
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IconButton(
          //   onPressed: (() =>
          //       Navigator.of(context).popAndPushNamed(Example.routeName)),
          //   icon: const Icon(Icons.add),
          // ),
          textFormField(_primaryColor, _size.height * 0.06,
              'Hostel Name (Full Name)', globals.name, true),
          SizedBox(
            height: _size.height * 0.04,
          ),
          textFormField(_primaryColor, _size.height * 0.06, 'Hostel Owner Name',
              globals.owner, true),
          SizedBox(
            height: _size.height * 0.04,
          ),
          textFormField(_primaryColor, _size.height * 0.06, 'Phone Number',
              globals.phone, true),
          SizedBox(
            height: _size.height * 0.04,
          ),
          textFormField(_primaryColor, _size.height * 0.06, "District",
              globals.district, true),
          SizedBox(
            height: _size.height * 0.04,
          ),
          textFormField(
              _primaryColor, _size.height * 0.06, "City", globals.city, true),
          SizedBox(
            height: _size.height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: _size.height * 0.15,
                width: _size.width * 0.35,
                child: DropdownFormField(
                  hostelType: hostelType,
                  data: 'Boys/Girls',
                  title: 'Gender',
                  globalVar: globals.gender,
                ),
              ),
              //Registered Year
              // SizedBox(
              //   height: _size.height * 0.15,
              //   width: _size.width * 0.5,
              //   child: textFormField(_primaryColor, _size.height * 0.075,
              //       "Registered Year", globals.registered_year,true),
              // ),
            ],
          ),
          SizedBox(
            height: _size.height * 0.04,
          ),
          //Hostel Category
          // DropdownFormField(hostelType: hostelCategory, data: 'Five Star Hostel',title: 'Category',globalVar: globals.category),
          SizedBox(
            height: _size.height * 0.04,
          ),
          textFormField(_primaryColor, _size.height * 0.06,
              "Total Number of Students", globals.total_students, true),
          SizedBox(
            height: _size.height * 0.04,
          ),
          textFormField(_primaryColor, _size.height * 0.06,
              "Total Number of Rooms", globals.total_rooms, true),
          SizedBox(
            height: _size.height * 0.04,
          ),
          textFormField(_primaryColor, _size.height * 0.06, "Starting price",
              globals.starting_price, true),
          SizedBox(
            height: _size.height * 0.05,
          ),
          multipleLineTextField(_primaryColor, _size, "Enter the Description",
              globals.description),
          SizedBox(
            height: _size.height * 0.05,
          ),
          //Student Per Room
          // Text(
          //   "Student per room",
          //   style: TextStyle(color: Colors.white),
          // ),
          // SizedBox(
          //   height: _size.height * 0.05,
          // ),
          Center(
            child: Row(
              children: [
                SizedBox(
                  width: 130,
                  child: TextButton(
                    onPressed: () {
                      selectLogo();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 85, 108, 148)),
                    child: Row(
                      children: [
                        Text(
                          'Upload Logo',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.upload,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                isLogo
                    ? Text(
                        "Logo Image",
                        style: TextStyle(color: Colors.white),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          sitter(context, _primaryColor, '1', _size, globals.sitter1,
              globals.descriptionSitter1),
          sitter(context, _primaryColor, '2', _size, globals.sitter2,
              globals.descriptionSitter2),
          sitter(context, _primaryColor, '3', _size, globals.sitter3,
              globals.descriptionSitter3),
          sitter(context, _primaryColor, '4', _size, globals.sitter4,
              globals.descriptionSitter4),
          sitter(context, _primaryColor, '5', _size, globals.sitter5,
              globals.descriptionSitter5),
          sitter(context, _primaryColor, '6', _size, globals.sitter6,
              globals.descriptionSitter6),

          Text(
            'Optional',
            style: TextStyle(
                color: Colors.white,
                fontSize: _size.width * 0.07,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: _size.height * 0.03,
          ),
          //Googel Map
          // textFormField(_primaryColor, _size.height * 0.06,
          //     "Map link from google map", globals.map,false),
          // SizedBox(
          //   height: _size.height * 0.04,
          // ),
          textFormField(_primaryColor, _size.height * 0.06,
              "Facebook Account Name", globals.facebook, false),
          SizedBox(
            height: _size.height * 0.04,
          ),
          textFormField(_primaryColor, _size.height * 0.06,
              "Instagram Account Name", globals.instagram, false),
          SizedBox(
            height: _size.height * 0.04,
          ),
        ],
      ),
    );
  }

  AnimatedContainer sitter(BuildContext context, Color _primaryColor,
      String index, Size sizee, sitter, description) {
    return AnimatedContainer(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      height:
          globals.sitters[index] ? sizee.height * 0.45 : sizee.height * 0.12,
      duration: Duration(
        milliseconds: 400,
      ),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        child: Card(
          elevation: 7.0,
          color: Theme.of(context).primaryColor,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CheckboxListTile(
                checkColor: _primaryColor,
                activeColor: const Color.fromARGB(255, 85, 108, 148),
                title: Text(
                  '$index sitter',
                  style: TextStyle(color: Colors.white),
                ),
                value: globals.sitters[index],
                onChanged: (value) {
                  setState(() {
                    globals.sitters['$index'] = value!;
                    if (value == false) {
                      description.clear();
                      sitter.clear();
                    }
                    // expanded[index] = !expanded[index];
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              AnimatedContainer(
                color: Theme.of(context).primaryColor,
                duration: Duration(milliseconds: 400),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: globals.sitters[index] ? sizee.height * 0.35 : 0.0,
                child: ListView(
                  children: [
                    multipleLineTextField(_primaryColor, sizee,
                        "Enter the Description", description),
                    SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: SizedBox(
                        width: 130,
                        child: TextButton(
                          onPressed: () {
                            selectImage(sitter);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 85, 108, 148)),
                          child: Row(
                            children: [
                              Text(
                                'Upload Image',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.upload,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownFormField extends StatelessWidget {
  DropdownFormField({
    Key? key,
    required this.hostelType,
    required this.data,
    required this.title,
    required this.globalVar,
  }) : super(key: key);

  final List<String> hostelType;
  final String data;
  final String title;
  var globalVar;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 6),
        DropdownButtonFormField(
          hint: Text(
            data,
            style: TextStyle(color: Colors.black),
          ),
          onChanged: (value) {
            globalVar = hostelType.indexWhere((element) => element == value);
            print(globalVar);
          },
          // value: 'Boys',
          items: hostelType.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              child: Text(value),
              value: value,
            );
          }).toList(),
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.red,
              )),
              filled: true,
              fillColor: Colors.white),
        ),
      ],
    );
  }
}

Widget textFormField(primaryColor, size, hintText, controller, bool required) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          SizedBox(
            width: size * 0.02,
          ),
          Text(
            hintText,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      SizedBox(
        height: size * 0.02,
      ),
      TextFormField(
        controller: controller,
        cursorColor: primaryColor,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: primaryColor),
            border: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.red,
            )),
            filled: true,
            fillColor: Colors.white),
        validator: (value) {
          if (required == true) {
            if (value!.isEmpty) {
              return '$hintText shouldn\'t be empty';
            }
          }
        },
      ),
    ],
  );
}

Widget multipleLineTextField(
    primaryColor, sizee, hintText, descriptionController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          SizedBox(
            width: sizee.width * 0.01,
          ),
          Text(
            hintText,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      SizedBox(
        height: sizee.height * 0.02,
      ),
      TextFormField(
        controller: descriptionController,
        minLines: 3,
        maxLines: 4,
        cursorColor: primaryColor,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: primaryColor),
            border: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.red,
            )),
            filled: true,
            fillColor: Colors.white),
        validator: (value) {
          if (value!.isEmpty) {
            return '$hintText shouldn\'t be empty';
          }
        },
      ),
    ],
  );
}

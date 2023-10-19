import 'package:emulatorapp/constants/constants.dart';
import 'package:emulatorapp/constants/size_config.dart';
import 'package:emulatorapp/models/search_model.dart';
import 'package:emulatorapp/providers/hostel_provider.dart';
import 'package:emulatorapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({Key? key}) : super(key: key);

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  String genderDropValue = 'Male';
  String parkingDropValue = 'Available';
  String ratingDropValue = "1 Starred";

  TextEditingController _districtController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _hostelIdController = TextEditingController();
  TextEditingController _hostelNameController = TextEditingController();
  TextEditingController _sitterController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Padding fieldTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 10.0, top: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: SizeConfig.blockSizeVertical! * 1.6,
        ),
      ),
    );
  }

  void onSearch() {
    if (_formKey.currentState!.validate()) {
      Provider.of<HostelProvider>(context, listen: false).getSearchHostel(
        SearchModel(
          _districtController.text,
          _cityController.text,
          _hostelIdController.text,
          _hostelNameController.text,
          _sitterController.text,
          genderDropValue,
          parkingDropValue,
          ratingDropValue,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1000),
          backgroundColor: Colors.green,
          content: Text("Most Relevant Searches"),
        ),
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => HomeScreen(isSearch: true)));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hostelIdController.text = "0";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _hostelIdController.dispose();
    _hostelNameController.dispose();
    _sitterController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Search For Hostel",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical! * 1.8,
                        ),
                      ),
                    ),
                  ),
                  fieldTitle("District"),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                    controller: _districtController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: kAccentColor,
                      filled: true,
                      contentPadding: const EdgeInsets.only(left: 12),
                      hintText: "District",
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  fieldTitle("City"),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                    controller: _cityController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.only(left: 20),
                      fillColor: kAccentColor,
                      filled: true,
                      hintText: "City",
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  fieldTitle("Hostel Id (Optional)"),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                    controller: _hostelIdController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: kAccentColor,
                      filled: true,
                      contentPadding: const EdgeInsets.only(left: 12),
                      hintText: "Hostel Id (Optional)",
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  fieldTitle("Hostel Name"),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                    controller: _hostelNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: kAccentColor,
                      filled: true,
                      contentPadding: const EdgeInsets.only(left: 12),
                      hintText: "Hostel Name",
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  fieldTitle("Sitter"),
                  TextFormField(
                    controller: _sitterController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: kAccentColor,
                      filled: true,
                      contentPadding: const EdgeInsets.only(left: 12),
                      hintText: "Sitter",
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  fieldTitle("Gender"),
                  genderDropdown(context),
                  fieldTitle("Parking"),
                  parkingDropdown(context),
                  fieldTitle("Rating"),
                  ratingDropdown(context),
                  SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        onSearch();
                      },
                      child: const Text('Search Now'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 16)),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container ratingDropdown(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 45),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: Theme.of(context).accentColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: ratingDropValue,
          icon: const Icon(Icons.arrow_drop_down, size: 30),
          elevation: 16,
          style: const TextStyle(color: Colors.black, fontSize: 15),
          underline: Container(
            height: 2,
          ),
          onChanged: (String? newValue) {
            setState(() {
              ratingDropValue = newValue!;
            });
          },
          items: <String>[
            '1 Starred',
            '2 Starred',
            '3 Starred',
            '4 Starred',
            '5 Starred',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Container parkingDropdown(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 45),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: Theme.of(context).accentColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: parkingDropValue,
          icon: const Icon(Icons.arrow_drop_down, size: 30),
          elevation: 16,
          style: const TextStyle(color: Colors.black, fontSize: 15),
          underline: Container(
            height: 2,
          ),
          onChanged: (String? newValue) {
            setState(() {
              parkingDropValue = newValue!;
            });
          },
          items: <String>['Available', 'Not Available']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Container genderDropdown(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 45,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: kAccentColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: genderDropValue,
          icon: const Icon(Icons.arrow_drop_down, size: 30),
          elevation: 16,
          style: const TextStyle(color: Colors.black, fontSize: 15),
          underline: Container(
            height: 2,
          ),
          onChanged: (String? newValue) {
            setState(() {
              genderDropValue = newValue!;
            });
          },
          items: <String>['Male', 'Female', 'Others']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

import 'package:emulatorapp/models/hostel.dart';
import 'package:emulatorapp/models/search_model.dart';
import 'package:emulatorapp/services/hostel_service.dart';
import 'package:flutter/material.dart';

class HostelProvider with ChangeNotifier {
  final _service = HostelService();

  List<HostelModel> _featuredMaleHostelList = [];
  List<HostelModel> get featuredMaleHostelList => _featuredMaleHostelList;

  List<HostelModel> _featuredHostelList = [];
  List<HostelModel> get featuredHostelList => _featuredHostelList;

  List<HostelModel> _featuredFemaleHostelList = [];
  List<HostelModel> get featuredFemaleHostelList => _featuredFemaleHostelList;

  List<HostelModel> _searchHostelList = [];

  List<HostelModel> get searchHostelList => _searchHostelList;

  int get getSearchHostelListLength => _searchHostelList.length;

  late SearchModel _searchHostel;

  Future<void> fetchAllHostels() async {
    _featuredHostelList.clear();
    _featuredFemaleHostelList.clear();
    _featuredMaleHostelList.clear();

    final response = await _service.fetchAllHostel();

    _featuredHostelList = response;

    for (int i = 0; i < _featuredHostelList.length; i++) {
      _featuredHostelList[i].gender == 2.toString()
          ? _featuredFemaleHostelList.add(_featuredHostelList[i])
          : _featuredMaleHostelList.add(_featuredHostelList[i]);
    }
  }

  void getSearchHostel(SearchModel searchHostel) {
    _searchHostelList.clear();
    _searchHostel = searchHostel;

    print(_searchHostel.city);

    for (var hostel in _featuredHostelList) {
      if (hostel.id.toString() == searchHostel.hostelId ||
          hostel.city.toLowerCase() == searchHostel.city.toLowerCase() &&
              hostel.district!.toLowerCase() ==
                  searchHostel.district.toLowerCase() &&
              hostel.name.toLowerCase().replaceAll(' ', '') ==
                  searchHostel.hostelName.toLowerCase().replaceAll(' ', '')) {
        _searchHostelList.add(hostel);
        notifyListeners();
      }
    }
    // for (var i = 0; i < _featuredHostelList.length; i++) {
    //   if (_featuredHostelList[i].district?.toLowerCase() ==
    //               _searchHostel.district.toLowerCase() &&
    //           _featuredHostelList[i].city.toLowerCase() ==
    //               _searchHostel.city.toLowerCase() ||
    //       _featuredFemaleHostelList[i].name.toLowerCase() ==
    //           _searchHostel.hostelName.toLowerCase() ||
    //       _featuredHostelList[i].id.toString() == _searchHostel.hostelId ||
    //       _featuredHostelList[i].gender == _searchHostel.gender) {
    //     _searchHostelList.add(_featuredHostelList[i]);
    //     notifyListeners();
    //   }
    // }
  }
}

import 'package:emulatorapp/models/hostel_detail.dart';
import 'package:emulatorapp/services/hostel_detail_service.dart';
import 'package:flutter/material.dart';

class HostelDetailProvider with ChangeNotifier {
  final _service = HostelDetailsService();

  late HostelDetailModel _hostelDetailData;

  HostelDetailModel get hostelDetailData => _hostelDetailData;

  final List<String> _hostelFeatures = [];

  List<String> get hostelFeatures => _hostelFeatures;

  Future<void> fetchHostelData(String slug) async {
    print("object");
    final response = await _service.fetchAllHostelData(slug);

    _hostelDetailData = response;

    _hostelFeatures.clear();
    for (int i = 0; i < _hostelDetailData.features.length; i++) {
      _hostelFeatures.add(_hostelDetailData.features[i]["name"]);
    }
    print(_hostelFeatures);
    print(_hostelDetailData.city);
  }
}

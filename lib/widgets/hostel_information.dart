import 'package:emulatorapp/constants/constants.dart';
import 'package:emulatorapp/constants/size_config.dart';
import 'package:emulatorapp/local_Storage/local_storage.dart';
import 'package:emulatorapp/models/hostel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Hostel_info extends StatefulWidget {
  Hostel_info({Key? key, required this.hostelData}) : super(key: key);

  final HostelModel hostelData;

  // final String ownerName;
  // final String hostelName;
  // final String phoneNum;
  // final String location;
  // final String slug;
  // final String price;
  // final String gender;

  @override
  State<Hostel_info> createState() => _Hostel_infoState();
}

class _Hostel_infoState extends State<Hostel_info> {
  bool _isFavourite = false;

  void addFavouriteHostel(HostelModel hostelData) {
    final db = Db.getData();
    db.put(hostelData.id, hostelData);
    hostelData.save();
  }

  void removeFavouriteHostel(HostelModel hostelData) {
    final db = Db.getData();
    final data = db.values.toList().cast<HostelModel>();
    final eindex = data.indexWhere((element) => element.id == hostelData.id);
    // var eHostelData = data[eindex];
    db.deleteAt(eindex);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.hostelData.name,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical! * 2.6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: SizeConfig.blockSizeVertical! * 3,
                  ),
                  Text(
                    '4.7',
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical! * 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10.0),
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      _isFavourite = !_isFavourite;
                    },
                  );
                  final hostelData = HostelModel(
                      id: widget.hostelData.id,
                      name: widget.hostelData.name,
                      logo: widget.hostelData.logo,
                      city: widget.hostelData.city,
                      gender: widget.hostelData.gender,
                      slug: widget.hostelData.slug,
                      phoneNumber: widget.hostelData.phoneNumber,
                      district: widget.hostelData.district,
                      startingPrice: widget.hostelData.startingPrice,
                      ownerName: widget.hostelData.ownerName);
                  _isFavourite
                      ? addFavouriteHostel(hostelData)
                      : removeFavouriteHostel(hostelData);
                },
                icon: Icon(
                  Icons.favorite,
                  color: _isFavourite ? Colors.red : Colors.grey,
                  size: kHeartIconSize,
                ),
              )
            ],
          ),
          FittedBox(
            child: Text(
              "${widget.hostelData.city} \t Starting Price: ${widget.hostelData.startingPrice}",
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical! * 2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    // gender == "1"
                    //     ? "Girls Hostel | ${widget.phoneNum}"
                    //     : "Boys Hostel | ${widget.phoneNum}",
                    "Boys Hostel | ${widget.hostelData.phoneNumber}",
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical! * 1.8,
                      // letterSpacing: 0.4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrlString('tel:${widget.hostelData.phoneNumber}');
                  },
                  child: Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.call,
                        size: SizeConfig.blockSizeVertical! * 3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: SizeConfig.blockSizeHorizontal! * 5,
                  ),
                  Text(
                    widget.hostelData.ownerName!,
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical! * 1.9,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10.0),
              Icon(
                Icons.bed_rounded,
                size: SizeConfig.blockSizeHorizontal! * 5,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                '3 Beds in total',
                textScaleFactor: 1,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.blockSizeVertical! * 2,
                ),
              ),
            ],
          ),
          const Divider(thickness: 1, height: 10),
        ],
      ),
    );
  }
}

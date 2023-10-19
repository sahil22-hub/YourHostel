import 'package:emulatorapp/constants/constants.dart';
import 'package:emulatorapp/constants/size_config.dart';
import 'package:emulatorapp/local_Storage/local_storage.dart';
import 'package:emulatorapp/models/hostel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:emulatorapp/screens/hostel_screen.dart';

class HostelWidget extends StatefulWidget {
  final HostelModel hostelData;

  HostelWidget(
    this.hostelData,
  );

  @override
  State<HostelWidget> createState() => _HostelWidgetState();
}

class _HostelWidgetState extends State<HostelWidget> {
  var favHostelNumber = 0;
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
    var slug = widget.hostelData.slug; // id of hostel
    final _size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HostelScreen(
              widget.hostelData,
              // widget.favHostel,
            ),
          ),
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.3, color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 240, 240, 240),
                blurRadius: 2.0, // soften the shadow
                // spreadRadius: 2.0, //extend the shadow
                offset: Offset(
                  0.0, // Move to right 10  horizontally
                  1.0 // Move to bottom 10 Vertically
                  ,
                ),
              ),
            ]),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: SizedBox(
                      width: _size.width * 0.6,
                      height: _size.height * 0.15,
                      child: Image(
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Image.asset(
                            'assets/images/your_hostel_logo_grey.png',
                            fit: BoxFit.cover,
                          );
                        },
                        image: NetworkImage(
                          widget.hostelData.logo,
                        ),
                      )),
                ),
                Positioned(
                  right: 10,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFavourite = !_isFavourite;
                      });
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
                    child: Icon(
                      Icons.favorite,
                      size: kHeartIconSize,
                      color: _isFavourite ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          // width: 1000,
                          child: Text(
                            widget.hostelData.name,
                            textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical! * 2.2,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.orangeAccent,
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
                    ],
                  ),
                  const SizedBox(height: 7.0),
                  FittedBox(
                    child: Text(
                      widget.hostelData.city,
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical! * 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 7.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.hostelData.phoneNumber} (Rs${widget.hostelData.startingPrice})',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical! * 1.7,
                          ),
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.arrowRightToBracket,
                        color: Colors.green,
                        size: SizeConfig.blockSizeVertical! * 2.2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

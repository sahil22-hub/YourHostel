import 'package:cached_network_image/cached_network_image.dart';
import 'package:emulatorapp/constants/constants.dart';
import 'package:emulatorapp/constants/size_config.dart';
import 'package:emulatorapp/local_Storage/local_storage.dart';
import 'package:emulatorapp/models/hostel.dart';
import 'package:emulatorapp/screens/hostel_screen.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/material.dart';

class FavouriteHostelScreen extends StatefulWidget {
  static const routeName = '/favourite-hostel';
  const FavouriteHostelScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteHostelScreen> createState() => _FavouriteHostelScreenState();
}

class _FavouriteHostelScreenState extends State<FavouriteHostelScreen> {
  void removeHostel(HostelModel hostelModel) async {
    await hostelModel.delete();
  }

  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Favourite Hostels"),
        backgroundColor: kPrimaryColor,
      ),
      body: ValueListenableBuilder<Box<HostelModel>>(
        valueListenable: Db.getData().listenable(),
        builder: (context, db, _) {
          final hostelData = db.values.toList().cast<HostelModel>();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                childAspectRatio:
                    SizeConfig.screenWidth! / (SizeConfig.screenHeight! / 1.5),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HostelScreen(
                          hostelData[index],
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
                            // CachedNetworkImage(
                            //   key: UniqueKey(),
                            //   imageUrl: "https://via.placeholder.com/300x300",
                            //   width: SizeConfig.screenWidth! * 0.6,
                            //   height: SizeConfig.screenHeight! * 0.15,
                            //   fit: BoxFit.cover,
                            // ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: SizedBox(
                                  width: SizeConfig.screenWidth! * 0.6,
                                  height: SizeConfig.screenHeight! * 0.15,
                                  child: Image(
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Image.asset(
                                        'assets/images/your_hostel_logo_grey.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    image: CachedNetworkImageProvider(
                                      hostelData[index].logo,
                                    ),
                                  )),
                            ),
                            Positioned(
                                right: 10,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    removeHostel(hostelData[index]);
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    size: kHeartIconSize,
                                    color: Colors.red,
                                  ),
                                )),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      // width: 1000,
                                      child: Text(
                                        hostelData[index].name,
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeVertical! *
                                                  2.2,
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
                                          fontSize:
                                              SizeConfig.blockSizeVertical! * 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7.0),
                              FittedBox(
                                child: Text(
                                  hostelData[index].city,
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
                                      '${hostelData[index].phoneNumber} (Rs9000)',
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical! * 1.7,
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
              },
              itemCount: db.length,
            ),
          );
        },
      ),
    );
  }
}

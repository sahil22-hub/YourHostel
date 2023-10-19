import 'package:emulatorapp/constants/constants.dart';
import 'package:emulatorapp/constants/size_config.dart';
import 'package:emulatorapp/models/hostel.dart';
import 'package:emulatorapp/providers/featured_hostel.dart';
import 'package:emulatorapp/screens/hostel_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchbarItem extends StatelessWidget {
  final HostelModel hostelList;
  // final List<String> favHostel; edit now
  SearchbarItem(
    this.hostelList,
    // this.favHostel, edit now
  );
  @override
  Widget build(BuildContext context) {
    var _primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HostelScreen(
              hostelList,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 12, bottom: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
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
                            hostelList.logo,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hostelList.name,
                            textScaleFactor: 1.2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: _primaryColor,
                                fontSize: kTitleFontSize,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            hostelList.city,
                            textScaleFactor: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: kSubtitleFontSize,
                                color: _primaryColor,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 6.0),
                          Row(
                            children: [
                              Text(
                                hostelList.gender == "1" ? "Male" : "Female",
                                textScaleFactor: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: kSubtitleFontSize,
                                    // fontStyle: FontStyle.italic,
                                    color: _primaryColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              Icon(
                                hostelList.gender == '1'
                                    ? Icons.male
                                    : Icons.female,
                                color: hostelList.gender == '1'
                                    ? kPrimaryColor
                                    : Colors.pinkAccent,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

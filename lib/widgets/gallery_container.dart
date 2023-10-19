import 'package:emulatorapp/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:emulatorapp/widgets/Bedrooms.dart';
import 'package:emulatorapp/widgets/Dinings.dart';
import 'package:emulatorapp/widgets/Kitchen.dart';

class GalleyContainer extends StatelessWidget {
  const GalleyContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hostel Gallery',
            textScaleFactor: 1,
            style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical! * 2.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Bedrooms(category: 'Bedroom'),
                  const SizedBox(width: 8),
                  Kitchen(
                    category: 'Kitchen',
                  ),
                  const SizedBox(width: 8),
                  Dinings(category: 'Dinings'),
                  const SizedBox(width: 8),
                  // HostelPictures(category: 'Gyms'),
                ],
              ),
            ),
          ),
          const Divider(thickness: 1.0, height: 10.0),
        ],
      ),
    );
  }
}

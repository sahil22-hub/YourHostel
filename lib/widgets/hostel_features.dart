import 'package:emulatorapp/constants/constants.dart';
import 'package:emulatorapp/constants/size_config.dart';
import 'package:flutter/material.dart';

class HostelFeatures extends StatelessWidget {
  final List hostelFeatures;
  HostelFeatures({
    Key? key,
    required this.hostelFeatures,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
      // margin: const EdgeInsets.fromLTRB(0, 12.0, 0, 0),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Title(
            color: Colors.black,
            child: Text(
              'Features',
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical! * 2.2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                childAspectRatio:
                    SizeConfig.screenWidth! / (SizeConfig.screenHeight! / 14),
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_box,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          child: Text(
                            // "tiyfuytfbvuyduyrdvyrdcytrsytcsyts",
                            hostelFeatures[index],
                            style: TextStyle(
                              fontSize: kTitleFontSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: hostelFeatures.length),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

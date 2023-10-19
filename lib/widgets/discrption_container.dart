import 'package:emulatorapp/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DescriptionContainer extends StatefulWidget {
  final String description;
  const DescriptionContainer({Key? key, required this.description})
      : super(key: key);

  @override
  State<DescriptionContainer> createState() => _DescriptionContainerState();
}

class _DescriptionContainerState extends State<DescriptionContainer> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical! * 2.2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            ReadMoreText(
              widget.description,
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical! * 2,
              ),
              trimLines: 5,
              colorClickableText: Colors.black,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              lessStyle: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical! * 1.8,
                fontWeight: FontWeight.bold,
              ),
              moreStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical! * 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

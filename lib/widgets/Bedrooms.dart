import 'package:emulatorapp/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:emulatorapp/widgets/GalleryWidget.dart';

class Bedrooms extends StatelessWidget {
  final category;

  Bedrooms({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return GestureDetector(
        onTap: () {
          showSlidingBottomSheet(
            context,
            builder: (context) => const SlidingSheetDialog(
              headerBuilder: buildHeader,
              cornerRadius: 18,
              snapSpec: SnapSpec(
                snappings: [0.5, 0.8],
              ),
              builder: buildSheet,
            ),
          );
        },
        child: Container(
          height: _size.height * 0.04,
          width: _size.width / 3.5,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
              child: Text(
            category,
            textScaleFactor: 1,
            style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical! * 1.8,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
        ));
  }
}

Widget buildSheet(context, state) => Material(
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.15,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) => showImages(
          index: index,
        ),
        itemCount: 6,
      ),
    );

Widget buildHeader(BuildContext context, SheetState state) => Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Container(
                width: 40,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );

class showImages extends StatelessWidget {
  final int index;
  showImages({
    this.index = 0,
  });
  final imagesGallery = [
    'assets/images/bedrooms/h1.jpg',
    'assets/images/bedrooms/h2.jpg',
    'assets/images/bedrooms/h3.jpg',
    'assets/images/bedrooms/h4.jpg',
    'assets/images/bedrooms/h5.jpg',
    'assets/images/bedrooms/h6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return InkWell(
      child: Ink.image(
        image: AssetImage(imagesGallery[index]),
        fit: BoxFit.cover,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => GalleryWidget(
              imagesGallery: imagesGallery,
              index: index,
            ),
          ),
        );
      },
    );
  }
}

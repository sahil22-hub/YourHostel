import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryWidget extends StatefulWidget {
  final PageController pageController;
  final int index;
  final List<String> imagesGallery;
  GalleryWidget({
    required this.imagesGallery,
    this.index = 0,
  }) : pageController = PageController(initialPage: index);
  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: GestureDetector(
        // onTap: () {
        //   showGeneralDialog(
        //       context: context,
        //       barrierDismissible: true,
        //       transitionDuration: Duration(milliseconds: 300),
        //       barrierLabel: MaterialLocalizations.of(context).dialogLabel,
        //       barrierColor: Colors.black.withOpacity(0),
        //       pageBuilder: (context, _, __) {
        //         return Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Container(
        //               width: double.infinity,
        //               color: Colors.black.withOpacity(0),
        //               child: Card(
        //                 color: Colors.black.withOpacity(0),
        //                 child: ListView(
        //                   shrinkWrap: true,
        //                   children: [
        //                     SizedBox(height: 15),
        //                     Container(
        //                       color: Colors.black.withOpacity(0),
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           IconButton(
        //                             onPressed: () {
        //                               Navigator.popAndPushNamed(
        //                                   context, MainScreen.routeName);
        //                               //  Navigator.pop(context);
        //                             },
        //                             icon: Icon(
        //                               Icons.arrow_back,
        //                               color: Colors.white,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     )
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         );
        //       },
        //       transitionBuilder:
        //           (context, animation, secondaryanimation, child) {
        //         return SlideTransition(
        //           position: CurvedAnimation(
        //             parent: animation,
        //             curve: Curves.easeInOutCubic,
        //           ).drive(
        //             Tween<Offset>(
        //               begin: Offset(0, -1.0),
        //               end: Offset.zero,
        //             ),
        //           ),
        //           child: child,
        //         );
        //       });
        // },
        child: Column(
          children: [
            Expanded(
              child: PhotoViewGallery.builder(
                pageController: widget.pageController,
                itemCount: widget.imagesGallery.length,
                builder: (context, index) {
                  final imageGallery = widget.imagesGallery[index];
                  return PhotoViewGalleryPageOptions(
                    imageProvider: AssetImage(imageGallery),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 4,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

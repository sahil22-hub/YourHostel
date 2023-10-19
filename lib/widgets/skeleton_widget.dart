import 'package:flutter/material.dart';

class SkeletonWidget extends StatelessWidget {
  const SkeletonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //         crossAxisAlignment:CrossAxisAlignment.start,
        //         children: [
        //           Container(
        //             height: 100,
        //             width: 180,
        //               decoration: BoxDecoration(
        //                 color: Colors.grey[300],
        //                 borderRadius: BorderRadius.circular(10.0)
        //               ),
        //           ),
        //           SizedBox(
        //             height: 10,
        //           ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Container(
        //                 height: 20,
        //                 width: 100,
        //                   decoration: BoxDecoration(
        //                     color: Colors.grey[300],
        //                   ),
        //               ),
        //               Container(
        //                 height: 20,
        //                 width: 40,
        //                   decoration: BoxDecoration(
        //                     color: Colors.grey[300],
        //                   ),
        //               ),
        //             ],
        //           ),
        //           SizedBox(height: 2.0,),
        //         Container(
        //                 height: 20,
        //                 width: 40,
        //                   decoration: BoxDecoration(
        //                     color: Colors.grey[300],
        //                   ),
        //               ),
        //               SizedBox(
        //             height: 10,
        //           ),
        //            Container(
        //                 height: 20,
        //                 width: 60,
        //                   decoration: BoxDecoration(
        //                     color: Colors.grey[300],
        //                   ),
        //               ),
        //               SizedBox(
        //             height: 10,
        //           ),
        //            Container(
        //                 height: 20,
        //                 width: 100,
        //                   decoration: BoxDecoration(
        //                     color: Colors.grey[300],
        //                   ),
        //               ),
        //         ],
        //       ),
        // );
        GridView.builder(
      // physics: ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        childAspectRatio: 0.72,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _size.height >12000 ? 6 :4,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          skeleton(100.toDouble(), 180.toDouble()),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              skeleton(20.toDouble(), 100.toDouble()),
              skeleton(20.toDouble(), 40.toDouble()),
            ],
          ),
          SizedBox(
            height: 2.0,
          ),
          skeleton(20.toDouble(), 60.toDouble()),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              skeleton(20.toDouble(), 120.toDouble()),
              skeleton(20.toDouble(), 30.toDouble()),
            ],
          ),
        ],
      ),
    );
  }

  Container skeleton(height, width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

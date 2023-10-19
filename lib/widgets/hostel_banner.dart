import 'package:flutter/material.dart';

class HostelBanner extends StatelessWidget {
  final String img;
  const HostelBanner({
    Key? key,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: _size.width,
          height: _size.height / 4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: _size.width,
          height: _size.height / 4,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black12, Colors.black26],
            ),
          ),
        ),

        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 3, vertical: 12),
        //   height: _size.height / 5,
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: [
        //       Hostel_Flex(size: _size, img: 'h1'),
        //       SizedBox(width: 10),
        //       Hostel_Flex(size: _size, img: 'h4'),
        //       SizedBox(width: 10),
        //       Hostel_Flex(size: _size, img: 'h3'),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

// class Hostel_Flex extends StatelessWidget {
//   const Hostel_Flex({
//     Key? key,
//     required Size size,
//     required String img,
//   })  : _size = size,
//         _img = img,
//         super(key: key);

//   final Size _size;
//   final String _img;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         width: _size.width / 2,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(7.0),
//           image: DecorationImage(
//             image: AssetImage('assets/images/$_img.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }

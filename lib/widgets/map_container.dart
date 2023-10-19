import 'package:emulatorapp/constants/size_config.dart';
import 'package:emulatorapp/screens/Login.dart';
import 'package:flutter/material.dart';

class MapContainer extends StatelessWidget {
  const MapContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/hostel_map.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => login()));
            },
            child: Center(
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Center(
                    child: Text(
                  'Book Hostel',
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.blockSizeVertical! * 2,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

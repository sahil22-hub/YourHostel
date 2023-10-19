import 'package:emulatorapp/constants/size_config.dart';
import 'package:flutter/material.dart';

class NetworkErrorMessage extends StatelessWidget {
  const NetworkErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60),
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage("assets/images/no_connction.png"),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Column(
            children: const [
              Text(
                "Oops",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Something goes wrong.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              Text(
                "Check you connection and try again.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}

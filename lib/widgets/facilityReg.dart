import 'package:flutter/material.dart';

class FacilityReg extends StatefulWidget {
  @override
  State<FacilityReg> createState() => _FacilityRegState();
}

class _FacilityRegState extends State<FacilityReg> {
  Map<String, bool> facilities = {
    'Garden': false,
    'Parking': false,
    'Hot Shower': false,
    'Doorman': false,
    'High Ceiling': false,
    'Laundry': false,
    'Bright Room': false,
    'Alarm System': false,
    'AC': false,
  };
  List facilityIndex = [
    'Garden',
    'Parking',
    'Hot Shower',
    'Doorman',
    'High Ceiling',
    'Laundry',
    'Bright Room',
    'Alarm System',
    'AC'
  ];

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _primaryColor = Theme.of(context).primaryColor;
    return Container(
      height: _size.height * 0.62,
      // color: Colors.green,
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: 300,
        //     crossAxisSpacing: 20,
        //     mainAxisSpacing: 25,
        //     mainAxisExtent: 60),
        itemCount: facilityIndex.length,
        itemBuilder: (context, index) {
          return selectFacility(index, _primaryColor);
        },
      ),
    );
  }

  Widget selectFacility(index, primaryColor) {
    return Column(
      children: [
        Card(
          elevation: 5.0,
          color: const Color.fromARGB(255, 38, 60, 102),
          child: CheckboxListTile(
              // tileColor: Colors.white,
              // selectedTileColor: Color.fromRGBO(20, 39, 74, 1.0),
              checkColor: primaryColor,
              activeColor: const Color.fromARGB(255, 85, 108, 148),
              controlAffinity: ListTileControlAffinity.leading,
              subtitle: index < 4
                  ? const Text(
                      '*Required',
                      style: TextStyle(color: Colors.grey),
                    )
                  : null,
              title: Text(
                facilityIndex[index],
                style: const TextStyle(color: Colors.white),
              ),
              value: facilities[facilityIndex[index]],
              onChanged: (value) {
                setState(() {
                  facilities[facilityIndex[index]] = value!;
                });
              }),
        ),
        const SizedBox(
          height: 12.0,
        )
      ],
    );
  }
}

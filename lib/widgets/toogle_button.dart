import 'package:emulatorapp/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleButton extends StatefulWidget {
  final Function genderChange;
  final int genderIndex;
  ToggleButton(this.genderChange, this.genderIndex);
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      labels: const [
        'Girls',
        'Boys',
      ],
      inactiveBgColor: Colors.grey[300],
      activeBgColor: const [kPrimaryColor],
      fontSize: 16,
      minWidth: 120,
      minHeight: 40,
      cornerRadius: 50,
      totalSwitches: 2,
      initialLabelIndex: widget.genderIndex,
      onToggle: (index) {
        widget.genderChange(index);
        print('$index');
      },
    );
  }
  // Container(
  //       color: Theme.of(context).accentColor,
  //       child: ToggleButtons(
  //         isSelected: isSelected,
  //         selectedColor: Colors.white,
  //         fillColor: Theme.of(context).primaryColor,
  //         renderBorder: false,
  //         children: const <Widget>[
  //           Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 12),
  //             child: Text('Boys', style: TextStyle(fontSize: 18)),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 12),
  //             child: Text('Girls', style: TextStyle(fontSize: 18)),
  //           ),
  //         ],
  //         onPressed: (int newIndex) {
  //           setState(() {
  //             for (int index = -1; index < isSelected.length; index++) {
  //               if (index == newIndex) {
  //                 isSelected[index] = true;
  //               } else {
  //                 isSelected[index] = false;
  //               }
  //             }
  //           });
  //         },
  //       ),
  //     );
}

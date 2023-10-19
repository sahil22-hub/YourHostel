import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emulatorapp/models/http_extention.dart';
import 'package:emulatorapp/providers/add_hostel.dart';
import 'package:emulatorapp/widgets/basicInfoReg.dart';
import 'package:emulatorapp/widgets/facilityReg.dart';
import 'package:emulatorapp/widgets/imageReg.dart';
import '../models/global_reg_data.dart' as globals;

class RegisterHostelScreen extends StatefulWidget {
  static const routeName = '/register-hostel';

  @override
  State<RegisterHostelScreen> createState() => _RegisterHostelScreenState();
}

class _RegisterHostelScreenState extends State<RegisterHostelScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final hostelType = ['Boys', 'Girls'];

  int currentStep = 0;
  late Map<dynamic, dynamic> basicInfoData;

  void setBasicInfo(basicInfo) {
    basicInfoData = basicInfo;
  }

  void _showErrorDialog(String message, String title, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Go to error page'),
            onPressed: () {
              Navigator.of(ctx).pop();
              print(MediaQuery.of(context).size.height);
              setState(() {
                currentStep = 0;
              });
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    print(globals.description.value.text);
    // if (!_formKey.currentState!.validate()) {
    //   _showErrorDialog('Please go through the data you have entered.','Invalid or Empty data entry fields!', context);
    //   return;
    // }
    _formKey.currentState!.save();
    BasicInfoReg(_formKey, setBasicInfo, true);
    try {
      print("object");
      print('kitchen length: ' + globals.gallery0.length.toString());
      print('bedroom length: ' + globals.gallery1.length.toString());
      print('bathroom length: ' + globals.gallery2.length.toString());
      await Provider.of<AddHostel>(context, listen: false).register();
      Navigator.of(context).pop();
    } on httpException catch (error) {
      _showErrorDialog(
        error.toString(),
        'An error occured!',
        context,
      );
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Either email or password invalid';
      _showErrorDialog(error.toString(), 'An error occured!', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Register Hostel',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: GestureDetector(
          onTap: (() => FocusScope.of(context).unfocus()),
          child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: const Color.fromRGBO(20, 39, 74, 1.0),
                colorScheme: const ColorScheme.light(
                    primary: Color.fromARGB(255, 85, 108, 148)),
              ),
              child: Stepper(
                currentStep: currentStep,
                type: StepperType.horizontal,
                steps: getSteps(_primaryColor, _size),
                onStepContinue: () {
                  setState(() {
                    final isLastStep = currentStep ==
                        getSteps(_primaryColor, _size).length - 1;
                    if (isLastStep) {
                      _submit(context);
                    } else
                      currentStep += 1;
                  });
                },
                onStepCancel: () {
                  setState(() {
                    currentStep == 0 ? null : currentStep -= 1;
                  });
                },
                onStepTapped: (step) {
                  setState(() {
                    currentStep = step;
                  });
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  final isLastStep =
                      currentStep == getSteps(_primaryColor, _size).length - 1;
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text(isLastStep ? 'CONFIRM' : 'NEXT'),
                          onPressed: details.onStepContinue,
                          // (){
                          // details.onStepContinue;
                          //   // BasicInfoReg(_formKey,setBasicInfo);
                          // }
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      if (currentStep != 0)
                        Expanded(
                          child: ElevatedButton(
                            child: const Text('BACK'),
                            onPressed: details.onStepCancel,
                          ),
                        ),
                    ]),
                  );
                },
              )),
        ),
      ),
    );
  }

  List<Step> getSteps(primaryColor, size) => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: const Text(
              'Basic Info',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            content: BasicInfoReg(_formKey, setBasicInfo, false)),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text(
            'Upload Image',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: SizedBox(
            height: size.height * 0.6,
            child: ImageReg(),
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text(
            'Facility',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: FacilityReg(),
        ),
      ];
}

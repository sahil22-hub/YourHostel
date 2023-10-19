import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home_screen.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    final _size = MediaQuery.of(context).size;
    return IntroductionScreen(
      globalBackgroundColor: Theme.of(context).primaryColor,
      pages: [
        PageViewModel(
          titleWidget: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find Hostel',
                textScaleFactor: 2,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // fontSize: 35.0,
                    color: Colors.white),
              ),
              SizedBox(
                height: _size.height * 0.03,
              )
            ],
          ),
          bodyWidget: const Text(
            'Simple and Easy way to find your \'Second Home\'',
            textScaleFactor: 1.7,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          image: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top * 2),
            child: Image.asset(
              'assets/images/findHostel_final.png',
              fit: BoxFit.cover,
            ),
          ),
          decoration: getPageDecoration(primaryColor),
        ),
        PageViewModel(
          titleWidget: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top * 2),
                child: Image.asset(
                  'assets/images/setLocation_final.png',
                  width: double.infinity,
                  height: _size.height * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: _size.height * 0.03,
              ),
              const Text(
                'Set Location',
                textScaleFactor: 2.0,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // fontSize: _size.height * 0.04,
                    color: Colors.white),
              ),
              // Text(
              //   'Hostel ?',
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: _size.height * 0.04,
              //       color: Colors.white),
              // ),
              const SizedBox(
                height: 15.0,
              )
            ],
          ),
          // title: 'Searching a Hostel ?',
          bodyWidget: const Text(
            'Stay home and find hostel at your preferable location.',
            textScaleFactor: 1.7,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          decoration: getPageDecoration(primaryColor),
        ),
        PageViewModel(
            // title: 'It\'s simple',
            bodyWidget: const Text(
              'Get to know about the hostel with just a click.',
              textScaleFactor: 1.7,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            titleWidget: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top * 1),
                  child: Image.asset(
                    'assets/images/settleIn_final.png',
                    // width: double.infinity,
                    height: _size.height * 0.41,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: _size.height * 0.03,
                ),
                const Text(
                  'Settle in',
                  textScaleFactor: 2.0,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: _size.height * 0.04,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 15.0,
                )
              ],
            ),
            decoration: getPageDecoration(primaryColor),
            footer: Padding(
              padding: EdgeInsets.only(top: _size.height * 0.06),
              child: InkWell(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);

                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  },
                  child: Container(
                    height: _size.height * 0.06,
                    width: _size.width * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Get Started',
                          textScaleFactor: 1.4,
                          style: TextStyle(
                              // fontSize: 22.0,
                              color: primaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(width: _size.width * 0.02),
                        Icon(
                          Icons.arrow_forward,
                          size: _size.height * 0.03,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  )),
            )),
      ],
      done: const Icon(
        Icons.arrow_forward,
        size: 25,
        color: Colors.white,
      ),
      onDone: () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('showHome', true);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      },
      dotsDecorator: getDotDecoration(primaryColor),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      nextFlex: 0,
      skipFlex: 0,
    );
  }

  PageDecoration getPageDecoration(primaryColor) => PageDecoration(
        pageColor: primaryColor,
        titleTextStyle: const TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        bodyTextStyle: const TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
        // imagePadding: const EdgeInsets.all(24),
      );

  DotsDecorator getDotDecoration(primaryColor) => DotsDecorator(
        color: Colors.grey,
        activeColor: Colors.white,
        size: const Size(10, 10),
        activeSize: const Size(20, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      );
}

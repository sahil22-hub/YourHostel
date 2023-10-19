import 'dart:io';
import 'package:emulatorapp/models/hostel.dart';
import 'package:emulatorapp/providers/hostel_detail.dart';
import 'package:emulatorapp/providers/hostel_provider.dart';
import 'package:emulatorapp/screens/favourite_hostel.dart';
import 'package:emulatorapp/screens/search_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emulatorapp/providers/add_hostel.dart';
import 'package:emulatorapp/providers/featured_hostel.dart';
import 'package:emulatorapp/providers/show_all_hostel.dart';
import 'onboarding/onboarding_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:emulatorapp/screens/home_screen.dart';
import 'package:emulatorapp/screens/register_hostel_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(HostelModelAdapter());

  await Hive.openBox<HostelModel>("favouriteHostels");

  HttpOverrides.global = MyHttpOverrides();

  runApp(YourHostel(showHome: showHome));
  // runApp(YourHostel(showHome: showHome));
}

class YourHostel extends StatelessWidget {
  final bool showHome;
  const YourHostel({
    Key? key,
    required this.showHome,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => FeaturedHostel(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AddHostel(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ShowAllHostel(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => HostelProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => HostelDetailProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(20, 39, 74, 1.0),
          accentColor: const Color.fromARGB(24, 115, 121, 120),
        ),
        home: showHome
            ? HomeScreen(
                isSearch: false,
              )
            : OnboardingPage(),
        // RegisterHostelScreen(),
        // NewSplashScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(
                isSearch: false,
              ),
          RegisterHostelScreen.routeName: (ctx) => RegisterHostelScreen(),
          SearchScreen.routeName: (context) => SearchScreen(),
          FavouriteHostelScreen.routeName: ((context) =>
              FavouriteHostelScreen())
          //    Example.routeName: (ctx) => Example(),
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

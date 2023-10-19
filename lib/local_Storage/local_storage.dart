import 'package:emulatorapp/models/hostel.dart';
import 'package:hive/hive.dart';

class Db {
  static Box<HostelModel> getData() => Hive.box("favouriteHostels");
}

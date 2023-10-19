import 'package:hive/hive.dart';

part 'hostel.g.dart';

@HiveType(typeId: 0)
class HostelModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String logo;
  @HiveField(3)
  String city;
  @HiveField(4)
  String gender;
  @HiveField(5)
  String slug;
  @HiveField(6)
  String phoneNumber;
  @HiveField(7)
  String? district;
  @HiveField(8)
  String? startingPrice;
  @HiveField(9)
  String? ownerName;

  HostelModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.city,
    required this.gender,
    required this.slug,
    required this.phoneNumber,
    required this.district,
    required this.startingPrice,
    required this.ownerName,
  });
}

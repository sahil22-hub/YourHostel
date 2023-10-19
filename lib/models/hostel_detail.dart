class HostelDetailModel {
  final int id;
  final String description;
  final String gender;
  final String hostelName;
  final String map;
  final String phone;
  final String district;
  final String city;
  final String owner;
  final List features;
  final List comments;
  final List googleReviews;
  final String starting_price;

  HostelDetailModel({
    required this.id,
    required this.description,
    required this.gender,
    required this.hostelName,
    required this.map,
    required this.phone,
    required this.district,
    required this.city,
    required this.owner,
    required this.features,
    required this.googleReviews,
    required this.starting_price,
    required this.comments,
  });
}

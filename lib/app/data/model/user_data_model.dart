class UserDataModel {
  final String id;
  final String fullName;
  final String email;
  final String gender;
  final DateTime dob;
  final String status;
  final String medal;
  final String? profileImage;
  final int uniqueKey;
  final int referralCode;
  final String street;
  final String town;
  final String city;
  final String state;
  final String country;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserDataModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.dob,
    required this.status,
    required this.medal,
    this.profileImage,
    required this.uniqueKey,
    required this.referralCode,
    required this.street,
    required this.town,
    required this.city,
    required this.state,
    required this.country,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      gender: json['gender'],
      dob: DateTime.parse(json['dob']),
      status: json['status'],
      medal: json['medal'],
      profileImage: json['profile_image'],
      uniqueKey: json['unique_key'],
      referralCode: json['referral_code'],
      street: json['street'],
      town: json['town'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'gender': gender,
      'dob': dob.toIso8601String(),
      'status': status,
      'medal': medal,
      'profile_image': profileImage,
      'unique_key': uniqueKey,
      'referral_code': referralCode,
      'street': street,
      'town': town,
      'city': city,
      'state': state,
      'country': country,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
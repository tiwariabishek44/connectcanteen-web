class UserDataResponse {
  final String userid;
  final String name;
  final String email;
  final String phone;
  final String groupid;
  final String classes;
  final String profilePicture;
  final int studentScore;
  final int fineAmount;
  final int miCoin;

  UserDataResponse({
    required this.classes,
    required this.userid,
    required this.name,
    required this.email,
    required this.phone,
    required this.groupid,
    required this.profilePicture,
    required this.studentScore,
    required this.fineAmount,
    required this.miCoin,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) {
    return UserDataResponse(
      userid: json['userid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone']?.toString() ?? '',
      groupid: json['groupid'] ?? '',
      classes: json['classes'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      studentScore: json['studentScore'] ?? 0,
      fineAmount: json['fineAmount'] ?? 0,
      miCoin: json['miCoin'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'name': name,
      'email': email,
      'phone': phone,
      'groupid': groupid,
      'classes': classes,
      'profilePicture': profilePicture,
      'studentScore': studentScore,
      'fineAmount': fineAmount,
      'miCoin': miCoin,
    };
  }
}

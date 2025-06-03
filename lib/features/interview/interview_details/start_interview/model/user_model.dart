class UserIdModel {
  final String? id;

  UserIdModel({this.id});

  factory UserIdModel.fromJson(Map<String, dynamic> json) {
    return UserIdModel(
      id: json['_id'] as String?,
    );
  }
}

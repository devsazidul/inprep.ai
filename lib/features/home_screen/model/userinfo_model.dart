class UserInfo {
  bool? success;
  String? message;
  Data? data;

  UserInfo({this.success, this.message, this.data});

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        if (data != null) 'data': data!.toJson(),
      };
}

class Data {
  String? sId;
  String? name;
  String? phone;
  String? email;
  String? experienceLevel;
  String? preferredInterviewFocus;
  bool? emailNotification;
  int? interviewTaken;
  int? confidence;
  bool? isResumeUploaded;
  bool? isAboutMeGenerated;
  String? generatedAboutMe;
  bool? isAboutMeVideoChecked;
  List<dynamic>? appliedJobs; // Changed from List<Null>? to List<dynamic>?
  UserId? userId;
  String? currentPlan;
  String? lastJobNotificationDate;
  bool? isDeleted;
  List<dynamic>? progress; // Changed from List<Null>? to List<dynamic>?
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.sId,
    this.name,
    this.phone,
    this.email,
    this.experienceLevel,
    this.preferredInterviewFocus,
    this.emailNotification,
    this.interviewTaken,
    this.confidence,
    this.isResumeUploaded,
    this.isAboutMeGenerated,
    this.generatedAboutMe,
    this.isAboutMeVideoChecked,
    this.appliedJobs,
    this.userId,
    this.currentPlan,
    this.lastJobNotificationDate,
    this.isDeleted,
    this.progress,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sId: json['_id'] as String?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        experienceLevel: json['experienceLevel'] as String?,
        preferredInterviewFocus: json['preferedInterviewFocus'] as String?, // note: original spelling kept
        emailNotification: json['emailNotification'] as bool?,
        interviewTaken: json['interviewTaken'] as int?,
        confidence: json['confidence'] as int?,
        isResumeUploaded: json['isResumeUploaded'] as bool?,
        isAboutMeGenerated: json['isAboutMeGenerated'] as bool?,
        generatedAboutMe: json['generatedAboutMe'] as String?,
        isAboutMeVideoChecked: json['isAboutMeVideoChecked'] as bool?,
        appliedJobs: json['appliedJobs'] as List<dynamic>?,
        userId: json['user_id'] != null ? UserId.fromJson(json['user_id']) : null,
        currentPlan: json['currentPlan'] as String?,
        lastJobNotificationDate: json['lastJobNotificationDate'] as String?,
        isDeleted: json['isDeleted'] as bool?,
        progress: json['progress'] as List<dynamic>?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        iV: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': sId,
        'name': name,
        'phone': phone,
        'email': email,
        'experienceLevel': experienceLevel,
        'preferedInterviewFocus': preferredInterviewFocus,
        'emailNotification': emailNotification,
        'interviewTaken': interviewTaken,
        'confidence': confidence,
        'isResumeUploaded': isResumeUploaded,
        'isAboutMeGenerated': isAboutMeGenerated,
        'generatedAboutMe': generatedAboutMe,
        'isAboutMeVideoChecked': isAboutMeVideoChecked,
        if (appliedJobs != null) 'appliedJobs': appliedJobs,
        if (userId != null) 'user_id': userId!.toJson(),
        'currentPlan': currentPlan,
        'lastJobNotificationDate': lastJobNotificationDate,
        'isDeleted': isDeleted,
        if (progress != null) 'progress': progress,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': iV,
      };
}

class UserId {
  String? sId;
  String? name;
  String? phone;
  String? email;
  String? password;
  String? role;
  bool? agreedToTerms;
  String? sentOTP;
  bool? otpVerified;
  bool? isDeleted;
  bool? isBlocked;
  bool? isLoggedIn;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserId({
    this.sId,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.role,
    this.agreedToTerms,
    this.sentOTP,
    this.otpVerified,
    this.isDeleted,
    this.isBlocked,
    this.isLoggedIn,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        sId: json['_id'] as String?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        password: json['password'] as String?,
        role: json['role'] as String?,
        agreedToTerms: json['agreedToTerms'] as bool? ?? json['aggriedToTerms'] as bool?, // fallback for typo in source JSON
        sentOTP: json['sentOTP'] as String?,
        otpVerified: json['OTPverified'] as bool?,
        isDeleted: json['isDeleted'] as bool?,
        isBlocked: json['isBlocked'] as bool?,
        isLoggedIn: json['isLoggedIn'] as bool?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        iV: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': sId,
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'role': role,
        'agreedToTerms': agreedToTerms,
        'sentOTP': sentOTP,
        'OTPverified': otpVerified,
        'isDeleted': isDeleted,
        'isBlocked': isBlocked,
        'isLoggedIn': isLoggedIn,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': iV,
      };
}

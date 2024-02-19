class SearchData {
  Data? data;
  String? message;

  SearchData({this.data, this.message});

  SearchData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? currentPage;
  int? totalPages;
  int? totalItems;
  List<SubData>? subData;

  Data({this.currentPage, this.totalPages, this.totalItems, this.subData});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    totalItems = json['total_items'];
    if (json['data'] != null) {
      subData = <SubData>[];
      json['data'].forEach((v) {
        subData!.add(SubData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    data['total_items'] = totalItems;
    if (subData != null) {
      data['data'] = subData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubData {
  int? id;
  String? debt;
  String? lastName;
  String? firstName;
  String? middleName;
  int? organizationId;
  int? mspdGetting;
  int? mspdPhotoGetting;
  String? paymentsSumAmount;
  Group? group;

  SubData(
      {this.id,
        this.debt,
        this.lastName,
        this.firstName,
        this.middleName,
        this.organizationId,
        this.mspdGetting,
        this.mspdPhotoGetting,
        this.paymentsSumAmount,
        this.group});

  SubData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    debt = json['debt'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    organizationId = json['organization_id'];
    mspdGetting = json['mspd_getting'];
    mspdPhotoGetting = json['mspd_photo_getting'];
    paymentsSumAmount = json['payments_sum_amount'];
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['debt'] = debt;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['organization_id'] = organizationId;
    data['mspd_getting'] = mspdGetting;
    data['mspd_photo_getting'] = mspdPhotoGetting;
    data['payments_sum_amount'] = paymentsSumAmount;
    if (group != null) {
      data['group'] = group!.toJson();
    }
    return data;
  }
}

class Group {
  int? id;
  String? name;
  int? timetable;
  int? checkGai;
  int? eduStatus;
  int? educationPrice;
  EduType? eduType;
  List<Teachers>? teachers;

  Group(
      {this.id,
        this.name,
        this.timetable,
        this.checkGai,
        this.eduStatus,
        this.educationPrice,
        this.eduType,
        this.teachers});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    timetable = json['timetable'];
    checkGai = json['check_gai'];
    eduStatus = json['edu_status'];
    educationPrice = json['education_price'];
    eduType = json['edu_type'] != null
        ? EduType.fromJson(json['edu_type'])
        : null;
    if (json['teachers'] != null) {
      teachers = <Teachers>[];
      json['teachers'].forEach((v) {
        teachers!.add(Teachers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['timetable'] = timetable;
    data['check_gai'] = checkGai;
    data['edu_status'] = eduStatus;
    data['education_price'] = educationPrice;
    if (eduType != null) {
      data['edu_type'] = eduType!.toJson();
    }
    if (teachers != null) {
      data['teachers'] = teachers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EduType {
  int? id;
  String? name;
  String? shortName;
  String? characterName;
  String? image;
  String? nameForExam;

  EduType(
      {this.id,
        this.name,
        this.shortName,
        this.characterName,
        this.image,
        this.nameForExam});

  EduType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['short_name'];
    characterName = json['character_name'];
    image = json['image'];
    nameForExam = json['name_for_exam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['short_name'] = shortName;
    data['character_name'] = characterName;
    data['image'] = image;
    data['name_for_exam'] = nameForExam;
    return data;
  }
}

class Teachers {
  int? id;
  Teacher? teacher;
  TypeTeacherForGroup? typeTeacherForGroup;

  Teachers({this.id, this.teacher, this.typeTeacherForGroup});

  Teachers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacher =
    json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    typeTeacherForGroup = json['type_teacher_for_group'] != null
        ? TypeTeacherForGroup.fromJson(json['type_teacher_for_group'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    if (typeTeacherForGroup != null) {
      data['type_teacher_for_group'] = typeTeacherForGroup!.toJson();
    }
    return data;
  }
}

class Teacher {
  int? id;
  String? lastName;
  String? firstName;
  String? middleName;
  String? phone1;
  Region? region;
  Region? area;
  List<EduType>? eduTypes;
  int? status;
  String? passportSeria;
  String? passportNumber;
  String? passportJshir;
  String? licenseSeria;
  String? licenseNumber;
  String? licenseDate;
  String? certificateNumber;
  String? certificateSeria;
  String? certificateGivenDate;
  String? birthday;
  int? mspdStatus;

  Teacher(
      {this.id,
        this.lastName,
        this.firstName,
        this.middleName,
        this.phone1,
        this.region,
        this.area,
        this.eduTypes,
        this.status,
        this.passportSeria,
        this.passportNumber,
        this.passportJshir,
        this.licenseSeria,
        this.licenseNumber,
        this.licenseDate,
        this.certificateNumber,
        this.certificateSeria,
        this.certificateGivenDate,
        this.birthday,
        this.mspdStatus});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    phone1 = json['phone1'];
    region =
    json['region'] != null ? Region.fromJson(json['region']) : null;
    area = json['area'] != null ? Region.fromJson(json['area']) : null;
    if (json['edu_types'] != null) {
      eduTypes = <EduType>[];
      json['edu_types'].forEach((v) {
        eduTypes!.add(EduType.fromJson(v));
      });
    }
    status = json['status'];
    passportSeria = json['passport_seria'];
    passportNumber = json['passport_number'];
    passportJshir = json['passport_jshir'];
    licenseSeria = json['license_seria'];
    licenseNumber = json['license_number'];
    licenseDate = json['license_date'];
    certificateNumber = json['certificate_number'];
    certificateSeria = json['certificate_seria'];
    certificateGivenDate = json['certificate_given_date'];
    birthday = json['birthday'];
    mspdStatus = json['mspd_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['phone1'] = phone1;
    if (region != null) {
      data['region'] = region!.toJson();
    }
    if (area != null) {
      data['area'] = area!.toJson();
    }
    if (eduTypes != null) {
      data['edu_types'] = eduTypes!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['passport_seria'] = passportSeria;
    data['passport_number'] = passportNumber;
    data['passport_jshir'] = passportJshir;
    data['license_seria'] = licenseSeria;
    data['license_number'] = licenseNumber;
    data['license_date'] = licenseDate;
    data['certificate_number'] = certificateNumber;
    data['certificate_seria'] = certificateSeria;
    data['certificate_given_date'] = certificateGivenDate;
    data['birthday'] = birthday;
    data['mspd_status'] = mspdStatus;
    return data;
  }
}

class Region {
  int? id;
  String? name;

  Region({this.id, this.name});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class TypeTeacherForGroup {
  int? id;
  String? name;
  int? typeOnDoc;

  TypeTeacherForGroup({this.id, this.name, this.typeOnDoc});

  TypeTeacherForGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    typeOnDoc = json['type_on_doc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type_on_doc'] = typeOnDoc;
    return data;
  }
}

class PaymentHistory {
  Data? data;
  String? message;

  PaymentHistory({this.data, this.message});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
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
  List<PayTypes>? payTypes;
  Payments? payments;

  Data({this.payTypes, this.payments});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['pay_types'] != null) {
      payTypes = <PayTypes>[];
      json['pay_types'].forEach((v) {
        payTypes!.add(PayTypes.fromJson(v));
      });
    }
    payments =
        json['payments'] != null ? Payments.fromJson(json['payments']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (payTypes != null) {
      data['pay_types'] = payTypes!.map((v) => v.toJson()).toList();
    }
    if (payments != null) {
      data['payments'] = payments!.toJson();
    }
    return data;
  }
}

class PayTypes {
  int? id;
  String? name;

  PayTypes({this.id, this.name});

  PayTypes.fromJson(Map<String, dynamic> json) {
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

class Payments {
  int? currentPage;
  List<SubData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Payments(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Payments.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SubData>[];
      json['data'].forEach((v) {
        data!.add(SubData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class SubData {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  int? studentId;
  int? amount;
  int? organizationId;
  String? paymentDate;
  String? description;
  int? groupId;
  int? payTypeId;
  Student? student;
  PayTypes? payType;
  Group? group;

  SubData(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.studentId,
      this.amount,
      this.organizationId,
      this.paymentDate,
      this.description,
      this.groupId,
      this.payTypeId,
      this.student,
      this.payType,
      this.group});

  SubData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    studentId = json['student_id'];
    amount = json['amount'];
    organizationId = json['organization_id'];
    paymentDate = json['payment_date'];
    description = json['description'];
    groupId = json['group_id'];
    payTypeId = json['pay_type_id'];
    student =
        json['student'] != null ? Student.fromJson(json['student']) : null;
    payType =
        json['pay_type'] != null ? PayTypes.fromJson(json['pay_type']) : null;
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['student_id'] = studentId;
    data['amount'] = amount;
    data['organization_id'] = organizationId;
    data['payment_date'] = paymentDate;
    data['description'] = description;
    data['group_id'] = groupId;
    data['pay_type_id'] = payTypeId;
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (payType != null) {
      data['pay_type'] = payType!.toJson();
    }
    if (group != null) {
      data['group'] = group!.toJson();
    }
    return data;
  }
}

class Student {
  int? id;
  String? lastName;
  String? firstName;
  String? middleName;

  Student({this.id, this.lastName, this.firstName, this.middleName});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    return data;
  }
}

class Group {
  int? id;
  String? nameUz;

  Group({this.id, this.nameUz});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameUz = json['name_uz'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_uz'] = nameUz;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}

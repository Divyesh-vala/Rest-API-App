class UserListModel {
  int? page, perPage, total, totalPages;
  List<UserData>? data;
  Support? support;

  UserListModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
    page: json["page"],
    perPage: json["per_page"],
    total: json["total"],
    totalPages: json["total_pages"],
    data:
        json["data"] == null
            ? []
            : List<UserData>.from(
              json["data"]!.map((x) => UserData.fromJson(x)),
            ),
    support: json["support"] == null ? null : Support.fromJson(json["support"]),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "total": total,
    "total_pages": totalPages,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "support": support?.toJson(),
  };
}

class UserData {
  int? id;
  String? email, firstName, lastName, avatar;

  UserData({this.id, this.email, this.firstName, this.lastName, this.avatar});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };
}

class Support {
  String? url, text;

  Support({this.url, this.text});

  factory Support.fromJson(Map<String, dynamic> json) =>
      Support(url: json["url"], text: json["text"]);

  Map<String, dynamic> toJson() => {"url": url, "text": text};
}

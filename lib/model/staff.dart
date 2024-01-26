class Staff {
  late String staffName;

  Staff({required this.staffName});

  Staff.fromJson(Map<String, dynamic> json) {
    staffName = json['Name'];
  }
}

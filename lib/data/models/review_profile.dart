class ReviewProfile {
  int? id;
  String? cusName;

  ReviewProfile({this.id, this.cusName});

  ReviewProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cusName = json['cus_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cus_name'] = this.cusName;
    return data;
  }
}
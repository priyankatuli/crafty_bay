import 'package:crafty_bay/data/models/review_screen_data.dart';

class ReviewScreenModel {
  String? msg;
  List<ReviewScreenData>? data;

  ReviewScreenModel({this.msg, this.data});

  ReviewScreenModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <ReviewScreenData>[];
      json['data'].forEach((v) {
        data!.add(ReviewScreenData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
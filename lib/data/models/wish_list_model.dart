import 'package:crafty_bay/data/models/wish_list_item.dart';

class WishlistModel {
  String? msg;
  List<WishListItem>? data;

  WishlistModel({this.msg, this.data});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <WishListItem>[];
      json['data'].forEach((v) {
        data!.add(WishListItem.fromJson(v));
      });
    }
  }

}
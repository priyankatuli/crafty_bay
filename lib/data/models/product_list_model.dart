

import 'package:crafty_bay/data/models/product_model.dart';

class ProductListModel {
  String? msg;
  List<ProductModel>? productModel;

  ProductListModel({this.msg, this.productModel});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productModel = <ProductModel>[];
      json['data'].forEach((v) {
        productModel!.add(ProductModel.fromJson(v));
      });
    }
  }

}






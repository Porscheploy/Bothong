// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ungcomplant/models/shop_model.dart';

class EditShop extends StatelessWidget {
  const EditShop({
    Key? key,
    required this.shopModel,
    required this.docIdShop,
  }) : super(key: key);

  final ShopModel shopModel;
  final String docIdShop;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

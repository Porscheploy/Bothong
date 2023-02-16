// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetImageNetwork extends StatelessWidget {
  const WidgetImageNetwork({
    Key? key,
    required this.urlPath,
    this.size,
  }) : super(key: key);

  final String urlPath;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Image.network(urlPath, width: size, height: size, fit:  BoxFit.cover,);
  }
}

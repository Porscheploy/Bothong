// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ungcomplant/utility/app_constant.dart';

class WidgetFloatingAdd extends StatelessWidget {
  const WidgetFloatingAdd({
    Key? key,
    required this.pressFunc,
  }) : super(key: key);

  final Function() pressFunc;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppConstant.redColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: pressFunc,
    );
  }
}

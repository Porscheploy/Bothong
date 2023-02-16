import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/states/add_shop_food.dart';
import 'package:ungcomplant/utility/app_constant.dart';
import 'package:ungcomplant/utility/app_controller.dart';
import 'package:ungcomplant/widgets/widget_floating_add.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class ListShopFood extends StatelessWidget {
  const ListShopFood({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('userModels --> ${appController.userModels.length}');
          return Scaffold(
            appBar: AppBar(
              title: const WidgetText(text: 'ร้านอาหาร'),
            ),
            floatingActionButton: appController.userModels.last.admin
                ? WidgetFloatingAdd(
                    pressFunc: () {
                      Get.to(const AddShopFood())!.then((value) {
                        if (appController.files.isNotEmpty) {
                          appController.files.clear();
                        }
                      });
                    },
                  )
                : const SizedBox(),
          );
        });
  }
}

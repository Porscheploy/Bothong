import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/states/add_shop_food.dart';
import 'package:ungcomplant/utility/app_constant.dart';
import 'package:ungcomplant/utility/app_controller.dart';
import 'package:ungcomplant/utility/app_service.dart';
import 'package:ungcomplant/widgets/widget_floating_add.dart';
import 'package:ungcomplant/widgets/widget_icon_button.dart';
import 'package:ungcomplant/widgets/widget_image_network.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class ListShopFood extends StatefulWidget {
  const ListShopFood({super.key});

  @override
  State<ListShopFood> createState() => _ListShopFoodState();
}

class _ListShopFoodState extends State<ListShopFood> {
  @override
  void initState() {
    super.initState();
    AppService().readShopModels();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('userModels --> ${appController.userModels.length}');
            return Scaffold(
              appBar: AppBar(
                title: const WidgetText(text: 'ร้านอาหาร'),
              ),
              body: appController.shopModels.isEmpty
                  ? const SizedBox()
                  : ListView.builder(
                      itemCount: appController.shopModels.length,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: boxConstraints.maxWidth * 0.5,
                            height: boxConstraints.maxWidth * 0.5,
                            child: WidgetImageNetwork(
                                urlPath:
                                    appController.shopModels[index].urlImage),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: boxConstraints.maxWidth * 0.5,
                            height: boxConstraints.maxWidth * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                WidgetText(
                                  text:
                                      appController.shopModels[index].nameShop,
                                  textStyle: AppConstant().defaultStyle(
                                      size: 20, fontWeight: FontWeight.bold),
                                ),
                                WidgetText(
                                    text:
                                        'เวลา เปิดปิด : ${appController.shopModels[index].timeShop}'),
                                WidgetText(
                                  text: appController
                                      .shopModels[index].detailShoop,
                                  textStyle: AppConstant().defaultStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                appController.userModels.last.admin ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    WidgetIconButton(
                                      iconData: Icons.delete_forever,
                                      color: Colors.red.shade700,
                                      pressFunc: () async {
                                        print(
                                            'delete shop id --> ${appController.docIdShops[index]}');
                                        await FirebaseFirestore.instance
                                            .collection('shop')
                                            .doc(
                                                appController.docIdShops[index])
                                            .delete()
                                            .then((value) =>
                                                AppService().readShopModels());
                                      },
                                    ),
                                  ],
                                ) : const SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
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
    });
  }
}

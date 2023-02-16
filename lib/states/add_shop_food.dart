import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/models/shop_model.dart';
import 'package:ungcomplant/utility/app_controller.dart';
import 'package:ungcomplant/utility/app_dialog.dart';
import 'package:ungcomplant/utility/app_service.dart';
import 'package:ungcomplant/widgets/widget_button.dart';
import 'package:ungcomplant/widgets/widget_form.dart';
import 'package:ungcomplant/widgets/widget_icon_button.dart';
import 'package:ungcomplant/widgets/widget_image.dart';
import 'package:ungcomplant/widgets/widget_take_photo.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class AddShopFood extends StatefulWidget {
  const AddShopFood({super.key});

  @override
  State<AddShopFood> createState() => _AddShopFoodState();
}

class _AddShopFoodState extends State<AddShopFood> {
  String? nameShop, timeShop, detailShop, urlImageShop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(text: 'เพิ่มร้านอาหาร'),
      ),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('file --> ${appController.files.length}');
            return ListView(
              children: [
                WidgetTakePhoto(
                  pathImageShow: 'images/item2.png',
                ),
                SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      WidgetForm(
                        hint: 'ชื่อร้านอาหาร :',
                        changeFunc: (p0) {
                          nameShop = p0.trim();
                        },
                      ),
                      WidgetForm(
                        hint: 'เวลาเปิดปิด :',
                        changeFunc: (p0) {
                          timeShop = p0.trim();
                        },
                      ),
                      WidgetForm(
                        hint: 'รายละเอียด :',
                        changeFunc: (p0) {
                          detailShop = p0.trim();
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      WidgetButton(
                        label: 'บันทึก',
                        pressFunc: () {
                          if (appController.files.isEmpty) {
                            AppDialog(context: context).normalDialog(
                                title: 'ยังไม่มีรูป',
                                detail: 'กรุณาถ่ายรูปด้วย คะ');
                          } else if ((nameShop?.isEmpty ?? true) ||
                              (timeShop?.isEmpty ?? true) ||
                              (detailShop?.isEmpty ?? true)) {
                            AppDialog(context: context).normalDialog(
                                title: 'มีช่องว่าง',
                                detail: 'กรุณากรอกทุกช่อง นะคะ');
                          } else {
                            AppService()
                                .processUploadImage(path: 'shop')
                                .then((value) async {
                              print(
                                  'urlImage --> ${appController.urlImages.last}');

                              ShopModel shopModel = ShopModel(
                                  urlImage: appController.urlImages.last,
                                  nameShop: nameShop!,
                                  timeShop: timeShop!,
                                  detailShoop: detailShop!);

                              await FirebaseFirestore.instance
                                  .collection('shop')
                                  .doc()
                                  .set(shopModel.toMap())
                                  .then((value) {
                                AppService().readShopModels();
                                Get.back();
                              });
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

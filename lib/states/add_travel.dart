// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/models/shop_model.dart';
import 'package:ungcomplant/models/travel_model.dart';
import 'package:ungcomplant/utility/app_controller.dart';
import 'package:ungcomplant/utility/app_dialog.dart';
import 'package:ungcomplant/utility/app_service.dart';
import 'package:ungcomplant/widgets/widget_button.dart';
import 'package:ungcomplant/widgets/widget_form.dart';
import 'package:ungcomplant/widgets/widget_icon_button.dart';
import 'package:ungcomplant/widgets/widget_image.dart';
import 'package:ungcomplant/widgets/widget_take_photo.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class AddTravel extends StatefulWidget {
  const AddTravel({super.key});

  @override
  State<AddTravel> createState() => _AddTravelState();
}

class _AddTravelState extends State<AddTravel> {
  String? nameTravel, timeTravel, addressTravel;

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
                const WidgetTakePhoto(
                  pathImageShow: 'images/item3.png',
                ),
                SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      WidgetForm(
                        hint: 'ชื่อสถานที่ท่องเทียว :',
                        changeFunc: (p0) {
                          nameTravel = p0.trim();
                        },
                      ),
                      WidgetForm(
                        hint: 'เวลาเปิดปิด :',
                        changeFunc: (p0) {
                          timeTravel = p0.trim();
                        },
                      ),
                      WidgetForm(
                        hint: 'ที่อยู่ :',
                        changeFunc: (p0) {
                          addressTravel = p0.trim();
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
                          } else if ((nameTravel?.isEmpty ?? true) ||
                              (timeTravel?.isEmpty ?? true) ||
                              (addressTravel?.isEmpty ?? true)) {
                            AppDialog(context: context).normalDialog(
                                title: 'มีช่องว่าง',
                                detail: 'กรุณากรอกทุกช่อง นะคะ');
                          } else {
                            AppService()
                                .processUploadImage(path: 'travel')
                                .then((value) async {
                              print(
                                  'urlImage --> ${appController.urlImages.last}');

                              TravelModel travelModel = TravelModel(
                                  urlImage: appController.urlImages.last,
                                  nameTravel: nameTravel!,
                                  timeTravel: timeTravel!,
                                  addressTravel: addressTravel!);

                              await FirebaseFirestore.instance
                                  .collection('travel')
                                  .doc()
                                  .set(travelModel.toMap())
                                  .then((value) {
                                AppService().readTravelModels();
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

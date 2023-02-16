import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/states/add_travel.dart';
import 'package:ungcomplant/utility/app_constant.dart';
import 'package:ungcomplant/utility/app_controller.dart';
import 'package:ungcomplant/utility/app_service.dart';
import 'package:ungcomplant/widgets/widget_floating_add.dart';
import 'package:ungcomplant/widgets/widget_icon_button.dart';
import 'package:ungcomplant/widgets/widget_image_network.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class ListTravel extends StatefulWidget {
  const ListTravel({super.key});

  @override
  State<ListTravel> createState() => _ListTravelState();
}

class _ListTravelState extends State<ListTravel> {
  @override
  void initState() {
    super.initState();
    AppService().readTravelModels();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('travelModels ---> ${appController.travelModels.length}');
            return Scaffold(
              appBar: AppBar(
                title: const WidgetText(text: 'สถานที่ท่องเที่ยว'),
              ),
              floatingActionButton: appController.userModels.last.admin ? WidgetFloatingAdd(
                pressFunc: () {
                  Get.to(const AddTravel())!.then((value) {});
                },
              ) : const SizedBox(),
              body: appController.travelModels.isEmpty ? const SizedBox() :  ListView.builder(
                      itemCount: appController.travelModels.length,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: boxConstraints.maxWidth * 0.5,
                            height: boxConstraints.maxWidth * 0.5,
                            child: WidgetImageNetwork(
                                urlPath:
                                    appController.travelModels[index].urlImage),
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
                                      appController.travelModels[index].nameTravel,
                                  textStyle: AppConstant().defaultStyle(
                                      size: 20, fontWeight: FontWeight.bold),
                                ),
                                WidgetText(
                                    text:
                                        'เวลา เปิดปิด : ${appController.travelModels[index].timeTravel}'),
                                WidgetText(
                                  text: appController
                                      .travelModels[index].addressTravel,
                                  textStyle: AppConstant().defaultStyle(
                                    color: Colors.red,
                                  ),
                                ), Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    WidgetIconButton(
                                      iconData: Icons.delete_forever,color: Colors.red.shade700,
                                      pressFunc: () async {
                                         await FirebaseFirestore.instance
                                            .collection('travel')
                                            .doc(
                                                appController.docIdTravels[index])
                                            .delete()
                                            .then((value) =>
                                                AppService().readTravelModels());
                                      
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          });
    });
  }
}

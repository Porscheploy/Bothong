// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungcomplant/utility/app_controller.dart';

import 'package:ungcomplant/widgets/widget_icon_button.dart';
import 'package:ungcomplant/widgets/widget_image.dart';

class WidgetTakePhoto extends StatelessWidget {
  const WidgetTakePhoto({
    Key? key,
    required this.pathImageShow,
  }) : super(key: key);

  final String pathImageShow;

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('files --> ${appController.files.length}');
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                height: 250,
                child: Stack(
                  children: [
                    appController.files.isEmpty
                        ? WidgetImage(
                            path: pathImageShow,
                            size: 250,
                          )
                        : Image.file(
                            appController.files.last,
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: WidgetIconButton(color: Colors.lime,
                        iconData: Icons.add_photo_alternate,
                        pressFunc: () async {
                          var result = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                              maxWidth: 800,
                              maxHeight: 800);
                          if (result != null) {
                            appController.files.add(File(result.path));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:ungcomplant/widgets/widget_image.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class SuggestPage extends StatelessWidget {
  const SuggestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(text: 'ข้อเสนอแนะ'),
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return SizedBox(width: boxConstraints.maxWidth,height: boxConstraints.maxHeight,
          child: WidgetImage(
            path: 'images/intro2.png',
            boxFit: BoxFit.fill,
          ),
        );
      }),
    );
  }
}

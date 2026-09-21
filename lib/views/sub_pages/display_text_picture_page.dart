import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:smart_warehouse/shared/extensions/context_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';

@RoutePage<String>()
class DisplayTextPicturePage extends StatefulWidget {
  const DisplayTextPicturePage({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<StatefulWidget> createState() {
    return _DisplayTextPicturePageState();
  }
}

class _DisplayTextPicturePageState extends State<DisplayTextPicturePage> {
  List<TextBlock> allTextImage = [];
  double radio = 1.0;

  @override
  void initState() {
    readTextFromImage();
    super.initState();
  }

  Future<void> readTextFromImage() async {
    final currentImageFile = File(widget.imagePath);
    final inputImage = InputImage.fromFile(currentImageFile);
    final textRecognizer = TextRecognizer();
    final recognizedText = await textRecognizer.processImage(inputImage);

    final file = File(widget.imagePath);
    final decodedImage = await decodeImageFromList(file.readAsBytesSync());

    setState(() {
      allTextImage = recognizedText.blocks;
      radio = context.mediaQuerySize.width / decodedImage.width;
    });

    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.camera_select_material_code).tr(),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.file(
              File(widget.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          ...allTextImage.map(
            (e) => Positioned(
              left: e.boundingBox.left * radio,
              top: e.boundingBox.top * radio - 20,
              child: InkWell(
                onTap: () {
                  context.maybePop(e.text);
                },
                child: Container(
                  width: e.boundingBox.width * radio,
                  height: e.boundingBox.height * radio,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      e.text,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

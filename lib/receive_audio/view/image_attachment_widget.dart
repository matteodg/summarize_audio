import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_handler/share_handler.dart';

class ImageAttachmentWidget extends StatelessWidget {
  const ImageAttachmentWidget(this.attachment, {super.key});

  final SharedAttachment attachment;

  @override
  Widget build(BuildContext context) {
    final path = attachment.path;
    return Column(
      children: [
        Text(path, textAlign: TextAlign.center),
        Image.file(File(path)),
      ],
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:share_handler/share_handler.dart';

class FileAttachmentWidget extends StatelessWidget {
  const FileAttachmentWidget(this.attachment, {super.key});

  final SharedAttachment attachment;

  @override
  Widget build(BuildContext context) {
    return Text('File: ${attachment.path}');
  }
}

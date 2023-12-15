import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:share_handler/share_handler.dart';

class AudioAttachmentWidget extends StatelessWidget {
  const AudioAttachmentWidget(this.attachment, {super.key});

  final SharedAttachment attachment;

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    final path = attachment.path;
    return Column(
      children: [
        Text(path, textAlign: TextAlign.center),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await player.play(DeviceFileSource(path));
              },
              child: const Text('Play'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () async {
                await player.stop();
              },
              child: const Text('Stop'),
            ),
          ],
        ),
      ],
    );
  }
}

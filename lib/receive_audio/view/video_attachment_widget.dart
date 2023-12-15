import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_handler/share_handler.dart';
import 'package:video_player/video_player.dart';

class VideoAttachmentWidget extends StatefulWidget {
  const VideoAttachmentWidget(this.attachment, {super.key});

  final SharedAttachment attachment;

  @override
  State<VideoAttachmentWidget> createState() => _VideoAttachmentWidgetState();
}

class _VideoAttachmentWidgetState extends State<VideoAttachmentWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.attachment.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized,
        // even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Video: ${widget.attachment.path}'),
        if (_controller.value.isInitialized)
          Column(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _controller.play();
                    },
                    child: const Text('Play'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      await _controller.pause();
                    },
                    child: const Text('Pause'),
                  ),
                ],
              ),
            ],
          )
        else
          Container(),
      ],
    );
  }
}

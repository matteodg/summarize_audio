import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:share_handler/share_handler.dart';
import 'package:summarize_audio/l10n/l10n.dart';
import 'package:video_player/video_player.dart';

class ReceiveAudioPage extends StatelessWidget {
  const ReceiveAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReceiveAudioView();
  }
}

class ReceiveAudioView extends StatefulWidget {
  const ReceiveAudioView({super.key});

  @override
  State<ReceiveAudioView> createState() => _ReceiveAudioViewState();
}

class _ReceiveAudioViewState extends State<ReceiveAudioView> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  SharedMedia? media;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final handler = ShareHandlerPlatform.instance;
    media = await handler.getInitialSharedMedia();

    handler.sharedMediaStream.listen((SharedMedia media) {
      if (!mounted) return;
      setState(() {
        this.media = media;
      });
    });
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.receiveAudioAppBarTitle)),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: (media?.attachments ?? []).map(
            (attachment) {
              if (attachment == null) {
                return const Column(children: [Text('Attachment not available')]);
              }
              return attachment.getWidget();
            },
          ).toList(),
        ),
      ),
    );
  }
}

extension on SharedAttachment {
  Widget getWidget() {
    switch (type) {
      case SharedAttachmentType.image:
        return ImageAttachment(this);
      case SharedAttachmentType.video:
        return VideoAttachment(this);
      case SharedAttachmentType.audio:
        return AudioAttachment(this);
      case SharedAttachmentType.file:
        return Text('File: $path');
    }
  }
}

class VideoAttachment extends StatefulWidget {
  const VideoAttachment(this.attachment, {super.key});

  final SharedAttachment attachment;

  @override
  State<VideoAttachment> createState() => _VideoAttachmentState();
}

class _VideoAttachmentState extends State<VideoAttachment> {
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

class ImageAttachment extends StatelessWidget {
  const ImageAttachment(this.attachment, {super.key});

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

class AudioAttachment extends StatelessWidget {
  const AudioAttachment(this.attachment, {super.key});

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

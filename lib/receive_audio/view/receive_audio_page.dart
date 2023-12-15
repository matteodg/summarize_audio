import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:share_handler/share_handler.dart';
import 'package:summarize_audio/l10n/l10n.dart';
import 'package:summarize_audio/receive_audio/view/audio_attachment_widget.dart';
import 'package:summarize_audio/receive_audio/view/file_attachment_widget.dart';
import 'package:summarize_audio/receive_audio/view/image_attachment_widget.dart';
import 'package:summarize_audio/receive_audio/view/video_attachment_widget.dart';

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
      if (!mounted) {
        return;
      }
      setState(() {
        this.media = media;
      });
    });
    if (!mounted) {
      return;
    }

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
          children: (media?.attachments ?? [])
              .map(
                (attachment) => Option.of(attachment) //
                    .map((attachment) => attachment!.getWidget())
                    .getOrElse(() => const Column(
                          children: [Text('Attachment not available')],
                        )),
              )
              .toList(),
        ),
      ),
    );
  }
}

extension on SharedAttachment {
  Widget getWidget() {
    return switch (type) {
      SharedAttachmentType.image => ImageAttachmentWidget(this),
      SharedAttachmentType.video => VideoAttachmentWidget(this),
      SharedAttachmentType.audio => AudioAttachmentWidget(this),
      SharedAttachmentType.file => FileAttachmentWidget(this)
    };
  }
}

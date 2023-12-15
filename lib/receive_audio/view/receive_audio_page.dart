import 'package:flutter/material.dart';
import 'package:summarize_audio/l10n/l10n.dart';

class ReceiveAudioPage extends StatelessWidget {
  const ReceiveAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReceiveAudioView();
  }
}

class ReceiveAudioView extends StatelessWidget {
  const ReceiveAudioView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.receiveAudioAppBarTitle)),
      body: const Center(child: Text('Hello World')),
    );
  }
}

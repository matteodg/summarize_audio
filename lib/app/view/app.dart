import 'package:flutter/material.dart';
import 'package:summarize_audio/l10n/l10n.dart';
import 'package:summarize_audio/receive_audio/receive_audio.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const ReceiveAudioPage(),
    );
  }
}

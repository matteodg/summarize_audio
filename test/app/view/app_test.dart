import 'package:flutter_test/flutter_test.dart';
import 'package:summarize_audio/app/app.dart';
import 'package:summarize_audio/receive_audio/receive_audio.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(ReceiveAudioPage), findsOneWidget);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:twitter_clone/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("login, chek for tweet, logout", (tester) async {
    await tester.pumpWidget(const MyApp());
    Finder loginText = find.text("Login with Twitter");
    expect(loginText, findsOneWidget);

    Finder loginEmail = find.byKey(const ValueKey("loginEmail"));
    Finder loginPassword = find.byKey(const ValueKey("loginPassword"));
    Finder loginButton = find.byKey(const ValueKey("loginButton"));
    // Finder profilePic = find.byKey(const ValueKey("profilePic"));
    Finder signOut = find.byKey(const ValueKey("signOut"));

    await tester.enterText(loginEmail, "mm.rikkimae@gmail.com");
    await tester.enterText(loginPassword, "123456");
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    await tester.tap(signOut);
    await tester.pumpAndSettle();

    expect(loginText, findsOneWidget);
  });
}

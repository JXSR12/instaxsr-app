import 'package:flutter/material.dart';
import 'package:instaxsr/login.dart';
import 'package:instaxsr/thememan.dart';
import 'package:provider/provider.dart';
import 'package:instaxsr/globals.dart' as gl;

void main(List<String> args) {
  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(),
    child: const InstaXSR(),
  ));
}

class InstaXSR extends StatelessWidget {
  const InstaXSR({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
              theme: theme.getTheme(),
              title: "InstaXSR",
              home: LoginPage(tnotifier: theme),
            ));
  }
}

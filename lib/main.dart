import 'package:flutter/material.dart';
import 'package:testprakt/features/first_screen/presentation/pages/gender.dart';
import 'package:testprakt/features/first_screen/presentation/pages/results.dart';
import 'package:testprakt/features/first_screen/presentation/pages/testfinish.dart';
import 'package:testprakt/features/first_screen/presentation/pages/testfirst.dart';
import 'package:testprakt/features/first_screen/presentation/pages/testnext.dart';
import 'features/first_screen/presentation/pages/share.dart';
import 'features/first_screen/presentation/pages/startbase.dart';
import 'features/first_screen/presentation/pages/inst1.dart';
import 'features/first_screen/presentation/pages/inst2.dart';
import 'features/first_screen/presentation/pages/inst3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/start',
      routes: {
        '/start': (_) => const Start(),
        '/inst1': (_) => const Inst1(),
        '/inst2': (_) => const Inst2(),
        '/inst3': (_) => const Inst3(),
        '/gender': (_) => const Gender(),
        '/test1': (_) => const Testfirst(),
        //'/testfinish': (_) => const TestFinish(),
        //'/results': (_) => const Results(),
        ///share': (_) => const Share(),
      },
    );
  }
}

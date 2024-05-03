import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:repel/admin_screens/admin_home.dart';
import 'package:repel/firebase_options.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

Future<void> main() async {
  // debugPaintLayerBordersEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        breakpoints: [
          const ResponsiveBreakpoint.resize(240, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(650, name: TABLET),
          const ResponsiveBreakpoint.autoScale(900, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          const ResponsiveBreakpoint.resize(2468, name: '4K'),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: 'Admin',
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Fconcrete.png?alt=media&token=d563705a-f551-47c0-b4d1-382f92558df5',
              fit: BoxFit.cover,
            ),
            SplashScreenAdmin(),
          ],
        ),
      ),
    );
  }
}

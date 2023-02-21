import 'package:authtd/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp(
   router: AppRouter()));
}

class MyApp extends StatelessWidget {
    final AppRouter router;

  const MyApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
        theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:  const WidgetTree(),
    );
  }
} 


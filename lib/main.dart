import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'screens/login_page.dart';

import 'services/notification_service.dart';
import 'services/location_service.dart';
import 'services/transaction_listener_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //  INIT NOTIFICATIONS
  await NotificationService.init();

  //  START LOCATION TRACKING
  final locationService = LocationService();
  await locationService.startTracking();

  //  START TRANSACTION LISTENER
  final transactionService = TransactionListenerService();
  await transactionService.init();

  runApp(const PennyWiseApp());
}

class PennyWiseApp extends StatelessWidget {
  const PennyWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PennyWise',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LoginPage(),
    );
  }
}
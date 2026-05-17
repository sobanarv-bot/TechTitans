import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_service.dart';

class TransactionListenerService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _messaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? "Transaction";
      final body = message.notification?.body ?? "";

      if (_isTransaction(body)) {
        NotificationService.showNotification(
          title,
          body,
        );
      }
    });
  }

  bool _isTransaction(String text) {
    text = text.toLowerCase();

    return text.contains("rm") ||
        text.contains("spent") ||
        text.contains("debited") ||
        text.contains("transaction");
  }
}
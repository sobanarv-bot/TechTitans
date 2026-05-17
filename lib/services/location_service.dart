import 'dart:async';
import 'package:geolocator/geolocator.dart';

import 'notification_service.dart';

class LocationService {
  Position? _lastPosition;
  DateTime? _lastMoveTime;
  Timer? _timer;

  Future<void> startTracking() async {
    await Geolocator.requestPermission();

    _timer = Timer.periodic(const Duration(minutes: 1), (_) async {
      Position pos = await Geolocator.getCurrentPosition();

      if (_lastPosition == null) {
        _lastPosition = pos;
        _lastMoveTime = DateTime.now();
        return;
      }

      double distance = Geolocator.distanceBetween(
        _lastPosition!.latitude,
        _lastPosition!.longitude,
        pos.latitude,
        pos.longitude,
      );

      // If user moved
      if (distance > 30) {
        _lastPosition = pos;
        _lastMoveTime = DateTime.now();
        return;
      }

      // If stayed in same place for 10 min
      if (_lastMoveTime != null) {
        final duration = DateTime.now().difference(_lastMoveTime!);

        if (duration.inMinutes >= 10) {
          NotificationService.showNotification(
            "Spending Check",
            "Did you spend money here?",
          );

          _lastMoveTime = DateTime.now(); // reset loop
        }
      }
    });
  }

  void stopTracking() {
    _timer?.cancel();
  }
}
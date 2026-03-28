  import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<String> getUserState() async {
    try {
      // =========================
      // Check permissions
      // =========================
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return 'Unknown';
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return 'Denied';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return 'DeniedForever';
      }

      // =========================
      // Get location
      // =========================
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // =========================
      // Reverse Geocoding
      // =========================
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return place.administrativeArea ?? 'Unknown';
      }

      return 'Unknown';
    } catch (e) {
      print("Location error: $e");
      return 'Error';
    }
  }

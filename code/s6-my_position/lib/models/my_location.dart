import 'package:cloud_firestore/cloud_firestore.dart';

class MyLocation {
  // Normal Fields
  double latitude;
  double longitude;
  double altitude;
  // Audit Fields
  late Timestamp activityDate;
  // Document Field [Required for Firestore]
  late DocumentReference reference;

  MyLocation(this.latitude, this.longitude, this.altitude);

  MyLocation.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['latitude'] != null),
        assert(map['longitude'] != null),
        assert(map['altitude'] != null),
        latitude = map['latitude'],
        longitude = map['longitude'],
        altitude = map['altitude'],
        activityDate = map['activityDate'] ?? Timestamp.now();

  MyLocation.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'activityDate': Timestamp.now(),
    };
  }
}

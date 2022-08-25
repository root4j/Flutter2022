import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  // Normal Fields
  String id;
  String name;
  String mail;
  String phone;
  String address;
  String gender;
  // Audit Fields
  late String user;
  late Timestamp activityDate;
  // Document Field [Required for Firestore]
  late DocumentReference reference;

  Person(this.id, this.name, this.mail, this.phone, this.address, this.gender);

  Person.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['id'] != null),
        assert(map['name'] != null),
        assert(map['mail'] != null),
        assert(map['phone'] != null),
        assert(map['address'] != null),
        assert(map['gender'] != null),
        id = map['id'],
        name = map['name'],
        mail = map['mail'],
        phone = map['phone'],
        address = map['address'],
        gender = map['gender'],
        user = map['user'] ?? 'user@not.found',
        activityDate = map['activityDate'] ?? Timestamp.now();

  Person.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  toJson(String? user) {
    return {
      'id': id,
      'name': name,
      'mail': mail,
      'phone': phone,
      'address': address,
      'gender': gender,
      'user': user ?? 'user@not.found',
      'activityDate': Timestamp.now(),
    };
  }
}

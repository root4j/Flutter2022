import 'package:firebase_database/firebase_database.dart';

class Message {
  String? key;
  String text;
  String user;
  String mail;

  Message(this.text, this.user, this.mail);

  Message.fromJson(DataSnapshot snapshot, Map<dynamic, dynamic> json)
      : key = snapshot.key ?? '0',
        user = json['user'] ?? 'user',
        mail = json['mail'] ?? 'not@found.mail',
        text = json['text'] ?? 'text';

  toJson() {
    return {"text": text, "user": user, "mail": mail};
  }
}

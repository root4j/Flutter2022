import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  // Metodo que permite crear usuarios
  Future createUser(email, pswd) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pswd);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('The password is too weak!');
      } else if (e.code == 'email-already-in-use') {
        return Future.error('The email is already in use!');
      }
    } catch (e) {
      return Future.error('Exception error: $e');
    }
  }

  // Metodo que permite autenticar usuarios
  Future singInUser(email, pswd) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pswd);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return Future.error('The email/password is Wrong!');
      }
    } catch (e) {
      return Future.error('Exception error: $e');
    }
  }

  // Metodo para destruir la sesion autenticada
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Future.error('Exception error: $e');
    }
  }

  // Metodo para obtener el email del usuario conectado
  String getUserEmail() {
    return FirebaseAuth.instance.currentUser!.email ?? "not@found.mail";
  }

  // Metodo para obtener el id del usuario conectado
  String getUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}

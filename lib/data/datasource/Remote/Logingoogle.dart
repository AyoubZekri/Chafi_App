import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

class LoginGoogle {
  final GoogleSignIn _googleSignIn = GoogleSignIn.standard(
    scopes: ['email', 'profile'],
  );

  Future<UserCredential> signInWithGoogle() async {
    await _googleSignIn.signOut(); // إجبار المستخدم على اختيار الحساب

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw 'Login cancelled';

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class LoginData {
  Crud crud;
  LoginData(this.crud);

  loginGoogle(Map data) async {
    var response = await crud.postWithout(Applink.logingoogle, data);
    return response.fold((l) => l, (r) => r);
  }

  login(Map data) async {
    var response = await crud.postWithout(Applink.login, data);
    return response.fold((l) => l, (r) => r);
  }

  updateuser(Map data) async {
    var response = await crud.postWithheaders(Applink.updateuser, data);
    return response.fold((l) => l, (r) => r);
  }

  logout() async {
    var response = await crud.getWithheaders(Applink.logout);
    return response.fold((l) => l, (r) => r);
  }
}

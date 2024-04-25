import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  signInWithGoogle() async {
    //begin in signin
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //Obtain auth details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create new profile for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //actual signin
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

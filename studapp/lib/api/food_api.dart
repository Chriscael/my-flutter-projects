// ignore_for_file: unused_local_variable, avoid_print, invalid_return_type_for_catch_error, unnecessary_null_comparison, library_prefixes, await_only_futures

// import 'package:studapp/notifier/auth_notifier.dart';
// import 'package:studapp/model/user.dart' as User;
// import 'package:firebase_auth/firebase_auth.dart';

// login(User.User user, AuthNotifier authNotifier) async {
//   UserCredential authCredential = await FirebaseAuth.instance
//       .signInWithEmailAndPassword(email: user.email, password: user.password)
//       .catchError((error) => print(error.code));

//   if (authCredential != null) {
//     User.User? firebaseUser = authCredential.user as User.User?;

//     if (firebaseUser != null) {
//       print("Log In: $firebaseUser");
//       authNotifier.setUser(firebaseUser as FirebaseAuth);
//     }
//   }
// }

// signup(User.User user, AuthNotifier authNotifier) async {
//   UserCredential authCredential = await FirebaseAuth.instance
//       .createUserWithEmailAndPassword(
//           email: user.email, password: user.password)
//       .catchError((error) => print(error.code));

//   if (authCredential != null) {
//     AdditionalUserInfo additionalUserInfo =
//         AdditionalUserInfo(isNewUser: identical(1, 2));

//     additionalUserInfo = user.displayName as AdditionalUserInfo;

//     User.User firebaseUser = authCredential.user as User.User;

//     if (firebaseUser != null) {
//       await firebaseUser.updateProfile(authNotifier);

//       await firebaseUser.reload();

//       print("Sign up: $firebaseUser");

//       User.User currentUser = (await FirebaseAuth.instance.currentUser) as User.User;
//     }
//   }
// }

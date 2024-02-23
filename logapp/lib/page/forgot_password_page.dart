// ignore_for_file: prefer_const_constructors

// import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_forgot_password/utils.dart';
// import 'package:flutter/material.dart';

// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({super.key});

//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           title: Text('Reset Password'),
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(16),
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Receive an email to,\n reset your password',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 40),
//                 TextFormField(
//                   controller: emailController,
//                   cursorColor: Colors.white,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(labelText: 'Email'),
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: (email) =>
//                       email != null && !EmailValidator.validate(email)
//                           ? 'Enter a valid email'
//                           : null,
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size.fromHeight(50),
//                   ),
//                   icon: Icon(
//                     Icons.email_outlined,
//                     size: 32,
//                   ),
//                   label: Text(
//                     'Reset Password',
//                     style: TextStyle(fontSize: 24),
//                   ),
//                   onPressed: resetPassword,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );

//   Future resetPassword() async {}
// }

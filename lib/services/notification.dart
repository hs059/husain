//
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class Notification {
//
//   Notification._();
//   Notification notification =  Notification._();
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
//
//   registerOnFirebase()async {
//     firebaseMessaging.subscribeToTopic('all');
//
//     String token = await firebaseMessaging.getToken();
//     firebaseMessaging.subscribeToTopic(token);
//   }
//   void getMessage() {
//     firebaseMessaging.configure(
//         onMessage: (Map<String, dynamic> message) async {
//           print('received message');
//           // showNotification();
//           print(message);
//           setState(() {});
//         }, onResume: (Map<String, dynamic> message) async {
//       print('on resume ششششششششششش$message');
//
//       setState(() {});
//     }, onLaunch: (Map<String, dynamic> message) async {
//       print('on launch شششششششششششششش $message');
//       setState(() {});
//     });
//   }
//
//
//
// }
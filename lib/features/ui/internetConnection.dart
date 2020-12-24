//
//
// import 'package:beauty/services/connectivity.dart';
// import 'package:beauty/value/style.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'signUI/widgets/title&subTitleAuth.dart';
//
// class InternetConnection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: StreamBuilder<ConnectivityStatus>(stream: ConnectivityService.connectionStatusController.stream,
//               builder: (context, snapshot) {
//                 if(snapshot.hasData){                   Navigator.pop(context);
//                       return Container();
//                 }
//                 else{
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           child: Image.asset('assets/gif/internet.gif', fit: BoxFit.cover),
//                         ),
//                         TitleSubTitle(
//                           title: 'لا يوجد اتصال بالانترنت',
//                           subTitle: 'يرجى فحص الاتصال بالشبكة',
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//
//               }
//           )
//
//       ),
//     );
//   }
// }
// // https://3beauty.net/wp-content/uploads/2020/11/43-150x150.jpg
// // https://3beauty.net/wp-content/uploads/2020/11/35.jpg
// // https://3beauty.net/wp-content/uploads/2020/11/42.jpg
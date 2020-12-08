//
//
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geocoder/model.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MyMap extends StatefulWidget {
//   @override
//   _MyMapState createState() => _MyMapState();
// }
//
// class _MyMapState extends State<MyMap> {
//   final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//
//   static LatLng flutterCoffee = LatLng(31.509557, 34.421466);
//
//   Set<Marker> myMarkers = {
//     Marker(
//       infoWindow: InfoWindow(title: 'flutterCoffee'),
//       markerId: MarkerId('flutterCoffee'),
//       position: flutterCoffee,
//     ),
//   };
//   GoogleMapController controller;
//
//   LatLng myLocation;
//   String locationName;
//
//   Future<LatLng> getCurrentLocation() async {
//     Geolocator geolocator = Geolocator();
//     Position position = await geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     myLocation = LatLng(position.latitude, position.longitude);
//     return myLocation;
//   }
//
//   AnimateCamera(LatLng location) {
//     controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(tilt: 40, target: location, zoom: 13.2),
//       ),
//     );
//     setState(() {});
//   }
//
//   getPlaceName(LatLng position) async {
//     try {
//       List<Address> addresses = await Geocoder.local
//           .findAddressesFromCoordinates(
//           Coordinates(position.latitude, position.longitude));
//       Address first = addresses[0];
//       locationName = first.addressLine;
//       print(first.addressLine);
//       setState(() {}); // print(first.addressLine);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           GoogleMap(
//             onMapCreated: (controller) async {
//               this.controller = controller;
//               await getCurrentLocation();
//               AnimateCamera(
//                 flutterCoffee,
//               );
//             },
//             onTap: (argument) async {
//               myMarkers.add(
//                 Marker(
//                   infoWindow: InfoWindow(title: locationName),
//                   markerId: MarkerId('argument'),
//                   position: LatLng(argument.latitude, argument.longitude),
//                 ),
//               );
//               await getPlaceName(argument);
//               setState(() {});
//             },
//             markers: {
//               ...?myMarkers,
//             },
//             initialCameraPosition: CameraPosition(
//               target: flutterCoffee,
//               zoom: 20.0,
//             ),
//           ),
//           Positioned(
//             bottom: 90,
//             right: 8,
//             child: IconButton(
//               icon: Icon(Icons.gps_fixed),
//               color: Color.fromARGB(100, 17, 19, 40),
//               iconSize: 28,
//               onPressed: () async {
//                 AnimateCamera(myLocation);
//                 myMarkers.add(
//                   Marker(
//                     infoWindow: InfoWindow(title: 'myLocation'),
//                     markerId: MarkerId('myLocation'),
//                     position: LatLng(myLocation.latitude, myLocation.longitude),
//                     icon: BitmapDescriptor.defaultMarkerWithHue(
//                         BitmapDescriptor.hueOrange),
//                   ),
//                 );
//                 await getPlaceName(myLocation);
//               },
//             ),
//           ),
//           Positioned(
//             bottom: 125,
//             right: 8,
//             child: IconButton(
//               icon: Icon(FontAwesomeIcons.locationArrow),
//               color: Color.fromARGB(110, 17, 19, 40),
//               iconSize: 25,
//               onPressed: () async {
//                 AnimateCamera(flutterCoffee);
//                 await getPlaceName(flutterCoffee);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

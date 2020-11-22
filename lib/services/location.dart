
import 'package:geolocator/geolocator.dart';


class Location {

  Location._();
  static final  Location location =   Location._();
  Position currentPosition;
  String currentAddress;
  String name;
  String phoneNum;
  Geolocator geolocator ;

  Future<Geolocator> initGeolocator() async {
    if (geolocator == null) {
      geolocator = Geolocator()..forceAndroidLocationManager;
      return geolocator;
    } else {
      return geolocator;
    }
  }

  getCurrentLocation()async{
    geolocator =await initGeolocator();
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
        currentPosition = position;
      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  getAddressFromLatLng() async {
    try {
      geolocator =await initGeolocator();
      List<Placemark> p =
      // await geolocator.placemarkFromCoordinates(21.324220, 39.114267);
      await geolocator.placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
        currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
        print(currentAddress);
        return currentAddress ;
    } catch (e) {
      print(e);
    }
  }


}
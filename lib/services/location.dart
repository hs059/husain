
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';


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
      await geolocator.placemarkFromCoordinates(21.324220, 39.114267);
      // await geolocator.placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
        currentAddress =
        "${place.locality}, ${place.administrativeArea}, ${place.subLocality}";
        Logger().d(' postalCode ${place.postalCode}');
        Logger().d(' name ${place.name}');
        Logger().d(' locality ${place.locality}');
        Logger().d(' administrativeArea ${place.administrativeArea}');
        Logger().d(' subAdministrativeArea ${place.subAdministrativeArea}');
        Logger().d(' subLocality ${place.subLocality}');
        Logger().d(' address : ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}');
        Logger().d(' address : ${place.country}, ${place.administrativeArea}, ${place.locality}, ${place.subLocality}');

        return currentAddress ;
    } catch (e) {
      print(e);
    }
  }


}
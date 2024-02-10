import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SecureAreasMap extends StatefulWidget {
  @override
  _SecureAreasMapState createState() => _SecureAreasMapState();
}

class _SecureAreasMapState extends State<SecureAreasMap> {
  GoogleMapController? mapController;
  Set<Marker> markers = Set();
  LocationData? currentLocationData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData? _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    LatLng currentLocation = LatLng(_locationData.latitude!, _locationData.longitude!);

    setState(() {
      currentLocationData = _locationData;
      mapController!.animateCamera(CameraUpdate.newLatLngZoom(currentLocation, 12));
      markers.add(Marker(
        markerId: MarkerId('Current Location'),
        position: currentLocation,
        icon: BitmapDescriptor.defaultMarker,
      ));

      // Ajouter les marqueurs des zones sécurisées
      markers.add(Marker(
        markerId: MarkerId('Commissariat de police'),
        position: LatLng(48.8566, 2.3522), // Coordonnées du commissariat de police
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));

      markers.add(Marker(
        markerId: MarkerId('Hôpital'),
        position: LatLng(48.8599, 2.3470), // Coordonnées de l'hôpital
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));

      markers.add(Marker(
        markerId: MarkerId('École'),
        position: LatLng(48.8647, 2.3490), // Coordonnées de l'école
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));

      markers.add(Marker(
        markerId: MarkerId('Camp militaire'),
        position: LatLng(48.8705, 2.3039), // Coordonnées du camp militaire
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));

      isLoading = false; // Indicateur de chargement terminé
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009FE3),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,  // Largeur souhaitée de l'image
              height: 90, // Hauteur souhaitée de l'image
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            markers: markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
              zoom: 1,
            ),
          ),
          if (isLoading) // Afficher l'image de la carte si le chargement est en cours
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/images/carte.jpg',
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
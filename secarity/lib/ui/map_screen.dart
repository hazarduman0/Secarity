import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(40.1885, 29.0610),
          zoom: 9.2,
        ),
        // nonRotatedChildren: [
        //   Container(height: 100,width: 100, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),)
        // ],
        children: [
          TileLayer(
            urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png', //'http://api.tomtom.com/map/1/tile/basic/main/{z}/{x}/{y}.png?key=subscription_key',//'https://snowmap.fast-sfc.com/base_snow_map/{z}/{x}/{y}.png',//'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
        ],
      ),
    );
  }
}

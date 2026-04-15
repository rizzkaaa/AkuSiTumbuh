import 'dart:convert';
import 'package:akusitumbuh/models/kabupaten_data_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


final List<KabupatenData> kabupatenList = [
  KabupatenData(name: 'Bangka', persenStunting: 28.4),
  KabupatenData(name: 'Bangka Barat', persenStunting: 36.2),
  KabupatenData(name: 'Bangka Tengah', persenStunting: 26.7),
  KabupatenData(name: 'Bangka Selatan', persenStunting: 34.1),
  KabupatenData(name: 'Belitung', persenStunting: 21.3),
  KabupatenData(name: 'Belitung Timur', persenStunting: 33),
  KabupatenData(name: 'Pangkalpinang', persenStunting: 19.2),
];
class GeoJsonMap extends StatefulWidget {
  final List<KabupatenData> kabupatenList;
  final Function(KabupatenData) onTap;

  const GeoJsonMap({
    super.key,
    required this.kabupatenList,
    required this.onTap,
  });

  @override
  State<GeoJsonMap> createState() => _GeoJsonMapState();
}

Color getColor(double persen) {
  if (persen >= 35) return const Color(0xFFB71C1C); // sangat tinggi
  if (persen >= 30) return const Color(0xFFE57373); // tinggi
  if (persen >= 20) return const Color(0xFFEF9A9A); // sedang
  return const Color(0xFFFFEBEE); // rendah
}

class _GeoJsonMapState extends State<GeoJsonMap> {
  List<Polygon> polygons = [];

  @override
  void initState() {
    super.initState();
    loadGeoJson();
  }

  Future<void> loadGeoJson() async {
    List<String> paths = [
      'assets/data-maps/19.01_Bangka/19.01_Bangka.geojson',
      'assets/data-maps/19.02_Belitung/19.02_Belitung.geojson',
      'assets/data-maps/19.03_Bangka_Selatan/19.03_Bangka_Selatan.geojson',
      'assets/data-maps/19.04_Bangka_Tengah/19.04_Bangka_Tengah.geojson',
      'assets/data-maps/19.05_Bangka_Barat/19.05_Bangka_Barat.geojson',
      'assets/data-maps/19.06_Belitung_Timur/19.06_Belitung_Timur.geojson',
    ];

    List<Polygon> temp = [];

    for (String path in paths) {
      final data = await rootBundle.loadString(path);
      final jsonData = json.decode(data);

      for (var feature in jsonData['features']) {
        print(feature['properties']);
        final name = feature['properties']['nm_dati2'] ?? '';

        final cleanName = name
            .toLowerCase()
            .replaceAll("kab.", "")
            .replaceAll("kabupaten", "")
            .trim();

        KabupatenData? kab;

        for (var k in widget.kabupatenList) {
          if (cleanName == k.name.toLowerCase()) {
            kab = k;
            break;
          }
        }

        if (kab == null) {
          print("TIDAK MATCH: $cleanName");
          continue;
        }

        final geometry = feature['geometry'];
        final type = geometry['type'];
        final coords = geometry['coordinates'];

        List polygonsData = [];

        if (type == 'Polygon') {
          polygonsData = [coords];
        } else if (type == 'MultiPolygon') {
          polygonsData = coords;
        }

        for (var polygon in polygonsData) {
          for (var ring in polygon) {
            List<LatLng> points = [];

            for (var point in ring) {
              points.add(LatLng(point[1], point[0]));
            }

            temp.add(
              Polygon(
                points: points,
                color: getColor(kab.persenStunting).withOpacity(0.6),
                borderColor: Colors.white,
                borderStrokeWidth: 1,
              ),
            );
          }
        }
      }
    }

    setState(() {
      polygons = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(initialCenter: LatLng(-2.5, 106.0), initialZoom: 8),
      children: [
        TileLayer(
          urlTemplate:
              "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
          subdomains: ['a', 'b', 'c', 'd'],
        ),
        PolygonLayer(polygons: polygons),
      ],
    );
  }
}

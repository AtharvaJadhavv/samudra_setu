/*
// lib/map.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// A simple data class for our map markers
class HazardInfo {
  final LatLng point;
  final Color color;
  final String type;
  final String title;
  final String details;

  HazardInfo({
    required this.point,
    required this.color,
    required this.type,
    required this.title,
    required this.details,
  });
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // State variables for filters and selected hazard
  String _selectedHazardType = 'All Hazards';
  HazardInfo? _selectedHazardInfo;

  // Master list of all possible markers
  final List<HazardInfo> _allHazards = [
    HazardInfo(point: const LatLng(11.9416, 79.8083), color: Colors.red, type: 'Tsunami Alert', title: 'Tsunami Warning - Level 3', details: 'High-risk tsunami conditions detected near Tamil Nadu coast.'),
    HazardInfo(point: const LatLng(15.5000, 80.8400), color: Colors.red, type: 'Tsunami Alert', title: 'Tsunami Watch - Level 2', details: 'Potential tsunami threat. Stay alert for updates.'),
    HazardInfo(point: const LatLng(13.0827, 80.2707), color: Colors.orange, type: 'Storm Surge', title: 'Severe Storm Surge', details: 'Severe storm surge expected with high winds. Avoid coastal areas.'),
    HazardInfo(point: const LatLng(10.8505, 76.2711), color: Colors.blue, type: 'High Waves', title: 'High Wave Alert', details: 'Unusually high waves reported. Small craft advisory in effect.'),
    HazardInfo(point: const LatLng(9.9312, 76.2673), color: Colors.blue, type: 'High Waves', title: 'Moderate Wave Activity', details: 'Increased wave activity. Exercise caution near the water.'),
    HazardInfo(point: const LatLng(12.2958, 76.6394), color: Colors.green, type: 'Safe Zone', title: 'Designated Safe Zone', details: 'This is a designated safe zone. Evacuees report here.'),
  ];

  List<HazardInfo> _visibleHazards = [];

  @override
  void initState() {
    super.initState();
    _visibleHazards = List.from(_allHazards);
  }

  void _filterMarkers() {
    setState(() {
      _selectedHazardInfo = null; // Clear details when filtering
      if (_selectedHazardType == 'All Hazards') {
        _visibleHazards = List.from(_allHazards);
      } else {
        _visibleHazards = _allHazards.where((hazard) => hazard.type == _selectedHazardType).toList();
      }
    });
  }

  // --- BUILD METHODS ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(12.9716, 77.5946),
              initialZoom: 6.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.yourapp.samudrasetu',
              ),
              MarkerLayer(markers: _buildMarkers()),
            ],
          ),
          _buildFilterBar(),
          _buildHazardLegend(),
          _buildBottomInfoSheet(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  List<Marker> _buildMarkers() {
    return _visibleHazards.map((hazard) {
      return Marker(
        point: hazard.point,
        width: 60,
        height: 60,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedHazardInfo = hazard;
            });
          },
          child: CircleAvatar(
            backgroundColor: hazard.color.withOpacity(0.7),
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white,
              child: CircleAvatar(radius: 8, backgroundColor: hazard.color),
            ),
          ),
        ),
      );
    }).toList();
  }

  // --- UI WIDGETS ---

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF0A4E6C),
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.waves_outlined, color: Color(0xFF0A4E6C), size: 24),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SamudraSetu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18), overflow: TextOverflow.ellipsis),
                Text('Stay Safe, Stay Informed', style: TextStyle(color: Colors.white70, fontSize: 12), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Positioned(
      top: 10, left: 10, right: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), spreadRadius: 1, blurRadius: 10)],
        ),
        child: DropdownButton<String>(
          value: _selectedHazardType,
          isExpanded: true,
          underline: const SizedBox(), // Hides the underline
          icon: const Icon(Icons.filter_list, color: Color(0xFF0A4E6C)),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedHazardType = newValue;
                _filterMarkers();
              });
            }
          },
          items: <String>['All Hazards', 'Tsunami Alert', 'Storm Surge', 'High Waves', 'Safe Zone']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: Colors.grey[800])),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildHazardLegend() {
    return Positioned(
      top: 80, right: 15,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), spreadRadius: 1, blurRadius: 10)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hazard Legend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            _buildLegendItem(Colors.red, 'Tsunami Alert'),
            const SizedBox(height: 8),
            _buildLegendItem(Colors.orange, 'Storm Surge'),
            const SizedBox(height: 8),
            _buildLegendItem(Colors.blue, 'High Waves'),
            const SizedBox(height: 8),
            _buildLegendItem(Colors.green, 'Safe Zone'),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }

  Widget _buildBottomInfoSheet() {
    return Positioned(
      bottom: 0, left: 0, right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 20)],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _selectedHazardInfo == null
              ? _buildDefaultInfoContent()
              : _buildHazardDetailsContent(_selectedHazardInfo!),
        ),
      ),
    );
  }

  Widget _buildDefaultInfoContent() {
    return const Column(
      key: ValueKey('default'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.drag_handle, color: Colors.grey),
        SizedBox(height: 8),
        Text('Tap on any hazard pin to view details', style: TextStyle(fontSize: 16, color: Colors.black54)),
      ],
    );
  }

  Widget _buildHazardDetailsContent(HazardInfo info) {
    return Column(
      key: ValueKey(info.title),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: info.color, radius: 8),
                const SizedBox(width: 8),
                Text(info.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => setState(() => _selectedHazardInfo = null),
            )
          ],
        ),
        const SizedBox(height: 8),
        Text(info.details, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
        BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'SOCIAL'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
      ],
      currentIndex: 1,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        if (index == 0) Navigator.pop(context);
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}*//*

// lib/map.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'report.dart';

// A simple data class for our map markers
class HazardInfo {
  final LatLng point;
  final Color color;
  final String type;
  final String title;
  final String details;

  HazardInfo({
    required this.point,
    required this.color,
    required this.type,
    required this.title,
    required this.details,
  });
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // State variables for filters and selected hazard
  String _selectedHazardType = 'All Hazards';
  HazardInfo? _selectedHazardInfo;

  // Master list of all possible markers
  final List<HazardInfo> _allHazards = [
    HazardInfo(point: const LatLng(11.9416, 79.8083), color: Colors.red, type: 'Tsunami Alert', title: 'Tsunami Warning - Level 3', details: 'High-risk tsunami conditions detected near Tamil Nadu coast.'),
    HazardInfo(point: const LatLng(15.5000, 80.8400), color: Colors.red, type: 'Tsunami Alert', title: 'Tsunami Watch - Level 2', details: 'Potential tsunami threat. Stay alert for updates.'),
    HazardInfo(point: const LatLng(13.0827, 80.2707), color: Colors.orange, type: 'Storm Surge', title: 'Severe Storm Surge', details: 'Severe storm surge expected with high winds. Avoid coastal areas.'),
    HazardInfo(point: const LatLng(10.8505, 76.2711), color: Colors.blue, type: 'High Waves', title: 'High Wave Alert', details: 'Unusually high waves reported. Small craft advisory in effect.'),
    HazardInfo(point: const LatLng(9.9312, 76.2673), color: Colors.blue, type: 'High Waves', title: 'Moderate Wave Activity', details: 'Increased wave activity. Exercise caution near the water.'),
    HazardInfo(point: const LatLng(12.2958, 76.6394), color: Colors.green, type: 'Safe Zone', title: 'Designated Safe Zone', details: 'This is a designated safe zone. Evacuees report here.'),
  ];

  List<HazardInfo> _visibleHazards = [];

  @override
  void initState() {
    super.initState();
    _visibleHazards = List.from(_allHazards);
  }

  void _filterMarkers() {
    setState(() {
      _selectedHazardInfo = null; // Clear details when filtering
      if (_selectedHazardType == 'All Hazards') {
        _visibleHazards = List.from(_allHazards);
      } else {
        _visibleHazards = _allHazards.where((hazard) => hazard.type == _selectedHazardType).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(12.9716, 77.5946),
              initialZoom: 6.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.yourapp.samudrasetu', // CHANGE to your package name
              ),
              MarkerLayer(markers: _buildMarkers()),
            ],
          ),
          _buildFilterBar(),
          _buildHazardLegend(),
          _buildBottomInfoSheet(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  List<Marker> _buildMarkers() {
    return _visibleHazards.map((hazard) {
      return Marker(
        point: hazard.point,
        width: 60,
        height: 60,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedHazardInfo = hazard;
            });
          },
          child: CircleAvatar(
            backgroundColor: hazard.color.withOpacity(0.7),
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white,
              child: CircleAvatar(radius: 8, backgroundColor: hazard.color),
            ),
          ),
        ),
      );
    }).toList();
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF0A4E6C),
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.waves_outlined, color: Color(0xFF0A4E6C), size: 24),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SamudraSetu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18), overflow: TextOverflow.ellipsis),
                Text('Stay Safe, Stay Informed', style: TextStyle(color: Colors.white70, fontSize: 12), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Positioned(
      top: 10, left: 10, right: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), spreadRadius: 1, blurRadius: 10)],
        ),
        child: DropdownButton<String>(
          value: _selectedHazardType,
          isExpanded: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.filter_list, color: Color(0xFF0A4E6C)),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedHazardType = newValue;
                _filterMarkers();
              });
            }
          },
          items: <String>['All Hazards', 'Tsunami Alert', 'Storm Surge', 'High Waves', 'Safe Zone']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: Colors.grey[800])),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildHazardLegend() {
    return Positioned(
      top: 80, right: 15,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), spreadRadius: 1, blurRadius: 10)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hazard Legend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            _buildLegendItem(Colors.red, 'Tsunami Alert'),
            const SizedBox(height: 8),
            _buildLegendItem(Colors.orange, 'Storm Surge'),
            const SizedBox(height: 8),
            _buildLegendItem(Colors.blue, 'High Waves'),
            const SizedBox(height: 8),
            _buildLegendItem(Colors.green, 'Safe Zone'),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }

  Widget _buildBottomInfoSheet() {
    return Positioned(
      bottom: 0, left: 0, right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 20)],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _selectedHazardInfo == null
              ? _buildDefaultInfoContent()
              : _buildHazardDetailsContent(_selectedHazardInfo!),
        ),
      ),
    );
  }

  Widget _buildDefaultInfoContent() {
    return const Column(
      key: ValueKey('default'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.drag_handle, color: Colors.grey),
        SizedBox(height: 8),
        Text('Tap on any hazard pin to view details', style: TextStyle(fontSize: 16, color: Colors.black54)),
      ],
    );
  }

  Widget _buildHazardDetailsContent(HazardInfo info) {
    return Column(
      key: ValueKey(info.title),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: info.color, radius: 8),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(info.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => setState(() => _selectedHazardInfo = null),
            )
          ],
        ),
        const SizedBox(height: 8),
        Text(info.details, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
        BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'SOCIAL'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
      ],
      currentIndex: 1,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        if (index == 0) {
          Navigator.pop(context);
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}*/
// lib/map.dart
/*
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'report.dart';
import 'social.dart';

// A simple data class for our map markers
class HazardInfo {
  final LatLng point;
  final Color color;
  final String type;
  final String title;
  final String details;

  HazardInfo({
    required this.point,
    required this.color,
    required this.type,
    required this.title,
    required this.details,
  });
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _selectedHazardType = 'All Hazards';
  HazardInfo? _selectedHazardInfo;

  final List<HazardInfo> _allHazards = [
    HazardInfo(point: const LatLng(11.9416, 79.8083), color: Colors.red, type: 'Tsunami Alert', title: 'Tsunami Warning - Level 3', details: 'High-risk tsunami conditions detected near Tamil Nadu coast.'),
    HazardInfo(point: const LatLng(15.5000, 80.8400), color: Colors.red, type: 'Tsunami Alert', title: 'Tsunami Watch - Level 2', details: 'Potential tsunami threat. Stay alert for updates.'),
    HazardInfo(point: const LatLng(13.0827, 80.2707), color: Colors.orange, type: 'Storm Surge', title: 'Severe Storm Surge', details: 'Severe storm surge expected with high winds. Avoid coastal areas.'),
    HazardInfo(point: const LatLng(10.8505, 76.2711), color: Colors.blue, type: 'High Waves', title: 'High Wave Alert', details: 'Unusually high waves reported. Small craft advisory in effect.'),
    HazardInfo(point: const LatLng(9.9312, 76.2673), color: Colors.blue, type: 'High Waves', title: 'Moderate Wave Activity', details: 'Increased wave activity. Exercise caution near the water.'),
    HazardInfo(point: const LatLng(12.2958, 76.6394), color: Colors.green, type: 'Safe Zone', title: 'Designated Safe Zone', details: 'This is a designated safe zone. Evacuees report here.'),
  ];

  List<HazardInfo> _visibleHazards = [];

  @override
  void initState() {
    super.initState();
    _visibleHazards = List.from(_allHazards);
  }

  void _filterMarkers() {
    setState(() {
      _selectedHazardInfo = null; // Clear details when filtering
      if (_selectedHazardType == 'All Hazards') {
        _visibleHazards = List.from(_allHazards);
      } else {
        _visibleHazards = _allHazards.where((hazard) => hazard.type == _selectedHazardType).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(12.9716, 77.5946),
              initialZoom: 6.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.yourapp.samudrasetu', // CHANGE to your package name
              ),
              MarkerLayer(markers: _buildMarkers()),
            ],
          ),
          _buildFilterBar(),
          _buildHazardLegend(),
          _buildBottomInfoSheet(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  List<Marker> _buildMarkers() {
    return _visibleHazards.map((hazard) {
      return Marker(
        point: hazard.point,
        width: 60,
        height: 60,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedHazardInfo = hazard;
            });
          },
          child: CircleAvatar(
            backgroundColor: hazard.color.withOpacity(0.7),
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white,
              child: CircleAvatar(radius: 8, backgroundColor: hazard.color),
            ),
          ),
        ),
      );
    }).toList();
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF0A4E6C),
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.waves_outlined, color: Color(0xFF0A4E6C), size: 24),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SamudraSetu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18), overflow: TextOverflow.ellipsis),
                Text('Stay Safe, Stay Informed', style: TextStyle(color: Colors.white70, fontSize: 12), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Positioned(
      top: 10, left: 10, right: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), spreadRadius: 1, blurRadius: 10)],
        ),
        child: DropdownButton<String>(
          value: _selectedHazardType,
          isExpanded: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.filter_list, color: Color(0xFF0A4E6C)),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedHazardType = newValue;
                _filterMarkers();
              });
            }
          },
          items: <String>['All Hazards', 'Tsunami Alert', 'Storm Surge', 'High Waves', 'Safe Zone']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: Colors.grey[800])),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildHazardLegend() {
    return Positioned(
      top: 80, right: 15,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), spreadRadius: 1, blurRadius: 10)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hazard Legend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            _buildLegendItem(Colors.red, 'Tsunami Alert'),
            const SizedBox(height: 8),
            _buildLegendItem(Colors.orange, 'Storm Surge'),
            const SizedBox(height: 8),
            _buildLegendItem(Colors.blue, 'High Waves'),
            const SizedBox(height: 8),
            _buildLegendItem(Colors.green, 'Safe Zone'),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }

  Widget _buildBottomInfoSheet() {
    return Positioned(
      bottom: 0, left: 0, right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 20)],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _selectedHazardInfo == null
              ? _buildDefaultInfoContent()
              : _buildHazardDetailsContent(_selectedHazardInfo!),
        ),
      ),
    );
  }

  Widget _buildDefaultInfoContent() {
    return const Column(
      key: ValueKey('default'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.drag_handle, color: Colors.grey),
        SizedBox(height: 8),
        Text('Tap on any hazard pin to view details', style: TextStyle(fontSize: 16, color: Colors.black54)),
      ],
    );
  }

  Widget _buildHazardDetailsContent(HazardInfo info) {
    return Column(
      key: ValueKey(info.title),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: info.color, radius: 8),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(info.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => setState(() => _selectedHazardInfo = null),
            )
          ],
        ),
        const SizedBox(height: 8),
        Text(info.details, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
        BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
        BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'SOCIAL'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
      ],
      currentIndex: 1,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pop(context);
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
            break;
          case 3:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SocialScreen()));
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}*/
// lib/map.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'report.dart';
import 'social.dart';
import 'alert.dart';

class HazardInfo {
  final LatLng point;
  final Color color;
  final String type;
  final String title;
  final String details;

  HazardInfo({required this.point, required this.color, required this.type, required this.title, required this.details});
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _selectedHazardType = 'All Hazards';
  HazardInfo? _selectedHazardInfo;

  final List<HazardInfo> _allHazards = [
    HazardInfo(point: const LatLng(11.9416, 79.8083), color: Colors.red, type: 'Tsunami Alert', title: 'Tsunami Warning - Level 3', details: 'High-risk tsunami conditions detected near Tamil Nadu coast.'),
    HazardInfo(point: const LatLng(15.5000, 80.8400), color: Colors.red, type: 'Tsunami Alert', title: 'Tsunami Watch - Level 2', details: 'Potential tsunami threat. Stay alert for updates.'),
    HazardInfo(point: const LatLng(13.0827, 80.2707), color: Colors.orange, type: 'Storm Surge', title: 'Severe Storm Surge', details: 'Severe storm surge expected with high winds. Avoid coastal areas.'),
    HazardInfo(point: const LatLng(10.8505, 76.2711), color: Colors.blue, type: 'High Waves', title: 'High Wave Alert', details: 'Unusually high waves reported. Small craft advisory in effect.'),
    HazardInfo(point: const LatLng(9.9312, 76.2673), color: Colors.blue, type: 'High Waves', title: 'Moderate Wave Activity', details: 'Increased wave activity. Exercise caution near the water.'),
    HazardInfo(point: const LatLng(12.2958, 76.6394), color: Colors.green, type: 'Safe Zone', title: 'Designated Safe Zone', details: 'This is a designated safe zone. Evacuees report here.'),
  ];

  List<HazardInfo> _visibleHazards = [];

  @override
  void initState() {
    super.initState();
    _visibleHazards = List.from(_allHazards);
  }

  void _filterMarkers() {
    setState(() {
      _selectedHazardInfo = null;
      if (_selectedHazardType == 'All Hazards') {
        _visibleHazards = List.from(_allHazards);
      } else {
        _visibleHazards = _allHazards.where((hazard) => hazard.type == _selectedHazardType).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(initialCenter: LatLng(12.9716, 77.5946), initialZoom: 6.5),
            children: [
              TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.yourapp.samudrasetu'),
              MarkerLayer(markers: _buildMarkers()),
            ],
          ),
          _buildFilterBar(),
          _buildHazardLegend(),
          _buildBottomInfoSheet(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  List<Marker> _buildMarkers() {
    return _visibleHazards.map((hazard) {
      return Marker(
        point: hazard.point,
        width: 60,
        height: 60,
        child: GestureDetector(
          onTap: () => setState(() => _selectedHazardInfo = hazard),
          child: CircleAvatar(
            backgroundColor: hazard.color.withOpacity(0.7),
            child: CircleAvatar(radius: 10, backgroundColor: Colors.white, child: CircleAvatar(radius: 8, backgroundColor: hazard.color)),
          ),
        ),
      );
    }).toList();
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF0A4E6C),
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.waves_outlined, color: Color(0xFF0A4E6C), size: 24),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SamudraSetu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18), overflow: TextOverflow.ellipsis),
                Text('Stay Safe, Stay Informed', style: TextStyle(color: Colors.white70, fontSize: 12), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Positioned(
      top: 10, left: 10, right: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), spreadRadius: 1, blurRadius: 10)]),
        child: DropdownButton<String>(
          value: _selectedHazardType,
          isExpanded: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.filter_list, color: Color(0xFF0A4E6C)),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() => _selectedHazardType = newValue);
              _filterMarkers();
            }
          },
          items: <String>['All Hazards', 'Tsunami Alert', 'Storm Surge', 'High Waves', 'Safe Zone']
              .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(value: value, child: Text(value, style: TextStyle(color: Colors.grey[800]))))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildHazardLegend() {
    return Positioned(
      top: 80, right: 15,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), spreadRadius: 1, blurRadius: 10)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hazard Legend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            _buildLegendItem(Colors.red, 'Tsunami Alert'),
            const SizedBox(height: 8),
            _buildLegendItem(Colors.orange, 'Storm Surge'),
            const SizedBox(height: 8),
            _buildLegendItem(Colors.blue, 'High Waves'),
            const SizedBox(height: 8),
            _buildLegendItem(Colors.green, 'Safe Zone'),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }

  Widget _buildBottomInfoSheet() {
    return Positioned(
      bottom: 0, left: 0, right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)), boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 20)]),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _selectedHazardInfo == null ? _buildDefaultInfoContent() : _buildHazardDetailsContent(_selectedHazardInfo!),
        ),
      ),
    );
  }

  Widget _buildDefaultInfoContent() {
    return const Column(
      key: ValueKey('default'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.drag_handle, color: Colors.grey),
        SizedBox(height: 8),
        Text('Tap on any hazard pin to view details', style: TextStyle(fontSize: 16, color: Colors.black54)),
      ],
    );
  }

  Widget _buildHazardDetailsContent(HazardInfo info) {
    return Column(
      key: ValueKey(info.title),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: info.color, radius: 8),
                  const SizedBox(width: 8),
                  Flexible(child: Text(info.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
            IconButton(icon: const Icon(Icons.close), onPressed: () => setState(() => _selectedHazardInfo = null))
          ],
        ),
        const SizedBox(height: 8),
        Text(info.details, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
        BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
        BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'SOCIAL'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
      ],
      currentIndex: 1,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pop(context);
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
            break;
          case 3:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SocialScreen()));
            break;
          case 4:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AlertsScreen()));
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}
/*
// lib/alerts.dart
import 'package.flutter/material.dart';
import 'map.dart';
import 'report.dart';
import 'social.dart';

// --- Data Model for an Alert ---
class AlertInfo {
  final String title;
  final String riskLevel;
  final String location;
  final String description;
  final String timeAgo;
  final IconData icon;
  final Color color;
  final bool isActive;

  AlertInfo({
    required this.title,
    required this.riskLevel,
    required this.location,
    required this.description,
    required this.timeAgo,
    required this.icon,
    required this.color,
    this.isActive = true,
  });
}

// --- Main Alerts Screen Widget ---
class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List<AlertInfo> _filteredAlerts = [];

  // --- Master list of all alerts ---
  final List<AlertInfo> _allAlerts = [
    AlertInfo(title: 'High Wave Alert', riskLevel: 'Tsunami Risk', location: 'Chennai, Marina Beach & Surrounding Areas', description: 'Abnormally high waves detected. Immediate evacuation recommended for coastal areas within 2km of shoreline.', timeAgo: '15 minutes ago', icon: Icons.tsunami_outlined, color: Colors.red),
    AlertInfo(title: 'Cyclone Warning', riskLevel: 'Moderate Risk', location: 'Kochi, Kerala Coast', description: 'Cyclonic storm approaching. Wind speeds up to 85 km/h expected. Secure loose objects and avoid coastal areas.', timeAgo: '2 hours ago', icon: Icons.cyclone_outlined, color: Colors.orange),
    AlertInfo(title: 'High Tide Advisory', riskLevel: 'Minor Risk', location: 'Mumbai, Maharashtra Coast', description: 'Higher than normal tides expected. Fishing activities should be avoided. Low-lying areas may experience minor flooding.', timeAgo: '4 hours ago', icon: Icons.warning_amber_outlined, color: Colors.amber),
    AlertInfo(title: 'Past: Low Pressure System', riskLevel: 'Ended', location: 'Goa Coast', description: 'The low-pressure system has dissipated. Conditions are now safe.', timeAgo: '1 day ago', icon: Icons.cloud_done_outlined, color: Colors.grey, isActive: false),
    AlertInfo(title: 'Past: Small Craft Advisory', riskLevel: 'Ended', location: 'Puducherry Coast', description: 'The advisory for small craft has been lifted.', timeAgo: '3 days ago', icon: Icons.directions_boat_outlined, color: Colors.grey, isActive: false),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filterAlerts(); // Initial filter
    _searchController.addListener(_filterAlerts);
    _tabController.addListener(_filterAlerts);
  }

  void _filterAlerts() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      final bool showActive = _tabController.index == 0;

      _filteredAlerts = _allAlerts.where((alert) {
        final matchesQuery = alert.location.toLowerCase().contains(query) || alert.title.toLowerCase().contains(query);
        final matchesTab = alert.isActive == showActive;
        return matchesQuery && matchesTab;
      }).toList();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildTabs(),
          Expanded(child: _buildAlertsList()),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // --- UI Widget Builders ---

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF0A4E6C),
      title: const Text('All Alerts', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: CircleAvatar(child: Icon(Icons.person)),
        ),
      ],
      elevation: 0,
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF0A4E6C),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search alerts by location or type...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFF0A4E6C),
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF0A4E6C),
        tabs: const [
          Tab(text: 'Active Alerts'),
          Tab(text: 'Past Alerts'),
        ],
      ),
    );
  }

  Widget _buildAlertsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _filteredAlerts.length,
      itemBuilder: (context, index) {
        return _buildAlertCard(_filteredAlerts[index]);
      },
    );
  }

  Widget _buildAlertCard(AlertInfo alert) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: alert.color, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: alert.color.withOpacity(0.1), child: Icon(alert.icon, color: alert.color)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${alert.title} - ${alert.riskLevel}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Row(children: [Icon(Icons.location_on, size: 14, color: Colors.grey), const SizedBox(width: 4), Expanded(child: Text(alert.location, style: const TextStyle(color: Colors.grey)))]),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(alert.description),
            ),
            Row(
              children: [
                Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(alert.timeAgo, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A4E6C), foregroundColor: Colors.white),
                child: const Text('View Details'),
              ),
            ),
          ],
        ),
      ),
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
      currentIndex: 4, // Current index is 4 for ALERTS
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.popUntil(context, (route) => route.isFirst);
            break;
          case 1:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MapScreen()));
            break;
          case 2:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
            break;
          case 3:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SocialScreen()));
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}*//*

// lib/alerts.dart
*/
/*
import 'package:flutter/material.dart';
import 'map.dart';
import 'report.dart';
import 'social.dart';

class AlertInfo {
  final String title;
  final String riskLevel;
  final String location;
  final String description;
  final String timeAgo;
  final IconData icon;
  final Color color;
  final bool isActive;

  AlertInfo({required this.title, required this.riskLevel, required this.location, required this.description, required this.timeAgo, required this.icon, required this.color, this.isActive = true});
}

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List<AlertInfo> _filteredAlerts = [];

  final List<AlertInfo> _allAlerts = [
    AlertInfo(title: 'High Wave Alert', riskLevel: 'Tsunami Risk', location: 'Chennai, Marina Beach & Surrounding Areas', description: 'Abnormally high waves detected. Immediate evacuation recommended for coastal areas within 2km of shoreline.', timeAgo: '15 minutes ago', icon: Icons.tsunami_outlined, color: Colors.red),
    AlertInfo(title: 'Cyclone Warning', riskLevel: 'Moderate Risk', location: 'Kochi, Kerala Coast', description: 'Cyclonic storm approaching. Wind speeds up to 85 km/h expected. Secure loose objects and avoid coastal areas.', timeAgo: '2 hours ago', icon: Icons.cyclone_outlined, color: Colors.orange),
    AlertInfo(title: 'High Tide Advisory', riskLevel: 'Minor Risk', location: 'Mumbai, Maharashtra Coast', description: 'Higher than normal tides expected. Fishing activities should be avoided. Low-lying areas may experience minor flooding.', timeAgo: '4 hours ago', icon: Icons.warning_amber_outlined, color: Colors.amber),
    AlertInfo(title: 'Past: Low Pressure System', riskLevel: 'Ended', location: 'Goa Coast', description: 'The low-pressure system has dissipated. Conditions are now safe.', timeAgo: '1 day ago', icon: Icons.cloud_done_outlined, color: Colors.grey, isActive: false),
    AlertInfo(title: 'Past: Small Craft Advisory', riskLevel: 'Ended', location: 'Puducherry Coast', description: 'The advisory for small craft has been lifted.', timeAgo: '3 days ago', icon: Icons.directions_boat_outlined, color: Colors.grey, isActive: false),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filterAlerts();
    _searchController.addListener(_filterAlerts);
    _tabController.addListener(_filterAlerts);
  }

  void _filterAlerts() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      final bool showActive = _tabController.index == 0;
      _filteredAlerts = _allAlerts.where((alert) {
        final matchesQuery = alert.location.toLowerCase().contains(query) || alert.title.toLowerCase().contains(query);
        final matchesTab = alert.isActive == showActive;
        return matchesQuery && matchesTab;
      }).toList();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildTabs(),
          Expanded(child: _buildAlertsList()),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF0A4E6C),
      title: const Text('All Alerts', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      actions: const [Padding(padding: EdgeInsets.only(right: 16.0), child: CircleAvatar(child: Icon(Icons.person)))],
      elevation: 0,
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF0A4E6C),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(hintText: 'Search alerts by location or type...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none)),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFF0A4E6C),
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF0A4E6C),
        tabs: const [Tab(text: 'Active Alerts'), Tab(text: 'Past Alerts')],
      ),
    );
  }

  Widget _buildAlertsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _filteredAlerts.length,
      itemBuilder: (context, index) => _buildAlertCard(_filteredAlerts[index]),
    );
  }

  Widget _buildAlertCard(AlertInfo alert) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: alert.color, width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: alert.color.withOpacity(0.1), child: Icon(alert.icon, color: alert.color)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${alert.title} - ${alert.riskLevel}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Row(children: [const Icon(Icons.location_on, size: 14, color: Colors.grey), const SizedBox(width: 4), Expanded(child: Text(alert.location, style: const TextStyle(color: Colors.grey)))]),
                    ],
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: Text(alert.description)),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(alert.timeAgo, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A4E6C), foregroundColor: Colors.white), child: const Text('View Details')),
            ),
          ],
        ),
      ),
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
      currentIndex: 4,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.popUntil(context, (route) => route.isFirst);
            break;
          case 1:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MapScreen()));
            break;
          case 2:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
            break;
          case 3:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SocialScreen()));
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}*//*

// lib/alerts.dart
import 'package:flutter/material.dart';
import 'map.dart';
import 'report.dart';
import 'social.dart';

// --- Data Model for an Alert ---
class AlertInfo {
  final String title;
  final String riskLevel;
  final String location;
  final String description;
  final String timeAgo;
  final IconData icon;
  final Color color;
  final bool isActive;

  AlertInfo({
    required this.title,
    required this.riskLevel,
    required this.location,
    required this.description,
    required this.timeAgo,
    required this.icon,
    required this.color,
    this.isActive = true,
  });
}

// --- Main Alerts Screen Widget ---
class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List<AlertInfo> _filteredAlerts = [];

  final List<AlertInfo> _allAlerts = [
    AlertInfo(title: 'High Wave Alert', riskLevel: 'Tsunami Risk', location: 'Chennai, Marina Beach & Surrounding Areas', description: 'Abnormally high waves detected. Immediate evacuation recommended for coastal areas within 2km of shoreline.', timeAgo: '15 minutes ago', icon: Icons.tsunami_outlined, color: Colors.red),
    AlertInfo(title: 'Cyclone Warning', riskLevel: 'Moderate Risk', location: 'Kochi, Kerala Coast', description: 'Cyclonic storm approaching. Wind speeds up to 85 km/h expected. Secure loose objects and avoid coastal areas.', timeAgo: '2 hours ago', icon: Icons.cyclone_outlined, color: Colors.orange),
    AlertInfo(title: 'High Tide Advisory', riskLevel: 'Minor Risk', location: 'Mumbai, Maharashtra Coast', description: 'Higher than normal tides expected. Fishing activities should be avoided. Low-lying areas may experience minor flooding.', timeAgo: '4 hours ago', icon: Icons.warning_amber_outlined, color: Colors.amber),
    AlertInfo(title: 'Past: Low Pressure System', riskLevel: 'Ended', location: 'Goa Coast', description: 'The low-pressure system has dissipated. Conditions are now safe.', timeAgo: '1 day ago', icon: Icons.cloud_done_outlined, color: Colors.grey, isActive: false),
    AlertInfo(title: 'Past: Small Craft Advisory', riskLevel: 'Ended', location: 'Puducherry Coast', description: 'The advisory for small craft has been lifted.', timeAgo: '3 days ago', icon: Icons.directions_boat_outlined, color: Colors.grey, isActive: false),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filterAlerts();
    _searchController.addListener(_filterAlerts);
    _tabController.addListener(_filterAlerts);
  }

  void _filterAlerts() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      final bool showActive = _tabController.index == 0;
      _filteredAlerts = _allAlerts.where((alert) {
        final matchesQuery = alert.location.toLowerCase().contains(query) || alert.title.toLowerCase().contains(query);
        final matchesTab = alert.isActive == showActive;
        return matchesQuery && matchesTab;
      }).toList();
    });
  }

  // --- NEW FUNCTION to show the details dialog ---
  void _showDetailsDialog(AlertInfo alert) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: alert.color,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Icon(alert.icon, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${alert.title} - ${alert.riskLevel}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                Text(alert.location, style: const TextStyle(color: Colors.grey, fontSize: 14, fontStyle: FontStyle.italic)),
                const Divider(height: 24),
                Text(alert.description, style: TextStyle(color: Colors.grey[800], height: 1.4, fontSize: 16)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(fontSize: 16)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }


  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildTabs(),
          Expanded(child: _buildAlertsList()),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF0A4E6C),
      title: const Text('All Alerts', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      actions: const [Padding(padding: EdgeInsets.only(right: 16.0), child: CircleAvatar(child: Icon(Icons.person)))],
      elevation: 0,
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF0A4E6C),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(hintText: 'Search alerts by location or type...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none)),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFF0A4E6C),
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF0A4E6C),
        tabs: const [Tab(text: 'Active Alerts'), Tab(text: 'Past Alerts')],
      ),
    );
  }

  Widget _buildAlertsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _filteredAlerts.length,
      itemBuilder: (context, index) => _buildAlertCard(_filteredAlerts[index]),
    );
  }

  Widget _buildAlertCard(AlertInfo alert) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: alert.color, width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: alert.color.withOpacity(0.1), child: Icon(alert.icon, color: alert.color)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${alert.title} - ${alert.riskLevel}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Row(children: [const Icon(Icons.location_on, size: 14, color: Colors.grey), const SizedBox(width: 4), Expanded(child: Text(alert.location, style: const TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis))]),
                    ],
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: Text(alert.description)),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(alert.timeAgo, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // --- THIS BUTTON IS NOW FUNCTIONAL ---
                onPressed: () => _showDetailsDialog(alert),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A4E6C), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12)),
                child: const Text('View Details', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
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
      currentIndex: 4,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.popUntil(context, (route) => route.isFirst);
            break;
          case 1:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MapScreen()));
            break;
          case 2:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
            break;
          case 3:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SocialScreen()));
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}*/
// lib/alerts.dart
import 'package:flutter/material.dart';
import 'map.dart';
import 'report.dart';
import 'social.dart';
import 'profile.dart';

class AlertInfo {
  final String title;
  final String riskLevel;
  final String location;
  final String description;
  final String timeAgo;
  final IconData icon;
  final Color color;
  final bool isActive;

  AlertInfo({required this.title, required this.riskLevel, required this.location, required this.description, required this.timeAgo, required this.icon, required this.color, this.isActive = true});
}

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List<AlertInfo> _filteredAlerts = [];

  final List<AlertInfo> _allAlerts = [
    AlertInfo(title: 'High Wave Alert', riskLevel: 'Tsunami Risk', location: 'Chennai, Marina Beach & Surrounding Areas', description: 'Abnormally high waves detected. Immediate evacuation recommended for coastal areas within 2km of shoreline.', timeAgo: '15 minutes ago', icon: Icons.tsunami_outlined, color: Colors.red),
    AlertInfo(title: 'Cyclone Warning', riskLevel: 'Moderate Risk', location: 'Kochi, Kerala Coast', description: 'Cyclonic storm approaching. Wind speeds up to 85 km/h expected. Secure loose objects and avoid coastal areas.', timeAgo: '2 hours ago', icon: Icons.cyclone_outlined, color: Colors.orange),
    AlertInfo(title: 'High Tide Advisory', riskLevel: 'Minor Risk', location: 'Mumbai, Maharashtra Coast', description: 'Higher than normal tides expected. Fishing activities should be avoided. Low-lying areas may experience minor flooding.', timeAgo: '4 hours ago', icon: Icons.warning_amber_outlined, color: Colors.amber),
    AlertInfo(title: 'Past: Low Pressure System', riskLevel: 'Ended', location: 'Goa Coast', description: 'The low-pressure system has dissipated. Conditions are now safe.', timeAgo: '1 day ago', icon: Icons.cloud_done_outlined, color: Colors.grey, isActive: false),
    AlertInfo(title: 'Past: Small Craft Advisory', riskLevel: 'Ended', location: 'Puducherry Coast', description: 'The advisory for small craft has been lifted.', timeAgo: '3 days ago', icon: Icons.directions_boat_outlined, color: Colors.grey, isActive: false),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filterAlerts();
    _searchController.addListener(_filterAlerts);
    _tabController.addListener(_filterAlerts);
  }

  void _filterAlerts() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      final bool showActive = _tabController.index == 0;
      _filteredAlerts = _allAlerts.where((alert) {
        final matchesQuery = alert.location.toLowerCase().contains(query) || alert.title.toLowerCase().contains(query);
        final matchesTab = alert.isActive == showActive;
        return matchesQuery && matchesTab;
      }).toList();
    });
  }

  void _showDetailsDialog(AlertInfo alert) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: alert.color,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Icon(alert.icon, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('${alert.title} - ${alert.riskLevel}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                Text(alert.location, style: const TextStyle(color: Colors.grey, fontSize: 14, fontStyle: FontStyle.italic)),
                const Divider(height: 24),
                Text(alert.description, style: TextStyle(color: Colors.grey[800], height: 1.4, fontSize: 16)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(fontSize: 16)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildTabs(),
          Expanded(child: _buildAlertsList()),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF0A4E6C),
      title: const Text('All Alerts', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
            },
            child: const CircleAvatar(child: Icon(Icons.person)),
          ),
        ),
      ],
      elevation: 0,
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF0A4E6C),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(hintText: 'Search alerts by location or type...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none)),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFF0A4E6C),
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF0A4E6C),
        tabs: const [Tab(text: 'Active Alerts'), Tab(text: 'Past Alerts')],
      ),
    );
  }

  Widget _buildAlertsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _filteredAlerts.length,
      itemBuilder: (context, index) => _buildAlertCard(_filteredAlerts[index]),
    );
  }

  Widget _buildAlertCard(AlertInfo alert) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: alert.color, width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: alert.color.withOpacity(0.1), child: Icon(alert.icon, color: alert.color)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${alert.title} - ${alert.riskLevel}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Row(children: [const Icon(Icons.location_on, size: 14, color: Colors.grey), const SizedBox(width: 4), Expanded(child: Text(alert.location, style: const TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis))]),
                    ],
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: Text(alert.description)),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(alert.timeAgo, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showDetailsDialog(alert),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A4E6C), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12)),
                child: const Text('View Details', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
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
      currentIndex: 4,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.popUntil(context, (route) => route.isFirst);
            break;
          case 1:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MapScreen()));
            break;
          case 2:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
            break;
          case 3:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SocialScreen()));
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}
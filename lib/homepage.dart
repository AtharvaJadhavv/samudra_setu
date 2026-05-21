/*
import 'package:flutter/material.dart';
import 'map.dart'; // Import the map screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // This function handles navigation from the bottom bar
  void _onItemTapped(int index) {
    if (index == 1) { // Index 1 is the 'MAP' tab
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MapScreen()),
      );
    } else {
      // For other tabs, we just update the state
      setState(() {
        _selectedIndex = index;
        print('Tapped on tab index: $index');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A4E6C),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.houseboat_outlined, color: Color(0xFF0A4E6C), size: 24),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SamudraSetu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                Text('Stay Safe, Stay Informed', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.green[400],
              child: const Icon(Icons.person_outline, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            _buildSectionHeader('Current Alerts', onViewAll: () {
              print('View All Alerts tapped');
            }),
            _buildAlertsList(),
            _buildSectionHeader('Quick Actions'),
            _buildQuickActionsGrid(), // The context is implicitly available here
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
          BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'SOCIAL'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF0A4E6C),
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('3', 'ACTIVE ALERTS'),
          _buildSummaryItem('12', 'REPORTS TODAY'),
          _buildSummaryItem('Warning', 'CURRENT STATUS', isWarning: true),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label, {bool isWarning = false}) {
    return Column(
      children: [
        Row(
          children: [
            if (isWarning) const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 22),
            if (isWarning) const SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isWarning ? Colors.red : Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onViewAll}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          if (onViewAll != null)
            TextButton(
              onPressed: onViewAll,
              child: const Text('View All', style: TextStyle(color: Color(0xFF007BFF))),
            ),
        ],
      ),
    );
  }

  Widget _buildAlertsList() {
    return Column(
      children: [
        _buildAlertCard(
          icon: Icons.tsunami_outlined,
          iconColor: Colors.blue.shade800,
          title: 'Tsunami Warning - Level 3',
          location: 'TAMIL NADU COAST',
          description: 'High-risk tsunami conditions detected. Immediate evacuation recommended for coastal areas within 2km.',
          time: '2 hours ago',
        ),
        _buildAlertCard(
          icon: Icons.cyclone_outlined,
          iconColor: Colors.orange.shade800,
          title: 'Storm Surge Alert',
          location: 'KERALA BACKWATERS',
          description: 'Severe storm surge expected with winds up to 85 km/h. Fishing activities suspended until further notice.',
          time: '45 minutes ago',
        ),
      ],
    );
  }

  Widget _buildAlertCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String location,
    required String description,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: iconColor, width: 5)),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(description, style: TextStyle(color: Colors.grey[700], height: 1.4)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ElevatedButton(
                onPressed: () {
                  print('$title Details button tapped');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // This is the updated method with the navigation logic
  Widget _buildQuickActionsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildQuickActionButton(icon: Icons.location_on_outlined, label: 'Report Hazard', onTap: () { print('Report Hazard tapped'); }),
        _buildQuickActionButton(
          icon: Icons.map_outlined,
          label: 'View Map',
          onTap: () {
            // Navigation logic for the 'View Map' button
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapScreen()),
            );
          },
        ),
        _buildQuickActionButton(icon: Icons.chat_bubble_outline, label: 'Social Feed', onTap: () { print('Social Feed tapped'); }),
        _buildQuickActionButton(icon: Icons.call_outlined, label: 'Emergency', onTap: () { print('Emergency tapped'); }),
      ],
    );
  }

  Widget _buildQuickActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: const Color(0xFF0A4E6C)),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.grey[800])),
          ],
        ),
      ),
    );
  }
}*//*
*/
/*
*//*

*/
/*

// lib/homepage.dart
*//*
*/
/*

*//*

*/
/*
import 'package:flutter/material.dart';
import 'map.dart'; // Import the map screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) { // Index 1 is the 'MAP' tab
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MapScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // --- NEW FUNCTION TO SHOW DETAILS DIALOG ---
  void _showAlertDetailsDialog({
    required BuildContext context,
    required String title,
    required String location,
    required String description,
    required IconData icon,
    required Color iconColor,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(location, style: const TextStyle(color: Colors.grey, fontSize: 14, fontStyle: FontStyle.italic)),
                const SizedBox(height: 16),
                Text(description, style: TextStyle(color: Colors.grey[700], height: 1.4, fontSize: 16)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(color: Color(0xFF007BFF))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A4E6C),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.houseboat_outlined, color: Color(0xFF0A4E6C), size: 24),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.green[400],
              child: const Icon(Icons.person_outline, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            _buildSectionHeader('Current Alerts', onViewAll: () {}),
            _buildAlertsList(),
            _buildSectionHeader('Quick Actions'),
            _buildQuickActionsGrid(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
          BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'SOCIAL'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF0A4E6C),
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('3', 'ACTIVE ALERTS'),
          _buildSummaryItem('12', 'REPORTS TODAY'),
          _buildSummaryItem('Warning', 'CURRENT STATUS', isWarning: true),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label, {bool isWarning = false}) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isWarning) const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 22),
            if (isWarning) const SizedBox(width: 4),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isWarning ? Colors.red : Colors.black87)),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onViewAll}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          if (onViewAll != null)
            TextButton(
              onPressed: onViewAll,
              child: const Text('View All', style: TextStyle(color: Color(0xFF007BFF))),
            ),
        ],
      ),
    );
  }

  Widget _buildAlertsList() {
    return Column(
      children: [
        _buildAlertCard(
          icon: Icons.tsunami_outlined,
          iconColor: Colors.blue.shade800,
          title: 'Tsunami Warning - Level 3',
          location: 'TAMIL NADU COAST',
          description: 'High-risk tsunami conditions detected. Immediate evacuation recommended for coastal areas within 2km.',
          time: '2 hours ago',
        ),
        _buildAlertCard(
          icon: Icons.cyclone_outlined,
          iconColor: Colors.orange.shade800,
          title: 'Storm Surge Alert',
          location: 'KERALA BACKWATERS',
          description: 'Severe storm surge expected with winds up to 85 km/h. Fishing activities suspended until further notice.',
          time: '45 minutes ago',
        ),
      ],
    );
  }

  // --- UPDATED ALERT CARD WIDGET ---
  Widget _buildAlertCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String location,
    required String description,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: iconColor, width: 5)),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(description, style: TextStyle(color: Colors.grey[700], height: 1.4)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ElevatedButton(
                onPressed: () {
                  // This now calls the dialog function
                  _showAlertDetailsDialog(
                    context: context,
                    title: title,
                    location: location,
                    description: description,
                    icon: icon,
                    iconColor: iconColor,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildQuickActionButton(icon: Icons.location_on_outlined, label: 'Report Hazard', onTap: () {}),
        _buildQuickActionButton(
          icon: Icons.map_outlined,
          label: 'View Map',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen()));
          },
        ),
        _buildQuickActionButton(icon: Icons.chat_bubble_outline, label: 'Social Feed', onTap: () {}),
        _buildQuickActionButton(icon: Icons.call_outlined, label: 'Emergency', onTap: () {}),
      ],
    );
  }

  Widget _buildQuickActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: const Color(0xFF0A4E6C)),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.grey[800])),
          ],
        ),
      ),
    );
  }
}*//*
*/
/*
*//*

*/
/*

// lib/homepage.dart
import 'package:flutter/material.dart';
import 'map.dart';
import 'report.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showAlertDetailsDialog({
    required BuildContext context,
    required String title,
    required String location,
    required String description,
    required IconData icon,
    required Color iconColor,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(location, style: const TextStyle(color: Colors.grey, fontSize: 14, fontStyle: FontStyle.italic)),
                const SizedBox(height: 16),
                Text(description, style: TextStyle(color: Colors.grey[700], height: 1.4, fontSize: 16)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(color: Color(0xFF007BFF))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A4E6C),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.houseboat_outlined, color: Color(0xFF0A4E6C), size: 24),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.green[400],
              child: const Icon(Icons.person_outline, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            _buildSectionHeader('Current Alerts', onViewAll: () {}),
            _buildAlertsList(),
            _buildSectionHeader('Quick Actions'),
            _buildQuickActionsGrid(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
          BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'SOCIAL'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF0A4E6C),
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('3', 'ACTIVE ALERTS'),
          _buildSummaryItem('12', 'REPORTS TODAY'),
          _buildSummaryItem('Warning', 'CURRENT STATUS', isWarning: true),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label, {bool isWarning = false}) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isWarning) const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 22),
            if (isWarning) const SizedBox(width: 4),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isWarning ? Colors.red : Colors.black87)),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onViewAll}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          if (onViewAll != null)
            TextButton(
              onPressed: onViewAll,
              child: const Text('View All', style: TextStyle(color: Color(0xFF007BFF))),
            ),
        ],
      ),
    );
  }

  Widget _buildAlertsList() {
    return Column(
      children: [
        _buildAlertCard(
          icon: Icons.tsunami_outlined,
          iconColor: Colors.blue.shade800,
          title: 'Tsunami Warning - Level 3',
          location: 'TAMIL NADU COAST',
          description: 'High-risk tsunami conditions detected. Immediate evacuation recommended for coastal areas within 2km.',
          time: '2 hours ago',
        ),
        _buildAlertCard(
          icon: Icons.cyclone_outlined,
          iconColor: Colors.orange.shade800,
          title: 'Storm Surge Alert',
          location: 'KERALA BACKWATERS',
          description: 'Severe storm surge expected with winds up to 85 km/h. Fishing activities suspended until further notice.',
          time: '45 minutes ago',
        ),
      ],
    );
  }

  Widget _buildAlertCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String location,
    required String description,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: iconColor, width: 5)),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(description, style: TextStyle(color: Colors.grey[700], height: 1.4)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ElevatedButton(
                onPressed: () {
                  _showAlertDetailsDialog(
                    context: context,
                    title: title,
                    location: location,
                    description: description,
                    icon: icon,
                    iconColor: iconColor,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildQuickActionButton(
            icon: Icons.location_on_outlined,
            label: 'Report Hazard',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
            }),
        _buildQuickActionButton(
          icon: Icons.map_outlined,
          label: 'View Map',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen()));
          },
        ),
        _buildQuickActionButton(icon: Icons.chat_bubble_outline, label: 'Social Feed', onTap: () {}),
        _buildQuickActionButton(icon: Icons.call_outlined, label: 'Emergency', onTap: () {}),
      ],
    );
  }

  Widget _buildQuickActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: const Color(0xFF0A4E6C)),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.grey[800])),
          ],
        ),
      ),
    );
  }
}*//*
*/
/*

// lib/homepage.dart
import 'package:flutter/material.dart';
import 'map.dart';
import 'report.dart';
import 'social.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    switch (index) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SocialScreen()));
        break;
      default:
        setState(() {
          _selectedIndex = index;
        });
    }
  }

  void _showAlertDetailsDialog({
    required BuildContext context,
    required String title,
    required String location,
    required String description,
    required IconData icon,
    required Color iconColor,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(location, style: const TextStyle(color: Colors.grey, fontSize: 14, fontStyle: FontStyle.italic)),
                const SizedBox(height: 16),
                Text(description, style: TextStyle(color: Colors.grey[700], height: 1.4, fontSize: 16)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(color: Color(0xFF007BFF))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A4E6C),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.houseboat_outlined, color: Color(0xFF0A4E6C), size: 24),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.green[400],
              child: const Icon(Icons.person_outline, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            _buildSectionHeader('Current Alerts', onViewAll: () {}),
            _buildAlertsList(),
            _buildSectionHeader('Quick Actions'),
            _buildQuickActionsGrid(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
          BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
          BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'SOCIAL'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF0A4E6C),
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('3', 'ACTIVE ALERTS'),
          _buildSummaryItem('12', 'REPORTS TODAY'),
          _buildSummaryItem('Warning', 'CURRENT STATUS', isWarning: true),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label, {bool isWarning = false}) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isWarning) const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 22),
            if (isWarning) const SizedBox(width: 4),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isWarning ? Colors.red : Colors.black87)),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onViewAll}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          if (onViewAll != null)
            TextButton(
              onPressed: onViewAll,
              child: const Text('View All', style: TextStyle(color: Color(0xFF007BFF))),
            ),
        ],
      ),
    );
  }

  Widget _buildAlertsList() {
    return Column(
      children: [
        _buildAlertCard(
          icon: Icons.tsunami_outlined,
          iconColor: Colors.blue.shade800,
          title: 'Tsunami Warning - Level 3',
          location: 'TAMIL NADU COAST',
          description: 'High-risk tsunami conditions detected. Immediate evacuation recommended for coastal areas within 2km.',
          time: '2 hours ago',
        ),
        _buildAlertCard(
          icon: Icons.cyclone_outlined,
          iconColor: Colors.orange.shade800,
          title: 'Storm Surge Alert',
          location: 'KERALA BACKWATERS',
          description: 'Severe storm surge expected with winds up to 85 km/h. Fishing activities suspended until further notice.',
          time: '45 minutes ago',
        ),
      ],
    );
  }

  Widget _buildAlertCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String location,
    required String description,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: iconColor, width: 5)),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(description, style: TextStyle(color: Colors.grey[700], height: 1.4)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ElevatedButton(
                onPressed: () {
                  _showAlertDetailsDialog(
                    context: context,
                    title: title,
                    location: location,
                    description: description,
                    icon: icon,
                    iconColor: iconColor,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildQuickActionButton(
            icon: Icons.location_on_outlined,
            label: 'Report Hazard',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()))),
        _buildQuickActionButton(
          icon: Icons.map_outlined,
          label: 'View Map',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen())),
        ),
        _buildQuickActionButton(
            icon: Icons.chat_bubble_outline,
            label: 'Social Feed',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SocialScreen()))),
        _buildQuickActionButton(icon: Icons.call_outlined, label: 'Emergency', onTap: () {}),
      ],
    );
  }

  Widget _buildQuickActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: const Color(0xFF0A4E6C)),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.grey[800])),
          ],
        ),
      ),
    );
  }
}*//*

// lib/homepage.dart
import 'package:flutter/material.dart';
import 'map.dart';
import 'report.dart';
import 'social.dart';
import 'alert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    switch (index) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen()));
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
      default:
        setState(() => _selectedIndex = index);
    }
  }

  void _showAlertDetailsDialog({
    required BuildContext context,
    required String title,
    required String location,
    required String description,
    required IconData icon,
    required Color iconColor,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(location, style: const TextStyle(color: Colors.grey, fontSize: 14, fontStyle: FontStyle.italic)),
                const SizedBox(height: 16),
                Text(description, style: TextStyle(color: Colors.grey[700], height: 1.4, fontSize: 16)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(color: Color(0xFF007BFF))),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A4E6C),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.houseboat_outlined, color: Color(0xFF0A4E6C), size: 24),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(backgroundColor: Colors.green[400], child: const Icon(Icons.person_outline, color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            _buildSectionHeader('Current Alerts', onViewAll: () => _onItemTapped(4)),
            _buildAlertsList(),
            _buildSectionHeader('Quick Actions'),
            _buildQuickActionsGrid(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
          BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
          BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'SOCIAL'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF0A4E6C),
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('3', 'ACTIVE ALERTS'),
          _buildSummaryItem('12', 'REPORTS TODAY'),
          _buildSummaryItem('Warning', 'CURRENT STATUS', isWarning: true),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label, {bool isWarning = false}) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isWarning) const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 22),
            if (isWarning) const SizedBox(width: 4),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isWarning ? Colors.red : Colors.black87)),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onViewAll}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          if (onViewAll != null)
            TextButton(onPressed: onViewAll, child: const Text('View All', style: TextStyle(color: Color(0xFF007BFF)))),
        ],
      ),
    );
  }

  Widget _buildAlertsList() {
    return Column(
      children: [
        _buildAlertCard(icon: Icons.tsunami_outlined, iconColor: Colors.blue.shade800, title: 'Tsunami Warning - Level 3', location: 'TAMIL NADU COAST', description: 'High-risk tsunami conditions detected. Immediate evacuation recommended for coastal areas within 2km.', time: '2 hours ago'),
        _buildAlertCard(icon: Icons.cyclone_outlined, iconColor: Colors.orange.shade800, title: 'Storm Surge Alert', location: 'KERALA BACKWATERS', description: 'Severe storm surge expected with winds up to 85 km/h. Fishing activities suspended until further notice.', time: '45 minutes ago'),
      ],
    );
  }

  Widget _buildAlertCard({required IconData icon, required Color iconColor, required String title, required String location, required String description, required String time}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border(left: BorderSide(color: iconColor, width: 5)), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(description, style: TextStyle(color: Colors.grey[700], height: 1.4)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ElevatedButton(
                onPressed: () => _showAlertDetailsDialog(context: context, title: title, location: location, description: description, icon: icon, iconColor: iconColor),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007BFF), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: const Text('Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildQuickActionButton(icon: Icons.location_on_outlined, label: 'Report Hazard', onTap: () => _onItemTapped(2)),
        _buildQuickActionButton(icon: Icons.map_outlined, label: 'View Map', onTap: () => _onItemTapped(1)),
        _buildQuickActionButton(icon: Icons.chat_bubble_outline, label: 'Social Feed', onTap: () => _onItemTapped(3)),
        _buildQuickActionButton(icon: Icons.call_outlined, label: 'Emergency', onTap: () {}),
      ],
    );
  }

  Widget _buildQuickActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: const Color(0xFF0A4E6C)),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.grey[800])),
          ],
        ),
      ),
    );
  }
}*/
// lib/homepage.dart
import 'package:flutter/material.dart';
import 'map.dart';
import 'report.dart';
import 'social.dart';
import 'alert.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    switch (index) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen()));
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
      default:
        setState(() => _selectedIndex = index);
    }
  }

  void _showAlertDetailsDialog({
    required BuildContext context,
    required String title,
    required String location,
    required String description,
    required IconData icon,
    required Color iconColor,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(location, style: const TextStyle(color: Colors.grey, fontSize: 14, fontStyle: FontStyle.italic)),
                const SizedBox(height: 16),
                Text(description, style: TextStyle(color: Colors.grey[700], height: 1.4, fontSize: 16)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(color: Color(0xFF007BFF))),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A4E6C),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.houseboat_outlined, color: Color(0xFF0A4E6C), size: 24),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
              },
              child: CircleAvatar(backgroundColor: Colors.green[400], child: const Icon(Icons.person_outline, color: Colors.white)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            _buildSectionHeader('Current Alerts', onViewAll: () => _onItemTapped(4)),
            _buildAlertsList(),
            _buildSectionHeader('Quick Actions'),
            _buildQuickActionsGrid(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
          BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
          BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'SOCIAL'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF0A4E6C),
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('3', 'ACTIVE ALERTS'),
          _buildSummaryItem('12', 'REPORTS TODAY'),
          _buildSummaryItem('Warning', 'CURRENT STATUS', isWarning: true),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label, {bool isWarning = false}) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isWarning) const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 22),
            if (isWarning) const SizedBox(width: 4),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isWarning ? Colors.red : Colors.black87)),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onViewAll}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          if (onViewAll != null)
            TextButton(onPressed: onViewAll, child: const Text('View All', style: TextStyle(color: Color(0xFF007BFF)))),
        ],
      ),
    );
  }

  Widget _buildAlertsList() {
    return Column(
      children: [
        _buildAlertCard(icon: Icons.tsunami_outlined, iconColor: Colors.blue.shade800, title: 'Tsunami Warning - Level 3', location: 'TAMIL NADU COAST', description: 'High-risk tsunami conditions detected. Immediate evacuation recommended for coastal areas within 2km.', time: '2 hours ago'),
        _buildAlertCard(icon: Icons.cyclone_outlined, iconColor: Colors.orange.shade800, title: 'Storm Surge Alert', location: 'KERALA BACKWATERS', description: 'Severe storm surge expected with winds up to 85 km/h. Fishing activities suspended until further notice.', time: '45 minutes ago'),
      ],
    );
  }

  Widget _buildAlertCard({required IconData icon, required Color iconColor, required String title, required String location, required String description, required String time}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border(left: BorderSide(color: iconColor, width: 5)), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(description, style: TextStyle(color: Colors.grey[700], height: 1.4)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ElevatedButton(
                onPressed: () => _showAlertDetailsDialog(context: context, title: title, location: location, description: description, icon: icon, iconColor: iconColor),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007BFF), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: const Text('Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildQuickActionButton(icon: Icons.location_on_outlined, label: 'Report Hazard', onTap: () => _onItemTapped(2)),
        _buildQuickActionButton(icon: Icons.map_outlined, label: 'View Map', onTap: () => _onItemTapped(1)),
        _buildQuickActionButton(icon: Icons.chat_bubble_outline, label: 'Social Feed', onTap: () => _onItemTapped(3)),
        _buildQuickActionButton(icon: Icons.call_outlined, label: 'Emergency', onTap: () {}),
      ],
    );
  }

  Widget _buildQuickActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10)]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: const Color(0xFF0A4E6C)),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.grey[800])),
          ],
        ),
      ),
    );
  }
}
/*
// lib/profile.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = "Rajesh Kumar"; // Initial username

  // --- Function to show the edit name dialog ---
  Future<void> _editUsername() async {
    final TextEditingController nameController = TextEditingController(text: _userName);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Username'),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter your name'),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () => Navigator.pop(context, nameController.text),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty) {
      setState(() {
        _userName = newName;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // We don't use a standard AppBar to get the curved background effect
      body: Stack(
        children: [
          // The curved blue background
          _buildHeader(),
          // The main content scrolling on top
          ListView(
            children: [
              const SizedBox(height: 60), // Space for the header
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildSettingsList(),
            ],
          ),
          // Custom back button
          Positioned(
            top: 40,
            left: 10,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.3),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- UI Widget Builders ---

  Widget _buildHeader() {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A4E6C), Color(0xFF1B80AC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top:01),
          child: Center(
            child: Text(
              'Profile & Settings',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 46,
            backgroundColor: Color(0xFF1B80AC),
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _userName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey, size: 20),
              onPressed: _editUsername,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSettingsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildSettingsTile(
            icon: Icons.person_outline,
            title: 'Username',
            subtitle: 'Edit your display name',
            onTap: _editUsername,
          ),
          _buildSettingsTile(
            icon: Icons.lock_outline,
            title: 'Password Change',
            subtitle: 'Update your account password',
            onTap: () {}, // Placeholder
          ),
          _buildSettingsTile(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: 'English',
            onTap: () {}, // Placeholder
          ),
          const SizedBox(height: 10),
          _buildSettingsTile(
            icon: Icons.sos_outlined,
            title: 'Emergency SOS',
            subtitle: 'Immediate emergency assistance',
            onTap: () {}, // Placeholder
            isHighlighted: true,
          ),
          _buildSettingsTile(
            icon: Icons.phone_in_talk_outlined,
            title: 'Customer Helpline',
            subtitle: '1800-123-4567 (24/7 Support)',
            onTap: () {}, // Placeholder
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isHighlighted = false,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isHighlighted ? Colors.red.shade400 : Colors.white,
      child: ListTile(
        leading: Icon(icon, color: isHighlighted ? Colors.white : Colors.grey.shade700),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isHighlighted ? Colors.white : Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: isHighlighted ? Colors.white70 : Colors.grey),
        ),
        onTap: onTap,
      ),
    );
  }
}

// Custom Clipper for the wave effect in the header
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}*//*
*/
/*
*//*

*/
/*

// lib/profile.dart
*//*
*/
/*

*//*

*/

/*import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = "Rajesh Kumar";
  String _selectedLanguage = "English";

  // --- Edit Username Dialog ---
  Future<void> _editUsername() async {
    final TextEditingController nameController = TextEditingController(text: _userName);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Username'),
        content: TextField(controller: nameController, autofocus: true, decoration: const InputDecoration(hintText: 'Enter your name')),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(child: const Text('Save'), onPressed: () => Navigator.pop(context, nameController.text)),
        ],
      ),
    );
    if (newName != null && newName.isNotEmpty) {
      setState(() => _userName = newName);
    }
  }

  // --- Password Change Bottom Sheet ---
  void _showPasswordChangeSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Current Password'), obscureText: true),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'New Password'), obscureText: true),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Update Password')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Language Selection Bottom Sheet ---
  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: const Text('English'), onTap: () => setState(() { _selectedLanguage = 'English'; Navigator.pop(context); })),
          ListTile(title: const Text('हिन्दी'), onTap: () => setState(() { _selectedLanguage = 'हिन्दी'; Navigator.pop(context); })),
          ListTile(title: const Text('Español'), onTap: () => setState(() { _selectedLanguage = 'Español'; Navigator.pop(context); })),
        ],
      ),
    );
  }

  // --- Emergency SOS Dialog ---
  void _showSosDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emergency SOS'),
        content: const Text('This will send an emergency alert with your location to your saved contacts. Do you want to proceed?'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('ACTIVATE', style: TextStyle(color: Colors.red)),
            onPressed: () {
              // Placeholder for actual SOS logic
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('SOS Activated!'), backgroundColor: Colors.red));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // --- Helpline Dialog with Calling Function ---
  void _showHelplineDialog() {
    const String helplineNumber = '18001234567';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Customer Helpline'),
        content: const Text('Connect with our 24/7 support team for assistance.'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('Call Now'),
            onPressed: () async {
              final Uri launchUri = Uri(scheme: 'tel', path: helplineNumber);
              if (await canLaunchUrl(launchUri)) {
                await launchUrl(launchUri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not launch dialer.'), backgroundColor: Colors.red));
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          _buildHeader(),
          ListView(
            padding: EdgeInsets.zero, // Remove default padding
            children: [
              // --- UI FIX: Increased space to push profile avatar down ---
              SizedBox(height: MediaQuery.of(context).padding.top + 100),
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildSettingsList(),
            ],
          ),
          _buildCustomBackButton(),
        ],
      ),
    );
  }

  Widget _buildCustomBackButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 5,
      left: 10,
      child: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.3),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: 220, // Increased height slightly
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF0A4E6C), Color(0xFF1B80AC)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: const Align(
          alignment: Alignment(0, -0.6),
          child: Text('Profile & Settings', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 46,
            backgroundColor: Color(0xFF1B80AC),
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            IconButton(icon: const Icon(Icons.edit, color: Colors.grey, size: 20), onPressed: _editUsername),
          ],
        )
      ],
    );
  }

  Widget _buildSettingsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildSettingsTile(icon: Icons.person_outline, title: 'Username', subtitle: 'Edit your display name', onTap: _editUsername),
          _buildSettingsTile(icon: Icons.lock_outline, title: 'Password Change', subtitle: 'Update your account password', onTap: _showPasswordChangeSheet),
          _buildSettingsTile(icon: Icons.language_outlined, title: 'Language', subtitle: _selectedLanguage, onTap: _showLanguageSheet),
          const SizedBox(height: 10),
          _buildSettingsTile(icon: Icons.sos_outlined, title: 'Emergency SOS', subtitle: 'Immediate emergency assistance', onTap: _showSosDialog, isHighlighted: true),
          _buildSettingsTile(icon: Icons.phone_in_talk_outlined, title: 'Customer Helpline', subtitle: '1800-123-4567 (24/7 Support)', onTap: _showHelplineDialog),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({required IconData icon, required String title, required String subtitle, required VoidCallback onTap, bool isHighlighted = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isHighlighted ? Colors.red.shade400 : Colors.white,
      child: ListTile(
        leading: Icon(icon, color: isHighlighted ? Colors.white : Colors.grey.shade700),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isHighlighted ? Colors.white : Colors.black87)),
        subtitle: Text(subtitle, style: TextStyle(color: isHighlighted ? Colors.white70 : Colors.grey)),
        onTap: onTap,
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.2, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint = Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}*///*

/*
*//*

*/
/*


// lib/profile.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart'; // <-- This import is required for the animation
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = "Rajesh Kumar";
  String _selectedLanguage = "English";

  Future<void> _editUsername() async {
    final TextEditingController nameController = TextEditingController(text: _userName);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Username'),
        content: TextField(controller: nameController, autofocus: true, decoration: const InputDecoration(hintText: 'Enter your name')),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(child: const Text('Save'), onPressed: () => Navigator.pop(context, nameController.text)),
        ],
      ),
    );
    if (newName != null && newName.isNotEmpty) {
      setState(() => _userName = newName);
    }
  }

  void _showPasswordChangeSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Current Password'), obscureText: true),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'New Password'), obscureText: true),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Update Password')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: const Text('English'), onTap: () => setState(() { _selectedLanguage = 'English'; Navigator.pop(context); })),
          ListTile(title: const Text('हिन्दी'), onTap: () => setState(() { _selectedLanguage = 'हिन्दी'; Navigator.pop(context); })),
          ListTile(title: const Text('Español'), onTap: () => setState(() { _selectedLanguage = 'Español'; Navigator.pop(context); })),
        ],
      ),
    );
  }

  void _showSosDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emergency SOS'),
        content: const Text('This will send an emergency alert with your location to your saved contacts. Do you want to proceed?'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('ACTIVATE', style: TextStyle(color: Colors.red)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('SOS Activated!'), backgroundColor: Colors.red));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showHelplineDialog() {
    const String helplineNumber = '18001234567';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Customer Helpline'),
        content: const Text('Connect with our 24/7 support team for assistance.'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('Call Now'),
            onPressed: () async {
              final Uri launchUri = Uri(scheme: 'tel', path: helplineNumber);
              if (await canLaunchUrl(launchUri)) {
                await launchUrl(launchUri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not launch dialer.'), backgroundColor: Colors.red));
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedWaveBackground(),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(),
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildSettingsList(),
            ],
          ),
          _buildCustomBackButton(),
        ],
      ),
    );
  }

  Widget _buildCustomBackButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 5,
      left: 10,
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.2),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Center(
        child: Text(
          'Profile & Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 5.0, color: Colors.black.withOpacity(0.3))],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 46,
            backgroundColor: Color(0xFF1B80AC),
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            IconButton(icon: const Icon(Icons.edit, color: Colors.grey, size: 20), onPressed: _editUsername),
          ],
        )
      ],
    );
  }

  Widget _buildSettingsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildSettingsTile(icon: Icons.person_outline, title: 'Username', subtitle: 'Edit your display name', onTap: _editUsername),
          _buildSettingsTile(icon: Icons.lock_outline, title: 'Password Change', subtitle: 'Update your account password', onTap: _showPasswordChangeSheet),
          _buildSettingsTile(icon: Icons.language_outlined, title: 'Language', subtitle: _selectedLanguage, onTap: _showLanguageSheet),
          const SizedBox(height: 10),
          _buildSettingsTile(icon: Icons.sos_outlined, title: 'Emergency SOS', subtitle: 'Immediate emergency assistance', onTap: _showSosDialog, isHighlighted: true),
          _buildSettingsTile(icon: Icons.phone_in_talk_outlined, title: 'Customer Helpline', subtitle: '1800-123-4567 (24/7 Support)', onTap: _showHelplineDialog),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({required IconData icon, required String title, required String subtitle, required VoidCallback onTap, bool isHighlighted = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isHighlighted ? Colors.red.shade400 : Colors.white,
      child: ListTile(
        leading: Icon(icon, color: isHighlighted ? Colors.white : Colors.grey.shade700),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isHighlighted ? Colors.white : Colors.black87)),
        subtitle: Text(subtitle, style: TextStyle(color: isHighlighted ? Colors.white70 : Colors.grey)),
        onTap: onTap,
      ),
    );
  }
}

class AnimatedWaveBackground extends StatelessWidget {
  const AnimatedWaveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return LoopAnimation<double>(
      tween: Tween(begin: 0.0, end: 2 * pi),
      duration: const Duration(seconds: 10),
      builder: (context, child, value) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0A4E6C), Color(0xFF1B80AC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              SizedBox.expand(
                child: CustomPaint(
                  painter: WavePainter(animationValue: value),
                ),
              ),
              Positioned(
                left: 50,
                top: _calculateBoatY(context, value),
                child: const Icon(Icons.houseboat_outlined, color: Colors.white, size: 30),
              )
            ],
          ),
        );
      },
    );
  }

  double _calculateBoatY(BuildContext context, double animationValue) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.65 + sin(animationValue + 50) * 5;
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  WavePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    final path1 = Path();
    path1.moveTo(0, size.height * 0.7);
    for (double i = 0; i < size.width; i++) {
      path1.lineTo(i, size.height * 0.7 + sin(animationValue + i / 80) * 15);
    }
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    final path2 = Path();
    path2.moveTo(0, size.height * 0.75);
    for (double i = 0; i < size.width; i++) {
      path2.lineTo(i, size.height * 0.75 + sin(animationValue * 1.2 + i / 60) * 20);
    }
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}*//*
*/
/*

// lib/profile.dart
import 'dart:math';
import 'package:flutter/material.dart';
//
// ❗ Updated import for simple_animations v5+ ❗
//
import 'package:simple_animations/simple_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = "Rajesh Kumar";
  String _selectedLanguage = "English";

  // --- Edit Username Dialog ---
  Future<void> _editUsername() async {
    final TextEditingController nameController = TextEditingController(text: _userName);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Username'),
        content: TextField(controller: nameController, autofocus: true, decoration: const InputDecoration(hintText: 'Enter your name')),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(child: const Text('Save'), onPressed: () => Navigator.pop(context, nameController.text)),
        ],
      ),
    );
    if (newName != null && newName.isNotEmpty) {
      setState(() => _userName = newName);
    }
  }

  // --- Password Change Bottom Sheet ---
  void _showPasswordChangeSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Current Password'), obscureText: true),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'New Password'), obscureText: true),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Update Password')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Language Selection Bottom Sheet ---
  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: const Text('English'), onTap: () => setState(() { _selectedLanguage = 'English'; Navigator.pop(context); })),
          ListTile(title: const Text('हिन्दी'), onTap: () => setState(() { _selectedLanguage = 'हिन्दी'; Navigator.pop(context); })),
          ListTile(title: const Text('Español'), onTap: () => setState(() { _selectedLanguage = 'Español'; Navigator.pop(context); })),
        ],
      ),
    );
  }

  // --- Emergency SOS Dialog ---
  void _showSosDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emergency SOS'),
        content: const Text('This will send an emergency alert with your location to your saved contacts. Do you want to proceed?'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('ACTIVATE', style: TextStyle(color: Colors.red)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('SOS Activated!'), backgroundColor: Colors.red));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // --- Helpline Dialog with Calling Function ---
  void _showHelplineDialog() {
    const String helplineNumber = '18001234567';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Customer Helpline'),
        content: const Text('Connect with our 24/7 support team for assistance.'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('Call Now'),
            onPressed: () async {
              final Uri launchUri = Uri(scheme: 'tel', path: helplineNumber);
              if (await canLaunchUrl(launchUri)) {
                await launchUrl(launchUri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not launch dialer.'), backgroundColor: Colors.red));
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedWaveBackground(),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(),
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildSettingsList(),
            ],
          ),
          _buildCustomBackButton(),
        ],
      ),
    );
  }

  Widget _buildCustomBackButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 5,
      left: 10,
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.2),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Center(
        child: Text(
          'Profile & Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 5.0, color: Colors.black.withOpacity(0.3))],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 46,
            backgroundColor: Color(0xFF1B80AC),
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            IconButton(icon: const Icon(Icons.edit, color: Colors.grey, size: 20), onPressed: _editUsername),
          ],
        )
      ],
    );
  }

  Widget _buildSettingsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildSettingsTile(icon: Icons.person_outline, title: 'Username', subtitle: 'Edit your display name', onTap: _editUsername),
          _buildSettingsTile(icon: Icons.lock_outline, title: 'Password Change', subtitle: 'Update your account password', onTap: _showPasswordChangeSheet),
          _buildSettingsTile(icon: Icons.language_outlined, title: 'Language', subtitle: _selectedLanguage, onTap: _showLanguageSheet),
          const SizedBox(height: 10),
          _buildSettingsTile(icon: Icons.sos_outlined, title: 'Emergency SOS', subtitle: 'Immediate emergency assistance', onTap: _showSosDialog, isHighlighted: true),
          _buildSettingsTile(icon: Icons.phone_in_talk_outlined, title: 'Customer Helpline', subtitle: '1800-123-4567 (24/7 Support)', onTap: _showHelplineDialog),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({required IconData icon, required String title, required String subtitle, required VoidCallback onTap, bool isHighlighted = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isHighlighted ? Colors.red.shade400 : Colors.white,
      child: ListTile(
        leading: Icon(icon, color: isHighlighted ? Colors.white : Colors.grey.shade700),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isHighlighted ? Colors.white : Colors.black87)),
        subtitle: Text(subtitle, style: TextStyle(color: isHighlighted ? Colors.white70 : Colors.grey)),
        onTap: onTap,
      ),
    );
  }
}

class AnimatedWaveBackground extends StatelessWidget {
  const AnimatedWaveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    // Updated to use PlayAnimationBuilder from simple_animations v5+
    return PlayAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 2 * pi),
      duration: const Duration(seconds: 10),
      builder: (context, value, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1E3C72), // Deep blue
                Color(0xFF2A5298), // Medium blue
                Color(0xFF3B82F6), // Bright blue
                Color(0xFF60A5FA), // Light blue
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.3, 0.7, 1.0],
            ),
          ),
          child: Stack(
            children: [
              SizedBox.expand(
                child: CustomPaint(
                  painter: WavePainter(animationValue: value),
                ),
              ),
              Positioned(
                left: 50,
                top: _calculateBoatY(context, value),
                child: const Icon(Icons.directions_boat, color: Colors.white, size: 45),
              )
            ],
          ),
        );
      },
    );
  }

  double _calculateBoatY(BuildContext context, double animationValue) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.8 + sin(animationValue + 50) * 8;
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  WavePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;
    final path1 = Path();
    path1.moveTo(0, size.height * 0.75);
    for (double i = 0; i < size.width; i++) {
      path1.lineTo(i, size.height * 0.75 + sin(animationValue + i / 80) * 18);
    }
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..style = PaintingStyle.fill;
    final path2 = Path();
    path2.moveTo(0, size.height * 0.82);
    for (double i = 0; i < size.width; i++) {
      path2.lineTo(i, size.height * 0.82 + sin(animationValue * 1.2 + i / 60) * 22);
    }
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}*//*

// lib/profile.dart
import 'dart:math';
import 'package:flutter/material.dart';
//
// ❗ Updated import for simple_animations v5+ ❗
//
import 'package:simple_animations/simple_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = "Rajesh Kumar";
  String _selectedLanguage = "English";

  // --- Edit Username Dialog ---
  Future<void> _editUsername() async {
    final TextEditingController nameController = TextEditingController(text: _userName);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Username'),
        content: TextField(controller: nameController, autofocus: true, decoration: const InputDecoration(hintText: 'Enter your name')),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(child: const Text('Save'), onPressed: () => Navigator.pop(context, nameController.text)),
        ],
      ),
    );
    if (newName != null && newName.isNotEmpty) {
      setState(() => _userName = newName);
    }
  }

  // --- Password Change Bottom Sheet ---
  void _showPasswordChangeSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Current Password'), obscureText: true),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'New Password'), obscureText: true),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Update Password')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Language Selection Bottom Sheet ---
  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: const Text('English'), onTap: () => setState(() { _selectedLanguage = 'English'; Navigator.pop(context); })),
          ListTile(title: const Text('हिन्दी'), onTap: () => setState(() { _selectedLanguage = 'हिन्दी'; Navigator.pop(context); })),
          ListTile(title: const Text('Español'), onTap: () => setState(() { _selectedLanguage = 'Español'; Navigator.pop(context); })),
        ],
      ),
    );
  }

  // --- Emergency SOS Dialog ---
  void _showSosDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emergency SOS'),
        content: const Text('This will send an emergency alert with your location to your saved contacts. Do you want to proceed?'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('ACTIVATE', style: TextStyle(color: Colors.red)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('SOS Activated!'), backgroundColor: Colors.red));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // --- Helpline Dialog with Calling Function ---
  void _showHelplineDialog() {
    const String helplineNumber = '18001234567';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Customer Helpline'),
        content: const Text('Connect with our 24/7 support team for assistance.'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('Call Now'),
            onPressed: () async {
              final Uri launchUri = Uri(scheme: 'tel', path: helplineNumber);
              if (await canLaunchUrl(launchUri)) {
                await launchUrl(launchUri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not launch dialer.'), backgroundColor: Colors.red));
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedWaveBackground(),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(),
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildSettingsList(),
            ],
          ),
          _buildCustomBackButton(),
        ],
      ),
    );
  }

  Widget _buildCustomBackButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 5,
      left: 10,
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.2),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Center(
        child: Text(
          'Profile & Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 5.0, color: Colors.black.withOpacity(0.3))],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 46,
            backgroundColor: Color(0xFF1B80AC),
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            IconButton(icon: const Icon(Icons.edit, color: Colors.grey, size: 20), onPressed: _editUsername),
          ],
        )
      ],
    );
  }

  Widget _buildSettingsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildSettingsTile(icon: Icons.person_outline, title: 'Username', subtitle: 'Edit your display name', onTap: _editUsername),
          _buildSettingsTile(icon: Icons.lock_outline, title: 'Password Change', subtitle: 'Update your account password', onTap: _showPasswordChangeSheet),
          _buildSettingsTile(icon: Icons.language_outlined, title: 'Language', subtitle: _selectedLanguage, onTap: _showLanguageSheet),
          const SizedBox(height: 10),
          _buildSettingsTile(icon: Icons.sos_outlined, title: 'Emergency SOS', subtitle: 'Immediate emergency assistance', onTap: _showSosDialog, isHighlighted: true),
          _buildSettingsTile(icon: Icons.phone_in_talk_outlined, title: 'Customer Helpline', subtitle: '1800-123-4567 (24/7 Support)', onTap: _showHelplineDialog),
          // Extra space for boats at bottom
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({required IconData icon, required String title, required String subtitle, required VoidCallback onTap, bool isHighlighted = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isHighlighted ? Colors.red.shade400 : Colors.white,
      child: ListTile(
        leading: Icon(icon, color: isHighlighted ? Colors.white : Colors.grey.shade700),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isHighlighted ? Colors.white : Colors.black87)),
        subtitle: Text(subtitle, style: TextStyle(color: isHighlighted ? Colors.white70 : Colors.grey)),
        onTap: onTap,
      ),
    );
  }
}

class AnimatedWaveBackground extends StatelessWidget {
  const AnimatedWaveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    // Updated to use PlayAnimationBuilder from simple_animations v5+
    return PlayAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 2 * pi),
      duration: const Duration(seconds: 10),
      builder: (context, value, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1E40AF), // Deep blue
                Color(0xFF3B82F6), // Medium blue
                Color(0xFF60A5FA), // Light blue
                Color(0xFFDEF7FF), // Very light blue/white
                Colors.white,      // Pure white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.25, 0.5, 0.8, 1.0],
            ),
          ),
          child: Stack(
            children: [
              SizedBox.expand(
                child: CustomPaint(
                  painter: WavePainter(animationValue: value),
                ),
              ),
              // Multiple boats floating at the bottom
              Positioned(
                left: 30,
                bottom: 40,
                child: Transform.rotate(
                  angle: sin(value) * 0.1,
                  child: const Icon(Icons.sailing, color: Colors.white, size: 35),
                ),
              ),
              Positioned(
                right: 50,
                bottom: 60,
                child: Transform.rotate(
                  angle: sin(value + 1) * 0.08,
                  child: const Icon(Icons.directions_boat, color: Colors.white, size: 40),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.4,
                bottom: 25,
                child: Transform.rotate(
                  angle: sin(value + 2) * 0.12,
                  child: const Icon(Icons.phishing, color: Colors.white70, size: 28),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  canvas.drawPath(path3, paint3);
}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class WavePainter extends CustomPainter {
  final double animationValue;
  WavePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    final path1 = Path();
    path1.moveTo(0, size.height * 0.6);
    for (double i = 0; i < size.width; i++) {
      path1.lineTo(i, size.height * 0.6 + sin(animationValue + i / 50) * 35);
    }
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    final path2 = Path();
    path2.moveTo(0, size.height * 0.75);
    for (double i = 0; i < size.width; i++) {
      path2.lineTo(i, size.height * 0.75 + sin(animationValue * 1.3 + i / 40) * 45);
    }
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);

    canvas.drawPath(path3, paint3);

    // Third wave layer for more depth
    final paint3 = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    final path3 = Path();
    path3.moveTo(0, size.height * 0.85);
    for (double i = 0; i < size.width; i++) {
      path3.lineTo(i, size.height * 0.85 + sin(animationValue * 1.5 + i / 30) * 50);
    }
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}*/
// lib/profile.dart
/*
import 'dart:math';
import 'package:flutter/material.dart';
//
// ❗ Updated import for simple_animations v5+ ❗
//
import 'package:simple_animations/simple_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = "Rajesh Kumar";
  String _selectedLanguage = "English";

  // --- Edit Username Dialog ---
  Future<void> _editUsername() async {
    final TextEditingController nameController = TextEditingController(text: _userName);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Username'),
        content: TextField(controller: nameController, autofocus: true, decoration: const InputDecoration(hintText: 'Enter your name')),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(child: const Text('Save'), onPressed: () => Navigator.pop(context, nameController.text)),
        ],
      ),
    );
    if (newName != null && newName.isNotEmpty) {
      setState(() => _userName = newName);
    }
  }

  // --- Password Change Bottom Sheet ---
  void _showPasswordChangeSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Current Password'), obscureText: true),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'New Password'), obscureText: true),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Update Password')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Language Selection Bottom Sheet ---
  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: const Text('English'), onTap: () => setState(() { _selectedLanguage = 'English'; Navigator.pop(context); })),
          ListTile(title: const Text('हिन्दी'), onTap: () => setState(() { _selectedLanguage = 'हिन्दी'; Navigator.pop(context); })),
          ListTile(title: const Text('Español'), onTap: () => setState(() { _selectedLanguage = 'Español'; Navigator.pop(context); })),
        ],
      ),
    );
  }

  // --- Emergency SOS Dialog ---
  void _showSosDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emergency SOS'),
        content: const Text('This will send an emergency alert with your location to your saved contacts. Do you want to proceed?'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('ACTIVATE', style: TextStyle(color: Colors.red)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('SOS Activated!'), backgroundColor: Colors.red));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // --- Helpline Dialog with Calling Function ---
  void _showHelplineDialog() {
    const String helplineNumber = '18001234567';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Customer Helpline'),
        content: const Text('Connect with our 24/7 support team for assistance.'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('Call Now'),
            onPressed: () async {
              final Uri launchUri = Uri(scheme: 'tel', path: helplineNumber);
              if (await canLaunchUrl(launchUri)) {
                await launchUrl(launchUri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not launch dialer.'), backgroundColor: Colors.red));
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedWaveBackground(),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(),
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildSettingsList(),
            ],
          ),
          _buildCustomBackButton(),
        ],
      ),
    );
  }

  Widget _buildCustomBackButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 5,
      left: 10,
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.2),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Center(
        child: Text(
          'Profile & Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 5.0, color: Colors.black.withOpacity(0.3))],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 46,
            backgroundColor: Color(0xFF1B80AC),
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            IconButton(icon: const Icon(Icons.edit, color: Colors.grey, size: 20), onPressed: _editUsername),
          ],
        )
      ],
    );
  }

  Widget _buildSettingsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildSettingsTile(icon: Icons.person_outline, title: 'Username', subtitle: 'Edit your display name', onTap: _editUsername),
          _buildSettingsTile(icon: Icons.lock_outline, title: 'Password Change', subtitle: 'Update your account password', onTap: _showPasswordChangeSheet),
          _buildSettingsTile(icon: Icons.language_outlined, title: 'Language', subtitle: _selectedLanguage, onTap: _showLanguageSheet),
          const SizedBox(height: 10),
          _buildSettingsTile(icon: Icons.sos_outlined, title: 'Emergency SOS', subtitle: 'Immediate emergency assistance', onTap: _showSosDialog, isHighlighted: true),
          _buildSettingsTile(icon: Icons.phone_in_talk_outlined, title: 'Customer Helpline', subtitle: '1800-123-4567 (24/7 Support)', onTap: _showHelplineDialog),
          // Extra space for boats at bottom
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({required IconData icon, required String title, required String subtitle, required VoidCallback onTap, bool isHighlighted = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isHighlighted ? Colors.red.shade400 : Colors.white,
      child: ListTile(
        leading: Icon(icon, color: isHighlighted ? Colors.white : Colors.grey.shade700),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isHighlighted ? Colors.white : Colors.black87)),
        subtitle: Text(subtitle, style: TextStyle(color: isHighlighted ? Colors.white70 : Colors.grey)),
        onTap: onTap,
      ),
    );
  }
}

class AnimatedWaveBackground extends StatelessWidget {
  const AnimatedWaveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    // Updated to use PlayAnimationBuilder from simple_animations v5+
    return PlayAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 2 * pi),
      duration: const Duration(seconds: 10),
      builder: (context, value, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1E40AF), // Deep blue
                Color(0xFF3B82F6), // Medium blue
                Color(0xFF60A5FA), // Light blue
                Color(0xFFDEF7FF), // Very light blue/white
                Colors.white,      // Pure white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.25, 0.5, 0.8, 1.0],
            ),
          ),
          child: Stack(
            children: [
              SizedBox.expand(
                child: CustomPaint(
                  painter: WavePainter(animationValue: value),
                ),
              ),
              // Multiple boats floating at the bottom
              Positioned(
                left: 30,
                bottom: 40,
                child: Transform.rotate(
                  angle: sin(value) * 0.1,
                  child: const Icon(Icons.sailing, color: Colors.white, size: 35),
                ),
              ),
              Positioned(
                right: 50,
                bottom: 60,
                child: Transform.rotate(
                  angle: sin(value + 1) * 0.08,
                  child: const Icon(Icons.directions_boat, color: Colors.white, size: 40),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.4,
                bottom: 25,
                child: Transform.rotate(
                  angle: sin(value + 2) * 0.12,
                  child: const Icon(Icons.phishing, color: Colors.white70, size: 28),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  WavePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    // First wave layer
    final paint1 = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    final path1 = Path();
    path1.moveTo(0, size.height * 0.6);
    for (double i = 0; i < size.width; i++) {
      path1.lineTo(i, size.height * 0.6 + sin(animationValue + i / 50) * 35);
    }
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Second wave layer
    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    final path2 = Path();
    path2.moveTo(0, size.height * 0.75);
    for (double i = 0; i < size.width; i++) {
      path2.lineTo(i, size.height * 0.75 + sin(animationValue * 1.3 + i / 40) * 45);
    }
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);

    // Third wave layer
    final paint3 = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    final path3 = Path();
    path3.moveTo(0, size.height * 0.85);
    for (double i = 0; i < size.width; i++) {
      path3.lineTo(i, size.height * 0.85 + sin(animationValue * 1.5 + i / 30) * 50);
    }
    path3.lineTo(size.width, size.height);
    path3.lineTo(0, size.height);
    path3.close();
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}*/
// lib/profile.dart
/*
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'sos.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = "Rajesh Kumar";
  String _selectedLanguage = "English";

  // --- All functionality methods remain the same ---
  Future<void> _editUsername() async {
    final TextEditingController nameController = TextEditingController(text: _userName);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Username'),
        content: TextField(controller: nameController, autofocus: true, decoration: const InputDecoration(hintText: 'Enter your name')),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(child: const Text('Save'), onPressed: () => Navigator.pop(context, nameController.text)),
        ],
      ),
    );
    if (newName != null && newName.isNotEmpty) {
      setState(() => _userName = newName);
    }
  }

  void _showPasswordChangeSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Current Password'), obscureText: true),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'New Password'), obscureText: true),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Update Password')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: const Text('English'), onTap: () => setState(() { _selectedLanguage = 'English'; Navigator.pop(context); })),
          ListTile(title: const Text('हिन्दी'), onTap: () => setState(() { _selectedLanguage = 'हिन्दी'; Navigator.pop(context); })),
          ListTile(title: const Text('Español'), onTap: () => setState(() { _selectedLanguage = 'Español'; Navigator.pop(context); })),
        ],
      ),
    );
  }

  void _showHelplineDialog() {
    const String helplineNumber = '18001234567';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Customer Helpline'),
        content: const Text('Connect with our 24/7 support team for assistance.'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('Call Now'),
            onPressed: () async {
              final Uri launchUri = Uri(scheme: 'tel', path: helplineNumber);
              if (await canLaunchUrl(launchUri)) {
                await launchUrl(launchUri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not launch dialer.'), backgroundColor: Colors.red));
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // The new animated background is the first layer
          const AnimatedWaveBackground(),
          // The scrollable content sits on top
          ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(),
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildSettingsList(),
            ],
          ),
          _buildCustomBackButton(),
        ],
      ),
    );
  }

  Widget _buildCustomBackButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 5,
      left: 10,
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.2),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  // Header is now just for title and spacing
  Widget _buildHeader() {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Center(
        child: Text(
          'Profile & Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 5.0, color: Colors.black.withOpacity(0.3))],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 46,
            backgroundColor: Color(0xFF1B80AC),
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            IconButton(icon: const Icon(Icons.edit, color: Colors.grey, size: 20), onPressed: _editUsername),
          ],
        )
      ],
    );
  }

  Widget _buildSettingsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildSettingsTile(icon: Icons.person_outline, title: 'Username', subtitle: 'Edit your display name', onTap: _editUsername),
          _buildSettingsTile(icon: Icons.lock_outline, title: 'Password Change', subtitle: 'Update your account password', onTap: _showPasswordChangeSheet),
          _buildSettingsTile(icon: Icons.language_outlined, title: 'Language', subtitle: _selectedLanguage, onTap: _showLanguageSheet),
          const SizedBox(height: 10),
          _buildSettingsTile(
              icon: Icons.sos_outlined,
              title: 'Emergency SOS',
              subtitle: 'Immediate emergency assistance',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SosScreen())),
              isHighlighted: true),
          _buildSettingsTile(icon: Icons.phone_in_talk_outlined, title: 'Customer Helpline', subtitle: '1800-123-4567 (24/7 Support)', onTap: _showHelplineDialog),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({required IconData icon, required String title, required String subtitle, required VoidCallback onTap, bool isHighlighted = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isHighlighted ? Colors.red.shade400 : Colors.white,
      child: ListTile(
        leading: Icon(icon, color: isHighlighted ? Colors.white : Colors.grey.shade700),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isHighlighted ? Colors.white : Colors.black87)),
        subtitle: Text(subtitle, style: TextStyle(color: isHighlighted ? Colors.white70 : Colors.grey)),
        onTap: onTap,
      ),
    );
  }
}

// --- Animated Background Widget ---
class AnimatedWaveBackground extends StatelessWidget {
  const AnimatedWaveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return LoopAnimation<double>(
      tween: Tween(begin: 0.0, end: 2 * pi),
      duration: const Duration(seconds: 10),
      builder: (context, child, value) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0A4E6C), Color(0xFF1B80AC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              SizedBox.expand(
                child: CustomPaint(
                  painter: WavePainter(animationValue: value),
                ),
              ),
              Positioned(
                left: 50,
                top: _calculateBoatY(context, value),
                child: const Icon(Icons.houseboat_outlined, color: Colors.white, size: 30),
              )
            ],
          ),
        );
      },
    );
  }

  double _calculateBoatY(BuildContext context, double animationValue) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.65 + sin(animationValue + 50) * 5;
  }
}

// --- Custom Painter for Waves ---
class WavePainter extends CustomPainter {
  final double animationValue;
  WavePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    final path1 = Path();
    path1.moveTo(0, size.height * 0.7);
    for (double i = 0; i < size.width; i++) {
      path1.lineTo(i, size.height * 0.7 + sin(animationValue + i / 80) * 15);
    }
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    final path2 = Path();
    path2.moveTo(0, size.height * 0.75);
    for (double i = 0; i < size.width; i++) {
      path2.lineTo(i, size.height * 0.75 + sin(animationValue * 1.2 + i / 60) * 20);
    }
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}*/

// lib/profile.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'sos.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = "Rajesh Kumar";
  String _selectedLanguage = "English";

  Future<void> _editUsername() async {
    final TextEditingController nameController = TextEditingController(text: _userName);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Username'),
        content: TextField(controller: nameController, autofocus: true, decoration: const InputDecoration(hintText: 'Enter your name')),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(child: const Text('Save'), onPressed: () => Navigator.pop(context, nameController.text)),
        ],
      ),
    );
    if (newName != null && newName.isNotEmpty) {
      setState(() => _userName = newName);
    }
  }

  void _showPasswordChangeSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Current Password'), obscureText: true),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'New Password'), obscureText: true),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Update Password')),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: const Text('English'), onTap: () => setState(() { _selectedLanguage = 'English'; Navigator.pop(context); })),
          ListTile(title: const Text('हिन्दी'), onTap: () => setState(() { _selectedLanguage = 'हिन्दी'; Navigator.pop(context); })),
          ListTile(title: const Text('Español'), onTap: () => setState(() { _selectedLanguage = 'Español'; Navigator.pop(context); })),
        ],
      ),
    );
  }

  void _showHelplineDialog() {
    const String helplineNumber = '18001234567';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Customer Helpline'),
        content: const Text('Connect with our 24/7 support team for assistance.'),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('Call Now'),
            onPressed: () async {
              final Uri launchUri = Uri(scheme: 'tel', path: helplineNumber);
              if (await canLaunchUrl(launchUri)) {
                await launchUrl(launchUri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not launch dialer.'), backgroundColor: Colors.red));
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedWaveBackground(),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(),
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildSettingsList(),
            ],
          ),
          _buildCustomBackButton(),
        ],
      ),
    );
  }

  Widget _buildCustomBackButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 5,
      left: 10,
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.2),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Center(
        child: Text(
          'Profile & Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 5.0, color: Colors.black.withOpacity(0.3))],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 46,
            backgroundColor: Color(0xFF1B80AC),
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            IconButton(icon: const Icon(Icons.edit, color: Colors.grey, size: 20), onPressed: _editUsername),
          ],
        )
      ],
    );
  }

  Widget _buildSettingsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildSettingsTile(icon: Icons.person_outline, title: 'Username', subtitle: 'Edit your display name', onTap: _editUsername),
          _buildSettingsTile(icon: Icons.lock_outline, title: 'Password Change', subtitle: 'Update your account password', onTap: _showPasswordChangeSheet),
          _buildSettingsTile(icon: Icons.language_outlined, title: 'Language', subtitle: _selectedLanguage, onTap: _showLanguageSheet),
          const SizedBox(height: 10),
          _buildSettingsTile(
              icon: Icons.sos_outlined,
              title: 'Emergency SOS',
              subtitle: 'Immediate emergency assistance',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SosScreen())),
              isHighlighted: true),
          _buildSettingsTile(icon: Icons.phone_in_talk_outlined, title: 'Customer Helpline', subtitle: '1800-123-4567 (24/7 Support)', onTap: _showHelplineDialog),
          const SizedBox(height: 120), // Space for boats
        ],
      ),
    );
  }

  Widget _buildSettingsTile({required IconData icon, required String title, required String subtitle, required VoidCallback onTap, bool isHighlighted = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isHighlighted ? Colors.red.shade400 : Colors.white,
      child: ListTile(
        leading: Icon(icon, color: isHighlighted ? Colors.white : Colors.grey.shade700),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isHighlighted ? Colors.white : Colors.black87)),
        subtitle: Text(subtitle, style: TextStyle(color: isHighlighted ? Colors.white70 : Colors.grey)),
        onTap: onTap,
      ),
    );
  }
}

class AnimatedWaveBackground extends StatelessWidget {
  const AnimatedWaveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 2 * pi),
      duration: const Duration(seconds: 10),
      builder: (context, value, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1E40AF), // Deep blue
                Color(0xFF3B82F6), // Medium blue
                Color(0xFF60A5FA), // Light blue
                Color(0xFFDEF7FF), // Very light blue/white
                Colors.white,      // Pure white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.25, 0.5, 0.8, 1.0],
            ),
          ),
          child: Stack(
            children: [
              SizedBox.expand(
                child: CustomPaint(
                  painter: WavePainter(animationValue: value),
                ),
              ),
              // Multiple boats floating at the bottom
              Positioned(
                left: 30,
                bottom: 40,
                child: Transform.rotate(
                  angle: sin(value) * 0.1,
                  child: const Icon(Icons.sailing, color: Colors.white, size: 35),
                ),
              ),
              Positioned(
                right: 50,
                bottom: 60,
                child: Transform.rotate(
                  angle: sin(value + 1) * 0.08,
                  child: const Icon(Icons.directions_boat, color: Colors.white, size: 40),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.4,
                bottom: 25,
                child: Transform.rotate(
                  angle: sin(value + 2) * 0.12,
                  child: const Icon(Icons.phishing, color: Colors.white70, size: 28),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  WavePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    // First wave layer
    final paint1 = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    final path1 = Path();
    path1.moveTo(0, size.height * 0.6);
    for (double i = 0; i < size.width; i++) {
      path1.lineTo(i, size.height * 0.6 + sin(animationValue + i / 50) * 35);
    }
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Second wave layer
    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    final path2 = Path();
    path2.moveTo(0, size.height * 0.75);
    for (double i = 0; i < size.width; i++) {
      path2.lineTo(i, size.height * 0.75 + sin(animationValue * 1.3 + i / 40) * 45);
    }
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);

    // Third wave layer
    final paint3 = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    final path3 = Path();
    path3.moveTo(0, size.height * 0.85);
    for (double i = 0; i < size.width; i++) {
      path3.lineTo(i, size.height * 0.85 + sin(animationValue * 1.5 + i / 30) * 50);
    }
    path3.lineTo(size.width, size.height);
    path3.lineTo(0, size.height);
    path3.close();
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
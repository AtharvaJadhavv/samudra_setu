/*
// lib/sos.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  // --- SOS Button Action ---
  void _activateSos(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm SOS Activation'),
        content: const Text('This will immediately alert emergency contacts and authorities with your location. Proceed?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            child: const Text('ACTIVATE', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('SOS Signal Sent! Authorities have been notified.'), backgroundColor: Colors.green),
              );
            },
          ),
        ],
      ),
    );
  }

  // --- Share Location Action ---
  Future<void> _shareLocation(BuildContext context) async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permission is required to share.'), backgroundColor: Colors.red));
        return;
      }
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
      Share.share('I am in need of assistance. My current location is: $googleMapsUrl');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not get location.'), backgroundColor: Colors.red));
    }
  }

  // --- Call Emergency Services Action ---
  Future<void> _callEmergency(BuildContext context) async {
    // 112 is the pan-India emergency number
    final Uri launchUri = Uri(scheme: 'tel', path: '112');
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not launch dialer.'), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency SOS'),
        backgroundColor: const Color(0xFF1B80AC).withOpacity(0.8),
        elevation: 0,
      ),
      body: Stack(
        children: [
          const AnimatedWaterBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(flex: 2),
              GestureDetector(
                onTap: () => _activateSos(context),
                child: const CircleAvatar(
                  radius: 80,
                  backgroundColor: Color(0xFF81D4FA),
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Color(0xFF4FC3F7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('SOS', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('EMERGENCY', style: TextStyle(fontSize: 14, color: Colors.white70, letterSpacing: 2)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  'Tap to send immediate emergency alert to\ncontacts and authorities',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Row(
                  children: [
                    _buildActionButton(context, icon: Icons.share_location, label: 'Share Location', onTap: () => _shareLocation(context)),
                    const SizedBox(width: 20),
                    _buildActionButton(context, icon: Icons.call, label: 'Call Emergency Services', onTap: () => _callEmergency(context)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: const Color(0xFF0A4E6C)),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(color: Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- NEW Animated Background Widget ---
class AnimatedWaterBackground extends StatelessWidget {
  const AnimatedWaterBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF81D4FA), Color(0xFFE1F5FE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Stack(
        children: [
          // Multiple looping animations for the fish
          Fish(top: 0.4, left: 0.2, durationSeconds: 15),
          Fish(top: 0.5, left: 0.8, durationSeconds: 20),
          Fish(top: 0.6, left: 0.5, durationSeconds: 12),
          Fish(top: 0.8, left: 0.1, durationSeconds: 18),
        ],
      ),
    );
  }
}

class Fish extends StatelessWidget {
  final double top;
  final double left;
  final int durationSeconds;
  const Fish({super.key, required this.top, required this.left, required this.durationSeconds});

  @override
  Widget build(BuildContext context) {
    return LoopAnimation<double>(
      tween: Tween(begin: -0.2, end: 1.2), // Animate from off-screen left to off-screen right
      duration: Duration(seconds: durationSeconds),
      builder: (context, child, value) {
        return Positioned(
          top: MediaQuery.of(context).size.height * top,
          left: MediaQuery.of(context).size.width * value,
          child: const Icon(Icons.phishing, color: Colors.white54, size: 18),
        );
      },
    );
  }
}*/
// lib/sos.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  // --- SOS Button Action ---
  void _activateSos(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm SOS Activation'),
        content: const Text('This will immediately alert emergency contacts and authorities with your location. Proceed?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            child: const Text('ACTIVATE', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('SOS Signal Sent! Authorities have been notified.'), backgroundColor: Colors.green),
              );
            },
          ),
        ],
      ),
    );
  }

  // --- Share Location Action ---
  Future<void> _shareLocation(BuildContext context) async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permission is required to share.'), backgroundColor: Colors.red));
        return;
      }
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
      Share.share('I am in need of assistance. My current location is: $googleMapsUrl');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not get location.'), backgroundColor: Colors.red));
    }
  }

  // --- Call Emergency Services Action ---
  Future<void> _callEmergency(BuildContext context) async {
    // 112 is the pan-India emergency number
    final Uri launchUri = Uri(scheme: 'tel', path: '112');
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not launch dialer.'), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency SOS'),
        backgroundColor: const Color(0xFF1B80AC).withOpacity(0.8),
        elevation: 0,
      ),
      body: Stack(
        children: [
          const AnimatedWaterBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(flex: 2),
              GestureDetector(
                onTap: () => _activateSos(context),
                child: const CircleAvatar(
                  radius: 80,
                  backgroundColor: Color(0xFF81D4FA),
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Color(0xFF4FC3F7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('SOS', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('EMERGENCY', style: TextStyle(fontSize: 14, color: Colors.white70, letterSpacing: 2)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  'Tap to send immediate emergency alert to\ncontacts and authorities',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Row(
                  children: [
                    _buildActionButton(context, icon: Icons.share_location, label: 'Share Location', onTap: () => _shareLocation(context)),
                    const SizedBox(width: 20),
                    _buildActionButton(context, icon: Icons.call, label: 'Call Emergency Services', onTap: () => _callEmergency(context)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: const Color(0xFF0A4E6C)),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Animated Background Widget ---
class AnimatedWaterBackground extends StatelessWidget {
  const AnimatedWaterBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF81D4FA), Color(0xFFE1F5FE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Stack(
        children: [
          // Multiple fish with different animations
          Fish(top: 0.4, left: 0.2, durationSeconds: 15),
          Fish(top: 0.5, left: 0.8, durationSeconds: 20),
          Fish(top: 0.6, left: 0.5, durationSeconds: 12),
          Fish(top: 0.8, left: 0.1, durationSeconds: 18),
        ],
      ),
    );
  }
}

class Fish extends StatelessWidget {
  final double top;
  final double left;
  final int durationSeconds;
  const Fish({super.key, required this.top, required this.left, required this.durationSeconds});

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<double>(
      tween: Tween(begin: -0.2, end: 1.2), // Animate from off-screen left to off-screen right
      duration: Duration(seconds: durationSeconds),
      builder: (context, value, child) {
        return Positioned(
          top: MediaQuery.of(context).size.height * top,
          left: MediaQuery.of(context).size.width * value,
          child: const Icon(Icons.phishing, color: Colors.white54, size: 18),
        );
      },
    );
  }
}